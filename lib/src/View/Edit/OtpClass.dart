import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';

import 'package:vutha_app/src/Controller/LogInAndRegistation/RegistationController.dart'
    as controller;
import 'package:vutha_app/src/Controller/UpdateNumberAndPassword//OtpController/OtpController.dart'
    as otp_controller;

class Otp_Code extends StatefulWidget {
  final otp_id;

  Otp_Code({
    this.otp_id,
  });

  @override
  _Otp_CodeState createState() => _Otp_CodeState();
}

class _Otp_CodeState extends State<Otp_Code> {
  var _otp_code_contoller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print("SMS OTP  ${widget.otp_id}");

    final provider = Provider.of<ChangePasswordAndNumberProvider>(context);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        borderSide: BorderSide(color: Color(0xffD8D8D8)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD8D8D8)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 13.0, right: 13.0, top: 30),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        provider.setLoading(true);

                        if (_otp_code_contoller.value.text.isNotEmpty) {
                          otp_controller.OTPsignUp(widget.otp_id,
                              _otp_code_contoller, context, provider);
                        } else {
                          Scaffold.of(context).showSnackBar(
                              new SnackBar(content: Text("Empty!!!")));
                        }
                      },
                      color: Colors.orange,
                      child: Text(
                        "Validate OTP",
                        style: TextStyle(color: Color(0xffEAEBF2)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Consumer<ChangePasswordAndNumberProvider>(
              builder: (context, provider, _) {
                if (provider.updateing) {
                  return Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(
                      radius: 30,
                    ),
                  ));
                } else {
                  return Container();
                }
              },
            )
          ],
        )),
      ),
    );
  }
}
