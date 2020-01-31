import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapActivity extends StatefulWidget {
  @override
  _MapActivityState createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  Completer<GoogleMapController> _controller;

  var lat, lan = 0.0;

  bool var_check_for_help = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = Completer();

    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildGoogleMap(context),
            var_check_for_help == false
                ? _build_topics()
                : _requesting_for_help(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    _chnageUpdate_location();

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (position != null) {
      print("My Position  ${position.longitude}");

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15)));
    }
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
          target: LatLng(position.latitude, position.longitude), zoom: 15)));
    });
  }

  _build_text() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        "Lat =   ${lat}  +  Lan =  ${lan} ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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


                          var_check_for_help = true;

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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
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
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
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

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[

            Container(

              // height: 200,

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
                child: Column(

                  // mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hold the button below until a request is made and the closest private security will immediately be dispatched to your location",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,

                          letterSpacing: 0.5

                      ),),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 13.0, top: 30),
                      child: ButtonTheme(
                       // buttonColor: Colors.orange,
                        minWidth: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          color: Colors.orange,
                          child: Text(
                            "HELP!",
                            style: TextStyle(color: Color(0xffEAEBF2)),
                          ),
                        ),
                      ),
                    ),


                  ],

                ),
              ),

            ),

          ],
        ),
      ),
    );
  }
}
