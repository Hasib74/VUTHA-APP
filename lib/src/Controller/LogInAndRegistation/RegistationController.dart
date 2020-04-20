import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/Otp_Code.dart';
import 'package:vutha_app/src/View/Map/MapActivity.dart';

void sign_up(
    _check_value,
    _password_controller,
    _confirm_password_controller,
    _name_controller,
    _surName_controller,
    _email_controller,
    _phone_controller,
    _date_of_birth_controller,
    _scaffoldKey,
    Function startLoading,
    Function stopLoading,
    context,
    country_code) {
  if (_check_value) {
    if (_password_controller.value.text != null &&
        _password_controller.value.text ==
            _confirm_password_controller.value.text &&
        _password_controller.value.text.length > 5) {
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

        stopLoading();
        verifyPhone(
            _name_controller,
            _email_controller,
            _surName_controller,
            _phone_controller,
            _password_controller,
            stopLoading,
            context,
            country_code);
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
        'Password is not matched  !',
        style: TextStyle(color: Colors.red),
      )));
    }
  } else {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
      'Please checked the trams and condition',
      style: TextStyle(color: Colors.red),
    )));
  }
}

Future<void> verifyPhone(
    _name_controller,
    _email_controller,
    _surName_controller,
    _phone_controller,
    _password_controller,
    Function stopLoading(),
    context,
    country_code) async {
  // print("Number code" + _current_country_code);

  final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
    if (verId != null) {
      print("AAAAAA $verId");

      stopLoading();

      /*Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => Otp_Code(
                  otp_id: verId,
                  name: _name_controller.text,
                  email: _email_controller.text,
                  surname: _surName_controller.text,
                  phoneNumber: _phone_controller.text,
                )));*/

      routes.normalRoute(
          context,
          Otp_Code(
            otp_id: verId,
            name: _name_controller.text,
            email: _email_controller.text,
            surname: _surName_controller.text,
            phoneNumber: _phone_controller.text,
          ));
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

            /*setState(() {
              loading = false;
            });*/

            stopLoading();

            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => Otp_Code(
                      otp_id: verId,
                      name: _name_controller.text,
                      email: _email_controller.text,
                      surname: _surName_controller.text,
                      phoneNumber: _phone_controller.text,
                      password: _password_controller.value.text,
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

    stopLoading();
  }
}

Future<String> testSignInWithPhoneNumber(otp_id, _otp_code_contoller, context,
    Function startLoading, Function stopLoading) async {
  String status;

  AuthCredential credential = PhoneAuthProvider.getCredential(
    verificationId: otp_id,
    smsCode: _otp_code_contoller.value.text,
  );
  await FirebaseAuth.instance.signInWithCredential(credential).then((v) {
    print(
        "..............................................  ${v.user.phoneNumber} ");

    if (v.user.phoneNumber != null) {
      status = v.user.phoneNumber;

      print("Sattus  ${status}");
    } else {
      status = "error";

      stopLoading();

      routes.back(context);
    }
  }).catchError((err) {
    print(err);
    status = "error";

    stopLoading();
  });

  _otp_code_contoller.text = '';
  return status;
}

OTPsignUp(name, surname, email, dateOfBirth, password, otp_id,
    _otp_code_contoller, context, startLoading, stopLoading) {
  testSignInWithPhoneNumber(
          otp_id, _otp_code_contoller, context, startLoading, stopLoading)
      .then((number) {
    print(number);

    if (number != "error") {
      FirebaseDatabase.instance
          .reference()
          .child(Common.USER)
          .child(number)
          .set({
        "Name": name + " " + surname,
        "Email": email,
        "DOF": dateOfBirth,
        "Password": password
      }).then((value) => _navigateToOtherActivity(number, context));
    } else {
      Navigator.of(context).pop();
    }
  }).catchError((e) {
    print(e);

    stopLoading();
  });
}

_navigateToOtherActivity(number, context) {
  Functions.fun_addLogInInfoToSharePrefarance(number).then((value) {
    print(value);

    /* Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => MapActivity(
              number: number,
            )),
            (Route<dynamic> route) => false);*/

    routes.routeAndRemovePreviousRoute(
        context,
        MapActivity(
          number: number,
        ));
  });
}
