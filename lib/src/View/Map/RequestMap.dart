import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Middleware/MasterCode.dart';
import 'package:vutha_app/src/Model/NotificationData.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Route/Routs.dart';
import 'package:vutha_app/src/Utls/Common.dart';

import 'package:vutha_app/src/Controller/MapController/RequestManController.dart'
    as controller;
import 'package:vutha_app/src/View/MasterCode/MasterCodeAuthentication.dart';

class RequestMap extends StatefulWidget {
  @override
  _RequestMapState createState() => _RequestMapState();
}

class _RequestMapState extends State<RequestMap> {
  Completer<GoogleMapController> _controller = new Completer();
  final Set<Marker> _markers = {};

  var lat, lan = 0.0;

  bool var_check_for_help = false;

  var help_type;

  double var_pading = 15.0;

  bool isHelp = false;

  var status;

  var TAG = "TAG";

  bool isServiceActive = false;

  //  ActiveService activeService;

  var distance;
  var duration;
  var userName = "Hasib";

  User user;

  LatLng requestLocation;

  @override
  void initState() {
    // TODO: implement initState

    // User user;

    controller.loadUser().then((value) => user = value);
    /*_chnageUpdate_location();*/

    controller.chnageUpdate_location(_controller, changePosition);

    controller.checkRequestedBefor(chnageUi);

    //checkRequestedBefor();

    super.initState();
  }

  changePosition() {
    setState(() {
      lan = controller.lat;

      lat = controller.lan;
    });
  }

  chnageUi() {
    setState(() {
      var_check_for_help = controller.var_check_for_help;

      help_type = controller.help_type;

      isHelp = controller.isHelp;

      requestLocation = controller.requestLocation;
    });
  }

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
    return Stack(
      children: <Widget>[
        _buildGoogleMap(context),
        var_check_for_help == false ? _build_topics() : _requesting_for_help(),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 14),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  _build_topics() {
    return Positioned(
      bottom: 0.0,
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          var_pading = 0.0;
                          var_check_for_help = true;
                          help_type = "Ambulance";
                        });
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.orange, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                          )
                        ]),
                        height: 35,
                        child: Center(
                            child: Text(
                          "Ambulance",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          var_check_for_help = true;

                          help_type = "Security";
                        });
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.orange, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                          )
                        ]),
                        height: 35,
                        child: Center(
                            child: Text(
                          "Security",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          var_check_for_help = true;

                          help_type = "Home Assist";
                        });
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.orange, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                          )
                        ]),
                        height: 35,
                        child: Center(
                            child: Text(
                          "Home Assist",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          var_check_for_help = true;

                          help_type = "Rode Side";
                        });
                      },
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.orange, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                          )
                        ]),
                        height: 35,
                        child: Center(
                            child: Text(
                          "Rode Side",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _requesting_for_help() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedPadding(
        padding: EdgeInsets.all(15),
        duration: new Duration(seconds: 2),
        curve: Curves.bounceIn,
        child: Wrap(
          children: <Widget>[
            Container(
              /*   // height: 200,
                duration: Duration(seconds: 2),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.fastOutSlowIn,*/

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: <Widget>[
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 8, right: 8, bottom: 8),
                          child: isHelp == false
                              ? Text(
                                  "Hold the button below until a request is made and the closest private security will immediately be dispatched to your location",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.5),
                                )
                              : Text(
                                  "You have requested for  ${help_type} .But if you want to cancel request please tab the cancel button .Thanks",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.5),
                                ),
                        ),
                        isHelp == false
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0,
                                    right: 13.0,
                                    top: 30,
                                    bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    print("Current location  ${lat} , $lan ");

                                    setState(() {
                                      isHelp = true;
                                    });

                                    controller.firebase_request_for_help(
                                        user.name, help_type);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Center(
                                        child: Text(
                                      "Help!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 13.0,
                                    right: 13.0,
                                    top: 30,
                                    bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      var_check_for_help = false;

                                      isHelp = false;
                                    });

                                    controller.firebase_cancel_request();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                          )
                                        ]),
                                    child: Center(
                                        child: Text(
                                      "Cancel Help",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ))
                      ],
                    ),
                    isHelp == false
                        ? Positioned(
                            top: 5,
                            right: 5,
                            child: InkWell(
                                onTap: () {
                                  setState(() {
                                    var_check_for_help = false;
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                )),
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
