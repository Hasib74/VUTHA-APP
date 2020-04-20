import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/Controller/LogInAndRegistation/RegistationController.dart'
    as controller;
import 'package:vutha_app/src/View/LogInAndRegistation/Otp_Code.dart';

class RegsiationPage extends StatefulWidget {
  @override
  _RegsiationPageState createState() => _RegsiationPageState();
}

class _RegsiationPageState extends State<RegsiationPage> {
  var _name_controller = TextEditingController();
  var _surName_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _date_of_birth_controller = TextEditingController();
  var _phone_controller = TextEditingController();
  var _password_controller = TextEditingController();
  var _confirm_password_controller = TextEditingController();

  var _name_node = new FocusNode();
  var _surName_node = new FocusNode();
  var _email_node = new FocusNode();
  var _dateOfBirth_node = new FocusNode();
  var _phoeNumber_node = new FocusNode();
  var _password_node = new FocusNode();
  var _confirmPassword_node = new FocusNode();

  bool _check_value = false;
  var country_code = "+27";
  var actualCode;
  var verificationId;

  void _value1Changed(bool value) => setState(() => _check_value = value);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //_current_country();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: Stack(
            children: <Widget>[
              ColumWithSingUpTextAndTexFromAndButtonAndTrmasAndCondition(
                  context),
              Loading(),
            ],
          )),
    );
  }

  Column ColumWithSingUpTextAndTexFromAndButtonAndTrmasAndCondition(
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Image.asset("Img/piza.jpg"),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Sign up ",
            style: TextStyle(
                color: Color(0xff172E4B),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),

        TextFiledAndSignUpButtonWithTramsAndCondition(context),

        //  Spacer(),
      ],
    );
  }

  Expanded TextFiledAndSignUpButtonWithTramsAndCondition(BuildContext context) {
    return Expanded(
        child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _name_node,
            controller: _name_controller,
            textInputAction: TextInputAction.next,
            onSubmitted: (a) {
              _fieldFocusChange(context, _name_node, _surName_node);
            },
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Name',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _surName_node,
            controller: _surName_controller,
            textInputAction: TextInputAction.next,
            onSubmitted: (a) {
              _fieldFocusChange(context, _surName_node, _phoeNumber_node);
            },
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Surname',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _phoeNumber_node,
            keyboardType: TextInputType.number,
            controller: _phone_controller,
            textInputAction: TextInputAction.next,
            onSubmitted: (a) {
              _fieldFocusChange(context, _phoeNumber_node, _email_node);
            },
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],

              hintText: '',
              prefixIcon: SizedBox(
                child: Center(
                  widthFactor: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '${country_code}',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _email_node,
            controller: _email_controller,
            textInputAction: TextInputAction.next,
            onSubmitted: (a) {
              _fieldFocusChange(context, _email_node, _password_node);
            },
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Email',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _password_node,
            obscureText: true,
            controller: _password_controller,
            onSubmitted: (a) {
              _fieldFocusChange(context, _password_node, _confirmPassword_node);
            },
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Password',
              border: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: _confirmPassword_node,
            obscureText: true,
            controller: _confirm_password_controller,
            textInputAction: TextInputAction.next,
            onSubmitted: (a) {
              _fieldFocusChange(
                  context, _confirmPassword_node, _dateOfBirth_node);
            },
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
          child: TextField(
            controller: _date_of_birth_controller,

            /* onSubmitted: (a) {
              _fieldFocusChange(context, _phoeNumber_node, _email_node);
            },*/
            decoration: new InputDecoration(
              filled: true,
              //fillColor: Colors.grey[300],
              hintText: 'Date Of Birth',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FlatButton(
          onPressed: () {
            controller.sign_up(
                _check_value,
                _password_controller,
                _confirm_password_controller,
                _name_controller,
                _surName_controller,
                _email_controller,
                _phone_controller,
                _date_of_birth_controller,
                _scaffoldKey,
                startLoading(),
                stopLoading(),
                context,
                country_code);

            // sign_up();
          },
          child: new Container(
            margin: EdgeInsets.only(left: 0, right: 0),
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(color: Colors.orange),
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            new Checkbox(
              value: _check_value,
              onChanged: _value1Changed,
              activeColor: Colors.orange,
            ),
            Text(
              "Terms and conditions",
              style: TextStyle(color: Colors.black38, fontSize: 15),
            ),
          ],
        )
      ],
    ));
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

  startLoading() {
    setState(() {
      loading = true;
    });
  }

  stopLoading() {
    setState(() {
      loading = false;
    });
  }

/*  void _current_country() async {
    await FlutterSimCountryCode.simCountryCode.then((v) {
      print(v);

      //add the number format
      switch (v.toString()) {
        case "BD":
          setState(() {
            country_code = "+880";
          });

          break;
      }
    });
  }*/

  Loading() {
    return loading
        ? Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: SpinKitCircle(
                color: Colors.orange,
                size: 60,
              ),
            ),
          )
        : Container();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
