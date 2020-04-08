import 'package:flutter/material.dart';
import 'package:vutha_app/src/Display/Map/MapActivity.dart';
import 'package:vutha_app/src/LogInAndRegistation/Display.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Functions.fun_readLogInInfo().then((value) {
    if (value != null) {
      Common.user_number = value;

      print("Value  ${value} ");

      runApp(MaterialApp(
        home: MapActivity(number: value,),
      ));
    } else {
      runApp(MaterialApp(
        home: Display(),
      ));
    }
  });
}
