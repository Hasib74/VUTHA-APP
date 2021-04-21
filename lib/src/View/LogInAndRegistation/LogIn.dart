import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vutha_app/src/Controller/LogInAndRegistation/LogInController.dart'
    as controller;
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/Controller/Country/CountryCodeController.dart'
    as country_control;

class LogIn extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogIn> {
  var _number_controller = TextEditingController();
  var _password_controller = TextEditingController();

  var country_code;
  var actualCode;
  var verificationId;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    country_control.getCountry().then((value) {
      print("The value is  ${value}");
      if (value == "BD") {
        setState(() {
          country_code = "+88";
        });
      } else {
        setState(() {
          country_code = "+27";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height -
                          (_appBar().preferredSize.height + 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Image.asset("Img/piza.jpg"),

                          _title(),
                          _emailAndPasswordAndButton(),

                          loading ? _loading() : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _emailAndPasswordAndButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _number_controller,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              prefixIcon: SizedBox(
                child: Center(
                  widthFactor: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(country_code, style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: '',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _password_controller,
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Password',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
          onPressed: () {
            /* setState(() {
              loading = true;
            });
            */

            //_number_controller,_password_controller,_scaffoldKey , context

            if (controller.logIn(country_code, _number_controller,
                _password_controller, _scaffoldKey, context)) {
              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
          },
          child: new Container(
            margin: EdgeInsets.only(left: 0, right: 0),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Center(
              child: Text(
                "LogIn",
                style: TextStyle(
                    color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Log In",
        style: TextStyle(
            color: Color(0xff172E4B),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  _loading() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: SpinKitCircle(
          color: AppColors.primaryColor,
          size: 60,
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: InkWell(
          onTap: () {
            routes.back(context);
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
    );
  }
}
