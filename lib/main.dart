import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Controller/SpController/SpController.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/InitialPage.dart';
import 'package:vutha_app/src/View/Map/MapActivity.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Functions.fun_readLogInInfo().then((value) {

    print("Valuee  ===  ${value}");
    if (value != null) {
      Common.user_number = value;

      print("Value  ${value} ");

      runApp(MaterialApp(
        home: MapActivity(
          number: value,
        ),
      ),);
    } else {
      runApp(MaterialApp(
        home: InitialPage(),
      ));
    }
  });
}
