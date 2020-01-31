import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vutha_app/src/LogInAndRegistation/Otp_Code.dart';

class RegsiationPage extends StatefulWidget {
  @override
  _RegsiationPageState createState() => _RegsiationPageState();
}

class _RegsiationPageState extends State<RegsiationPage> {
  var _name_controller = TextEditingController();
  var _surName_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _date_of_birth_controller = TextEditingController();
  var _phone_controller = TextEditingController();

  bool _check_value = false;
  var country_code;
  var actualCode;
  var verificationId;

  void _value1Changed(bool value) => setState(() => _check_value = value);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _current_country();
  }

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);

    // print("Codeeeeeeeeeeeeeeee   ${country_code}");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,


              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height -
                        (_appBar().preferredSize.height + 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Image.asset("Img/piza.jpg"),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Sign up ",
                            style: TextStyle(
                                color: Color(0xff172E4B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _name_controller,
                                decoration: new InputDecoration(
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                  hintText: 'Name',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _surName_controller,
                                decoration: new InputDecoration(
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                  hintText: 'Surname',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _phone_controller,
                                decoration: new InputDecoration(
                                  filled: true,
                                  //fillColor: Colors.grey[300],

                                  hintText: '',
                                  prefixIcon: SizedBox(
                                    child: Center(
                                      widthFactor: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          '${country_code}',
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _email_controller,
                                decoration: new InputDecoration(
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                  hintText: 'Email',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _date_of_birth_controller,
                                decoration: new InputDecoration(
                                  filled: true,
                                  //fillColor: Colors.grey[300],
                                  hintText: 'Date Of Birth',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton(
                              onPressed: () {
                                _sign_up();
                              },
                              child: new Container(
                                margin: EdgeInsets.only(left: 0, right: 0),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(color: Colors.orange),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Color(0xffFDEBE3),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Spacer(),

                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            new Checkbox(
                              value: _check_value,
                              onChanged: _value1Changed,
                              activeColor: Colors.orange,
                            ),
                            Text(
                              "Terms and conditions",
                              style:
                                  TextStyle(color: Colors.black38, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  loading
                      ? Align(



                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:100.0),
                            child: SpinKitCircle(
                              color: Colors.orange,
                              size: 60,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: InkWell(
          onTap: () {
            _back();
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
    );
  }

  void _current_country() async {
    await FlutterSimCountryCode.simCountryCode.then((v) {
      print(v);

      switch (v.toString()) {
        case "BD":
          setState(() {
            country_code = "+880";
          });

          break;
      }
    });
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _sign_up() {
    if (_check_value) {
      if (_name_controller.value.text.isEmpty &&
          _surName_controller.value.text.isEmpty &&
          _email_controller.value.text.isEmpty &&
          _phone_controller.value.text.isEmpty &&
          _date_of_birth_controller.value.text.isEmpty) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text(
          'Empty Fields !',
          style: TextStyle(color: Colors.red),
        )));
      } else {
        //_sendCodeToPhoneNumber();

        setState(() {
          loading = true;
        });

        verifyPhone();
      }
    } else {
      new SnackBar(
          content: new Text(
        'Please check Terms and conditions',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  Future<void> verifyPhone() async {
    // print("Number code" + _current_country_code);

    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      if (verId != null) {
        print("AAAAAA $verId");

        setState(() {
          loading = false;
        });

        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => Otp_Code(
                  otp_id: verId,
                  name: _name_controller.text,
                  email: _email_controller.text,
                  surname: _surName_controller.text,
                  phoneNumber: _phone_controller.text,
                )));
      }
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: country_code + _phone_controller.value.text,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            if (verId != null) {
              print("BBBBB $verId");

              setState(() {
                loading = false;
              });

              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => Otp_Code(
                        otp_id: verId,
                        name: _name_controller.text,
                        email: _email_controller.text,
                        surname: _surName_controller.text,
                        phoneNumber: _phone_controller.text,
                      )));
            }
          },
          codeSent: smsOTPSent,
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      print("Errorrrrr  $e");

      setState(() {
        loading = false;
      });
    }
  }
}
