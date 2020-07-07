import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Controller/SpController/SpController.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/InitialPage.dart';
import 'package:vutha_app/src/View/Map/MapActivity.dart';

import 'package:vutha_app/src/Middleware/MasterCode.dart'
    as master_code_middleware;
import 'package:vutha_app/src/View/MasterCode/MasterCodeAuthentication.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Functions.fun_readLogInInfo().then((value) {
    print("Valuee  ===  ${value}");
    if (value != null) {
      Common.user_number = value;

      print("Value  ${value} ");

      master_code_middleware.isRegisterMiddleWare().then((value) {
        if (value) {
          master_code_middleware.isMasterCodeChecked().then((value) {
            if (value) {
              runApp(
                MaterialApp(
                  home: MapActivity(
                    number: Common.user_number,
                  ),
                ),
              );
            } else {
              runApp(
                MaterialApp(
                  home: MasterCode(
                    number: Common.user_number,
                  ),
                ),
              );
            }
          });
        } else {
          runApp(MaterialApp(
            home: InitialPage(),
          ));
        }
      });
    } else {
      runApp(MaterialApp(
        home: InitialPage(),
      ));
    }
  });
}
