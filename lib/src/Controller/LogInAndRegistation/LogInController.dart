import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Controller/SpController/SpController.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/View/Map/MapActivity.dart';

bool logIn(_number_controller, _password_controller, _scaffoldKey, context) {
  if (_number_controller.value.text.isEmpty &&
      _password_controller.value.text.isEmpty) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
      'Empty Fields !',
      style: TextStyle(color: Colors.red),
    )));

    return false;
  } else {
    //_sendCodeToPhoneNumber();

    logInWithNumberAndPassword("+27" + _number_controller.value.text,
        _password_controller.value.text, context);

    return true;
  }
}

Future<void> logInWithNumberAndPassword(
    String number, String password, context) async {
  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(number)
      .once()
      .then((value) {
    if (value.value != null) {
      if (value.value["Password"] == password) {
        Functions.fun_addLogInInfoToSharePrefarance(number).then((value) {

          print("SPP  ${value}");

          Common.user_number = number;

          /*  Navigator.of(context).pushAndRemoveUntil(
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
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text("You arre not registared"),
              );
            });
      }
    }
  });
}
