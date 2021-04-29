import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Middleware/MasterCode.dart';
import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Route/Routs.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/View/Edit/ChangeNumber.dart';
import 'package:vutha_app/src/View/Edit/ChangePassword.dart';
import 'package:vutha_app/src/View/Edit/Widget/ChangeNumberWidget.dart';
import 'package:vutha_app/src/View/Edit/Widget/ChangePasswordWidget.dart';
import 'package:vutha_app/src/View/MasterCode/MasterCodeAuthentication.dart';

class ChnagePasswordAndUpdateDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordAndNumberProvider(),
      child: ChangePasswordAndNumber(),
    );
  }
}

class ChangePasswordAndNumber extends StatelessWidget {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    isMasterCodeChecked().then((value) {
      if (!value) {
        routeAndRemovePreviousRoute(
            context,
            MasterCode(
              number: Common.user.number,
            ));
      }
    });

    final provider = Provider.of<ChangePasswordAndNumberProvider>(context);

    print("valueeeeeeeeeeeeeee iss ${provider.password_or_number}");

    return SafeArea(
        child: new WillPopScope(
      onWillPop: () {
        // print("Back press");

        print("Back press iss ${provider.password_or_number}");

        if (provider.password_or_number.toString().endsWith("null")) {
          Navigator.of(context).pop();
          print("Back press");
        } else {
          provider.isPasswordOrNumber(null);

          print("Back press");
        }

        if (provider.loading) {
          provider.setLoading(false);
        }
        if (provider.password_status != null) {
          provider.setPasswordStatus(null);
        }
        if (provider.updateing) {
          provider.setUpdating(false);
        }
      },
      child: Scaffold(
        /* appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryColor,
            ),
          ),
        ),*/
        key: _globalKey,
        body: Stack(
          children: [
            //Positioned(top: 10, right: 10, child: Icon(Icons.close)),
            Consumer<ChangePasswordAndNumberProvider>(
              builder: (context, provider, child) {
                print("Provider Valuee ${provider.password_or_number}");

                if (provider.password_or_number == null) {
                  return Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ChangeNumberWidget(),
                          Padding(padding: EdgeInsets.all(8)),
                          ChangePasswordWidget(),
                        ],
                      ),
                    ),
                  );
                } else if (provider.password_or_number == "chnageNumber") {
                  return ChangeNumber();
                } else if (provider.password_or_number == "changePassword") {
                  return ChangePassword();
                }
              },
            ),
            Consumer<ChangePasswordAndNumberProvider>(
              builder: (c, provider, child) {
                print("Loading   ${provider.loading}");
                print("Error   ${provider.error}");

                if (provider.loading == true) {
                  return Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(
                      radius: 30,
                    ),
                  ));
                } else if (provider.error == true) {
                  //  SnackBarLauncher(error: "Error....");

                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _displaySnackBar(error: "Error..."));

                  return Container();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  void _displaySnackBar({@required String error}) {
    Builder(builder: (context) {
      //  Scaffold.of(context).showSnackBar(new SnackBar(content: Text("Error...")));

      _globalKey.currentState
          .showSnackBar(new SnackBar(content: Text("Error....")));
    });
  }
/* void showSnackbar() {

    _globalKey.currentState
        .showSnackBar(new SnackBar(content: Text("Error...")));

  }*/
}

class SnackBarLauncher extends StatelessWidget {
  final String error;

  const SnackBarLauncher({Key key, @required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _displaySnackBar(context, error: error));
    }
    // Placeholder container widget
    return Container();
  }

  void _displaySnackBar(BuildContext context, {@required String error}) {
    final snackBar = SnackBar(content: Text(error));
    // Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
