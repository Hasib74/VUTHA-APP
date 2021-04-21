import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Controller/UpdateNumberAndPassword/UpdatePasswordController.dart'
    as update_controller;
import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/View/Map/MapActivity.dart';

class ChangePassword extends StatelessWidget {
  var _previous_password = new TextEditingController();
  var _new_password = new TextEditingController();
  var _re_new_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePasswordAndNumberProvider>(context);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _previous_password,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  filled: true,
                  //fillColor: Colors.grey[300],
                  hintText: 'Previous Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _new_password,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  filled: true,
                  //fillColor: Colors.grey[300],
                  hintText: 'New Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _re_new_password,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  filled: true,
                  //fillColor: Colors.grey[300],
                  hintText: 'Confirm Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  updateBtnOperation(provider, context);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(color: AppColors.primaryColor, boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 1, spreadRadius: 1)
                  ]),
                  child: Center(
                      child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            ),
          ],
        ),
        Consumer<ChangePasswordAndNumberProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(
                  radius: 30,
                ),
              ));
            } else if (provider.password_status != null &&
                provider.password_status != "success") {
              return Positioned(
                  bottom: 0.0,
                  child: FutureBuilder(
                    future: Future.delayed(Duration(seconds: 3)),
                    builder: (c, s) => s.connectionState == ConnectionState.done
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.all(0.0),
                            child: new Container(
                              width: MediaQuery.of(context).size.width,
                              height: 20,
                              decoration: BoxDecoration(color: Colors.black),
                              child: Center(
                                child: Text(
                                  provider.password_status,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            )),

                    /*future:Future.delayed(Duration(seconds: 3) ,
                    builder: (context,data){

                      return Padding(
                          padding: EdgeInsets.all(0.0),
                          child: new Container(
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            decoration: BoxDecoration(color: Colors.black),
                            child: Center(
                              child: Text(
                                provider.password_status,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ));

                    },*/
                  ));
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }

  void updateBtnOperation(
      ChangePasswordAndNumberProvider provider, BuildContext context) {
    provider.setLoading(true);

    update_controller
        .validation(_previous_password.value.text, _new_password.value.text,
            _re_new_password.value.text)
        .then((value) {
      print("Value  ${value}");

      provider.setPasswordStatus(value);

      if (value == "success") {
        update_controller
            .updatePassword(_new_password.value.text)
            .then((value) {
          if (value) {
            provider.setLoading(false);
            routes.routeAndRemovePreviousRoute(context, MapActivity());
          } else {
            provider.setLoading(false);
            provider.setPasswordStatus("network");
          }
        });
      } else {
        provider.setLoading(false);
      }
    });
  }
}
