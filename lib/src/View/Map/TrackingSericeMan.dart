import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Controller/MapController/TrackingServiceManController.dart'
    as controller;
import 'package:vutha_app/src/Model/ActiveService.dart';

class TrackingServiceMan extends StatefulWidget {
  ActiveService activeService;

  TrackingServiceMan({this.activeService});

  @override
  _TrackingServiceManState createState() => _TrackingServiceManState();
}

class _TrackingServiceManState extends State<TrackingServiceMan> {
  var comments_controller = TextEditingController();
  Completer<GoogleMapController> _controller = new Completer();
  final Set<Marker> _markers = {};

  var distance;
  var duration;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addMarker(_markers, widget.activeService);

    controller.getDistanceAndDuration(
        widget.activeService, changeDistanceAndDuration);
  }

  changeDistanceAndDuration() {
    setState(() {
      this.distance = controller.distance;
      this.duration = controller.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          // activeService(),

          activeCard(),

          isLoading
              ? Positioned.fill(
                  child: Align(
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                ))
              : Container(),
        ],
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
          _moveCamera();
        },
      ),
    );
  }

  activeCard() {
    return Positioned.fill(
      bottom: 30,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: 200,
          decoration:
              BoxDecoration(color: Colors.white.withOpacity(0.6), boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 1),
          ]),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _showDialog(context, "confirm");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(1.0),
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
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _showDialog(context, "cancle");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(1.0),
                            ),
                            child: Center(
                              child: Text(
                                "Cancle",
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

  void _moveCamera() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(widget.activeService.userlat, widget.activeService.userLan),
        zoom: 14)));
  }

  _showDialog(context, type) async {
    await showDialog<String>(
      context: context,
      child: new CupertinoAlertDialog(
        content: Text(
          type == "confirm" ? "You want to confirm ?" : " You want to cancle ?",
          style: TextStyle(
              color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //////////////////////

                Navigator.pop(context);

              }),
          new FlatButton(
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                //////////////////////

                type == "confirm" ? confirmAction() : cancleAction();
              })
        ],
      ),
    );
  }

  confirmAction() {
    setState(() {
      isLoading = true;
    });

    controller.confirm(widget.activeService).then((value) {
      if (value) {
        setState(() {
          isLoading = false;
        });

        Navigator.pop(context);
      }
    });
  }

  cancleAction() {
    setState(() {
      isLoading = true;
    });

    controller.cancle(widget.activeService).then((value) {
      if (value) {
        setState(() {
          isLoading = false;
        });

        Navigator.pop(context);
      }
    });
  }
}
