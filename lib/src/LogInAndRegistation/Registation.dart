import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

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

  bool _value = false;

  var country_code;

  void _value1Changed(bool value) => setState(() => _value = value);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Locale myLocale = Localizations.localeOf(context);

    // print("Codeeeeeeeeeeeeeeee   ${country_code}");
    _current_country();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                (_appBar().preferredSize.height + 25),
            child: Column(
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

                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _name_controller,
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
                        controller: _surName_controller,
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
                        controller: _phone_controller,
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
                                  '${country_code}' ,

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
                        controller: _email_controller,
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
                        controller: _date_of_birth_controller,
                        obscureText: true,
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
                    Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.orange),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color(0xffFDEBE3),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),

                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    new Checkbox(
                      value: _value,
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
            ),
          ),
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
            _back();
          },
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
    );
  }

  void _current_country() async {
    await FlutterSimCountryCode.simCountryCode.then((v) {
      print(v);

      switch (v.toString()) {
        case "BD":
          setState(() {
            country_code = "+880";
          });

          break;
      }
    });
  }

  void _back() {
    Navigator.of(context).pop();
  }
}
