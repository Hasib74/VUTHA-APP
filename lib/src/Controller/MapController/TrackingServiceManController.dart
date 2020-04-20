import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Utls/ApiService/MapApisIntregation.dart';


var distance;
var duration;

void addMarker(_markers , activeService ) {
  _markers.add(Marker(
      markerId: MarkerId("userMarker"),
      infoWindow: InfoWindow(title: "You"),
      position: new LatLng(
          activeService.userlat, activeService.userLan),
      icon: BitmapDescriptor.defaultMarkerWithHue(17)));
  _markers.add(Marker(
      markerId: MarkerId("userMarker"),
      infoWindow: InfoWindow(title: "Service Man"),
      position: new LatLng(activeService.serviceManLat,
          activeService.serviceManLan),
      icon: BitmapDescriptor.defaultMarkerWithHue(10)));
}

void getDistanceAndDuration(activeService ,Function changeDistanceAndDuration) {
  GoogleMapsServices()
      .getDistance(
      LatLng(activeService.userlat, activeService.userLan),
      LatLng(activeService.serviceManLat,
          activeService.serviceManLan))
      .then((value) {
    //setState(() {
      distance = value[0]["distance"]["text"];
      duration = value[0]["duration"]["text"];
    //});

      changeDistanceAndDuration();
  });
}


