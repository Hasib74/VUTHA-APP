import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/ApiService/MapApisIntregation.dart';
import 'package:vutha_app/src/Display/Drawer/NavigationDrawer.dart';
import 'package:vutha_app/src/Model/ActiveService.dart';
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

  ActiveService activeService;

  var distance;
  var duration;

  GlobalKey<ScaffoldState> _key = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _chnageUpdate_location();
  }

  @override
  Widget build(BuildContext context) {
    print("Map Activity");

    print(" ${TAG}  ${widget.number}");

    getActiveData().then((value) {
      if (value != null) {
        setState(() {
          //  print("${TAG}  value is  ${value.serviceManLat}");

          activeService = value;

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
    });

    closeDrawer() {

    //  if(_key.currentState.isDrawerOpen){

        _key.currentState.openEndDrawer();

      //}

    }

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: NavigationDrawer(
          MapActivity().key,
          closeDrawer,
          widget.number
        ),
        body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            // activeService(),

            activeService == null
                ? var_check_for_help == false
                    ? _build_topics()
                    : _requesting_for_help()
                : activeCard(),

            menuButton(),
          ],
        ),
      ),
    );
  }

  activeCard() {
    return Positioned.fill(
      bottom: 30,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white.withOpacity(0.6),
          width: MediaQuery.of(context).size.width / 1.1,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${distance == null ? "" : distance}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "${duration == null ? "" : duration}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Center(
                            child: Text(
                              "Confirm",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.black,
                          size: 20,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
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

  void _chnageUpdate_location() async {
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    final GoogleMapController controller = await _controller.future;

    geolocator.getPositionStream(locationOptions).listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      print(
          "Chnaging location  +  ${position.longitude} + ${position.latitude} ");

      setState(() {
        lan = position.longitude;

        lat = position.latitude;
      });

      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14)));
    });
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

                                    _firebase_request_for_help();
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
                                      isHelp = false;
                                    });

                                    _firebase_cancel_request();
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

  void _firebase_request_for_help() {
    print("Phone number  ${Common.user_number}");

    FirebaseDatabase.instance
        .reference()
        .child(Common.help_request)
        .child(Common.user_number)
        .set({
      "request_type": help_type,
      "location": {
        "lat": lat,
        "lan": lan,
      }
    }).then((value) {
      //status = "requesting";
    }).catchError((err) {
      print("Error  ${err}");
    });
  }

  void _firebase_cancel_request() {
    FirebaseDatabase.instance
        .reference()
        .child(Common.help_request)
        .child(Common.user_number)
        .remove()
        .then((value) => print("remove"))
        .catchError((err) => print("Error  ${err}"));
  }

  menuButton() {
    return InkWell(
      onTap: () {
        if (_key.currentState.isDrawerOpen) {
          _key.currentState.openEndDrawer();
        } else {
          _key.currentState.openDrawer();
        }
      },
      child: Positioned(
        top: 15,
        left: 15,
        child: Icon(
          Icons.menu,
          color: Colors.orange,
          size: 30,
        ),
      ),
    );
  }

  Future<ActiveService> getActiveData() async {
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
            print("${TAG}     ========================");

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
  }

  void getDistanceAndDuration(ActiveService activeService) {
    GoogleMapsServices()
        .getDistance(LatLng(activeService.userlat, activeService.userLan),
            LatLng(activeService.serviceManLat, activeService.serviceManLan))
        .then((value) {
      setState(() {
        distance = value[0]["distance"]["text"];
        duration = value[0]["duration"]["text"];
      });
    });
  }
}
