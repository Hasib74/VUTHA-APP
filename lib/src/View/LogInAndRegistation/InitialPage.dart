import 'package:flutter/material.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/LogIn.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/Registation.dart';
import 'package:vutha_app/src/Route/Routs.dart' as Routes;

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffFFFFFF),
            body: Stack(
              children: <Widget>[
                Positioned(
                    top: 70,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "AFRIMUTUAL",
                        style: TextStyle(
                            color: Color(0xff0D0F13),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )),

                //logo

                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 140.0),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "Img/logo.jpg",
                        ),
                        Positioned(
                            bottom: 30,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "SWIFT GUARD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  ),
                ),

                //button

                Positioned(
                  bottom: 130,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //Log in ...
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              //  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> LogIn()));

                              Routes.normalRoute(context, LogIn());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.orange),
                                child: Text(
                                  "Log In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //Regulation ...

                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              //  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>new RegsiationPage()));
                              Routes.normalRoute(context, RegsiationPage());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.orange),
                                child: Text(
                                  "Registation",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                    bottom: 90,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black54),
                        ))),

                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Powered by AFRIMUTUAL",
                          style: TextStyle(color: Colors.black38)),
                    ))
              ],
            )),
      ),
    );
  }
}
