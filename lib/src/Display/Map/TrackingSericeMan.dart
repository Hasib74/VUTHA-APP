import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/ApiService/MapApisIntregation.dart';
import 'package:vutha_app/src/Model/ActiveService.dart';

class TrackingServiceMan extends StatefulWidget {
  ActiveService activeService;

  TrackingServiceMan({this.activeService});

  @override
  _TrackingServiceManState createState() => _TrackingServiceManState();
}

class _TrackingServiceManState extends State<TrackingServiceMan> {
  Completer<GoogleMapController> _controller = new Completer();
  final Set<Marker> _markers = {};

  var distance;
  var duration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _addMarker();

    _getDistanceAndDuration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          // activeService(),

          activeCard(),
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
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            boxShadow: [


              BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 1),

            ]

          ),

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
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.2,
                        height: 40,

                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(1.0),
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
                  /*  Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.black,
                          size: 20,
                        ))*/
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addMarker() {
    _markers.add(Marker(
        markerId: MarkerId("userMarker"),
        infoWindow: InfoWindow(title: "You"),
        position: new LatLng(
            widget.activeService.userlat, widget.activeService.userLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(17)));
    _markers.add(Marker(
        markerId: MarkerId("userMarker"),
        infoWindow: InfoWindow(title: "Service Man"),
        position: new LatLng(widget.activeService.serviceManLat,
            widget.activeService.serviceManLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(10)));
  }

  void _getDistanceAndDuration() {
    GoogleMapsServices()
        .getDistance(
            LatLng(widget.activeService.userlat, widget.activeService.userLan),
            LatLng(widget.activeService.serviceManLat,
                widget.activeService.serviceManLan))
        .then((value) {
      setState(() {
        distance = value[0]["distance"]["text"];
        duration = value[0]["duration"]["text"];
      });
    });
  }

  void _moveCamera() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(widget.activeService.userlat, widget.activeService.userLan),
        zoom: 14)));
  }
}
