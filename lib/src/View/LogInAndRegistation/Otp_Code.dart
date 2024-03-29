import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';

import 'package:vutha_app/src/Controller/LogInAndRegistation/RegistationController.dart'
    as controller;

class Otp_Code extends StatefulWidget {
  final otp_id;
  final name;
  final surname;
  final email;
  final dateOfBirth;
  final phoneNumber;
  final password;

  Otp_Code(
      {this.otp_id,
      this.name,
      this.phoneNumber,
      this.email,
      this.dateOfBirth,
      this.surname,
      this.password});

  @override
  _Otp_CodeState createState() => _Otp_CodeState();
}

class _Otp_CodeState extends State<Otp_Code> {
  var _otp_code_contoller = TextEditingController();

  // FirebaseAuth _auth;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print("SMS OTP  ${widget.otp_id}");

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset("Img/logo.jpg")),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: new TextField(
                            controller: _otp_code_contoller,
                            decoration: InputDecoration(
                              hintText: "Enter OTP Code",
                              labelText: "Enter OTP",
                              hintStyle: TextStyle(color: Colors.black12),
                              labelStyle: TextStyle(color: Color(0xff424242)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffD8D8D8)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffD8D8D8)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 13.0, right: 13.0, top: 30),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });

                                controller.OTPsignUp(
                                    widget.name,
                                    widget.surname,
                                    widget.email,
                                    widget.dateOfBirth,
                                    widget.password,
                                    widget.otp_id,
                                    _otp_code_contoller,
                                    context,
                                    startLoading,
                                    stopLoading);
                              },
                              color: AppColors.primaryColor,
                              child: Text(
                                "Validate OTP",
                                style: TextStyle(color: Color(0xffEAEBF2)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            loading
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: SpinKitCircle(
                        color: AppColors.primaryColor,
                        size: 60,
                      ),
                    ),
                  )
                : Container(),
          ],
        )),
      ),
    );
  }

  startLoading() {
    setState(() {
      loading = true;
    });
  }

  stopLoading() {
    setState(() {
      loading = false;
    });
  }
}
