import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/ApiService/MapApisIntregation.dart';
import 'package:vutha_app/src/Display/Drawer/NavigationDrawer.dart';
import 'package:vutha_app/src/Display/Map/RequestMap.dart';
import 'package:vutha_app/src/Display/Map/TrackingSericeMan.dart';
import 'package:vutha_app/src/Model/ActiveService.dart';
import 'package:vutha_app/src/Model/NotificationData.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Notification/NotificationService.dart';
import 'package:vutha_app/src/Utls/Common.dart';

class MapActivity extends StatefulWidget {
  var number;

  MapActivity({this.number});

  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
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

  var userName = "Hasib";

  User user;

  GlobalKey<ScaffoldState> _key = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Map Activity");

    print(" ${TAG}  ${widget.number}");

/*    getActiveData().then((value) {
      if (value != null) {
        setState(() {
          //  print("${TAG}  value is  ${value.serviceManLat}");

          //activeService = value;

          Marker serviceManMarker = new Marker(
              infoWindow: InfoWindow(title: "Service"),
              markerId: MarkerId("serviceManMarker"),
              position: LatLng(value.serviceManLat, value.serviceManLan),
              icon: BitmapDescriptor.defaultMarkerWithHue(16));
          Marker userMarker = new Marker(
              infoWindow: InfoWindow(title: "My Location"),
              markerId: MarkerId("userMarker"),
              position: LatLng(value.userlat, value.userLan),
              icon: BitmapDescriptor.defaultMarkerWithHue(10));

          _markers.clear();

          _markers.add(userMarker);
          _markers.add(serviceManMarker);
        });

        getDistanceAndDuration(value);
      }
    });*/

    closeDrawer() {
      //  if(_key.currentState.isDrawerOpen){

      _key.currentState.openEndDrawer();

      //}
    }

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: NavigationDrawer(MapActivity().key, closeDrawer, widget.number),
        body: StreamBuilder(
            stream:
                FirebaseDatabase.instance.reference().child("Serve").onValue,
            builder: (context, snapshot) {


              if(snapshot.data == null){
                return Center(child: CircularProgressIndicator(),);
              }else{

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
                          serviceManNumber: serviceNumber);
                    }
                  });
                });

                if (activeService == null) {
                  return RequestMap();
                } else {
                  return TrackingServiceMan(activeService: activeService);
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

/*  Future<ActiveService> getActiveData() async {
    ActiveService activeService;

    await FirebaseDatabase.instance
        .reference()
        .child("Serve")
        .once()
        .then((value) {
      Map<dynamic, dynamic> _readAllService = value.value;

      _readAllService.forEach((serviceNumber, value) {
        Map<dynamic, dynamic> _myService = value;

        _myService.forEach((key, value) {
          print("Keyyyyy  ${key}");
          print("Valueeeeeeeeeeeeeee    ${value}");

          if (value["userNumber"] == widget.number) {
            activeService = new ActiveService(
                serviceManLan: value["serviceManLan"],
                serviceManLat: value["serviceManLat"],
                userLan: value["lan"],
                userlat: value["lat"],
                serviceManNumber: serviceNumber);
          }
        });
      });
    });

    return activeService;
  }*/

/*

  void sendNotification() {
    print("User Name   ${user.name}");

    FirebaseDatabase.instance
        .reference()
        .child(Common.TOKEN)
        .child(Common.ADMIN)
        .once()
        .then((value) {
      NotificationData notificationData = new NotificationData(
          data: Data(
              text: "Good",
              body: "${user.name} is requested for ${help_type}",
              title: "New Request",
              click_action: "newRequest"),
          to: value.value["token"]);

      NotificationService().sendRequest(notificationData);
    });
  }

  void _loadUser() {
    FirebaseDatabase.instance
        .reference()
        .child(Common.USER)
        .child(Common.user_number)
        .once()
        .then((value) {
      user = User(
          name: value.value["Name"],
          email: value.value["Email"],
          number: Common.user_number);
    });
  }*/
}
