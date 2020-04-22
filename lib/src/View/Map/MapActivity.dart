import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Controller/MapController/RequestManController.dart';

import 'package:vutha_app/src/Model/ActiveService.dart';
import 'package:vutha_app/src/Model/NotificationData.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/View/Drawer/NavigationDrawer.dart';
import 'package:vutha_app/src/View/Map/RequestMap.dart';
import 'package:vutha_app/src/View/Map/TrackingSericeMan.dart';

import 'package:vutha_app/src/Controller/NotificationController/NotificationController.dart' as notification_controller;
import 'package:vutha_app/src/Controller/MapController/MapActivityController.dart' as map_activity_controler;



class MapActivity extends StatefulWidget {
  var number;

  MapActivity({this.number});

  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  var lat, lan = 0.0;

  bool var_check_for_help = false;

  var help_type;

  double var_pading = 15.0;

  bool isHelp = false;

  var status;

  var TAG = "TAG";

  bool isServiceActive = false;

  var userName = "Hasib";

  User user;

  GlobalKey<ScaffoldState> _key = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    map_activity_controler.loadUser();

    notification_controller.registerNotification();
    notification_controller.configLocalNotification();
    notification_controller.configureSelectNotificationSubject(context);
  }

  @override
  Widget build(BuildContext context) {
    closeDrawer() {
      _key.currentState.openEndDrawer();
    }

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: NavigationDrawer(MapActivity().key, closeDrawer, widget.number),
        body: StreamBuilder(
            stream:
                FirebaseDatabase.instance.reference().child("Serve").onValue,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                ActiveService activeService;

                Map<dynamic, dynamic> _readAllService =
                    snapshot.data.snapshot.value;

                // Map<dynamic, dynamic> _readAllService = value.value;

                _readAllService.forEach((serviceNumber, value) {
                  Map<dynamic, dynamic> _myService = value;

                  _myService.forEach((key, value) {
                    if (value["userNumber"] == widget.number) {
                      print("Valueeeeeeeeeeeeeee    ${value}");

                      activeService = new ActiveService(
                          serviceManLan: value["serviceManLan"],
                          serviceManLat: value["serviceManLat"],
                          userLan: value["lan"],
                          userlat: value["lat"],
                          serviceManNumber: serviceNumber,

                          id: key,

                      );
                    }
                  });
                });

                if (activeService == null) {
                  return Stack(
                    children: [
                      RequestMap(),
                      menuButton(),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      TrackingServiceMan(activeService: activeService),
                      menuButton()
                    ],
                  );
                }
              }
            }),
      ),
    );
  }

  menuButton() {
    return Positioned(
      top: 15,
      left: 15,
      child: InkWell(
        onTap: () {
          if (_key.currentState.isDrawerOpen) {
            _key.currentState.openEndDrawer();
          } else {
            _key.currentState.openDrawer();
          }
        },
        child: Icon(
          Icons.menu,
          color: Colors.orange,
          size: 30,
        ),
      ),
    );
  }
}
