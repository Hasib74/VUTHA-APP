import 'package:flutter/material.dart';
import 'package:vutha_app/src/Display/Map/MapActivity.dart';
import 'package:vutha_app/src/LogInAndRegistation/Display.dart';
import 'package:vutha_app/src/LogInAndRegistation/ExtraInformation.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Functions.fun_readLogInInfo().then((value) {
    print("Value  ${value} ");

    if (value != null) {
      Common.user_number = value;

      runApp(MaterialApp(
        home: MapActivity(),
      ));
    } else {
      runApp(MaterialApp(
        home: Display(),
      ));
    }
  });
}
