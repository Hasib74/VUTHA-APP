import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Otp_Code extends StatefulWidget {
  final otp_id;
  final name;
  final surname;
  final email;
  final dateOfBirth;
  final phoneNumber;

  /*
  *   var _name_controller = TextEditingController();
  var _surName_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _date_of_birth_controller = TextEditingController();
  var _phone_controller = TextEditingController();

  *
  * */

  Otp_Code(
      {this.otp_id,
      this.name,
      this.phoneNumber,
      this.email,
      this.dateOfBirth,
      this.surname});

  @override
  _Otp_CodeState createState() => _Otp_CodeState();
}

class _Otp_CodeState extends State<Otp_Code> {
  var _otp_code_contoller = TextEditingController();

  FirebaseAuth _auth;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print("SMS OTP  ${widget.otp_id}");

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
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
                                  labelStyle:
                                      TextStyle(color: Color(0xff424242)),
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

                                    _testSignInWithPhoneNumber().then((v) {
                                      print(v);

                                      print(
                                          "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv  ${v}");

                                      if (v == "success") {
                                      } else {
                                        print(
                                            "Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrror");
                                      }
                                    }).catchError((e) {
                                      print(e);

                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                  },
                                  color: Color(0xff3D52B0),
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
        ),
      ),
    );
  }

  Future<String> _testSignInWithPhoneNumber() async {
    String status;

    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: widget.otp_id,
      smsCode: _otp_code_contoller.value.text,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((v) {
      print(
          "..............................................  ${v.user.phoneNumber} ");

      if (v.user.phoneNumber != null) {
        status = "success";
      } else {
        status = "error";

        Navigator.of(context).pop();

        setState(() {
          loading = false;
        });
      }
    }).catchError((err) {
      print(err);
      status = "error";

      setState(() {
        loading = false;
      });
    });

    _otp_code_contoller.text = '';
    return status;
  }
}
