import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/View/Edit/ChangePasswordOrNumber.dart';
import 'package:vutha_app/src/View/Edit/OtpClass.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/View/Map/MapActivity.dart';
import 'package:vutha_app/src/Controller/SpController/SpController.dart'
    as sp_controller;

Future<void> verifyPhone(phoneNumber, country_code, context, provider) async {
  // print("Number code" + _current_country_code);

  PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
    if (verId != null) {
      print("AAAAAAAAAAAAAAAAAAAAAAAAAA");

      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) =>
              ChangeNotifierProvider<ChangePasswordAndNumberProvider>(
                create: (_) => ChangePasswordAndNumberProvider(),
                child: new MaterialApp(
                  home: Otp_Code(
                    otp_id: verId,
                  ),
                ),
              )));
    }
  };

  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: country_code + phoneNumber,
      // PHONE NUMBER TO SEND OTP
      codeAutoRetrievalTimeout: (String verId) {
        //Starts the phone number verification process for the given phone number.
        //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
        if (verId != null) {
          provider.setError(true);
        }
      },
      codeSent: smsOTPSent,
      // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
      timeout: const Duration(seconds: 20),
      verificationCompleted: (AuthCredential phoneAuthCredential) {
        // print(phoneAuthCredential);
        // error();

        final peovider = Provider.of<ChangePasswordAndNumberProvider>(context);
        peovider.setLoading(false);
      },
      verificationFailed: (AuthException exception) {
        print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrroe $exception");

        provider.setLoading(false);
        provider.setError(true);
      });
}

OTPsignUp(otp_id, _otp_code_contoller, context, provider) {
  testSignInWithPhoneNumber(otp_id, _otp_code_contoller, context, provider)
      .then((number) {
    print(number);

    if (number != "error") {
      FirebaseDatabase.instance
          .reference()
          .child(Common.user_number)
          .once()
          .then((value) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.USER)
            .child(number)
            .set(value);

        FirebaseDatabase.instance
            .reference()
            .child(Common.USER)
            .child(Common.user_number)
            .remove();

        sp_controller.Functions.fun_addLogInInfoToSharePrefarance(number)
            .then((value) {
          provider.setLoading(false);

          Common.user_number = number;

          routes.routeAndRemovePreviousRoute(
              context,
              MapActivity(
                number: number,
              ));
        });
      });
    } else {
      Navigator.of(context).pop();
    }
  }).catchError((e) {
    print(e);
  });
}

Future<String> testSignInWithPhoneNumber(otp_id, _otp_code_contoller, context,
    ChangePasswordAndNumberProvider provider) async {
  String status;

  AuthCredential credential = PhoneAuthProvider.getCredential(
    verificationId: otp_id,
    smsCode: _otp_code_contoller.value.text,
  );
  await FirebaseAuth.instance.signInWithCredential(credential).then((v) {
    if (v.user.phoneNumber != null) {
      status = v.user.phoneNumber;

      print("Sattus  ${status}");
      provider.setLoading(false);
    } else {
      status = "error";
      provider.setLoading(false);
    }
  }).catchError((err) {
    print(err);
    status = "error";

    provider.setLoading(false);
  });

  _otp_code_contoller.text = '';
  return status;
}
