import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Model/ActiveService.dart';
import 'package:vutha_app/src/Utls/ApiService/MapApisIntregation.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Controller/NotificationController/NotificationController.dart' as notification_controller;


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



Future<bool> confirm(ActiveService activeService) async {

 await  FirebaseDatabase.instance.reference().child(Common.HISTORY).child(Common.user_number).push().set({
    "serviceManNumber" : activeService.serviceManNumber,
    "serviceType" :Common.help_request,
    "date" : "${new DateTime.now().day} / ${new DateTime.now().month} / ${new DateTime.now().year}",
    "location" : {

      "lat" : activeService.userlat,
      "lan":activeService.userLan,
    }

  }).then((value) {


    FirebaseDatabase.instance.reference().child(Common.help_request).child(Common.user_number).remove();

    FirebaseDatabase.instance.reference().child(Common.SERVE).child(activeService.serviceManNumber).child(activeService.id).remove();

  });

 notification_controller.sendNotificationToAdmin("${Common.user.name} confirm the request", Common.help_request,"confirm");



 return true;
}


Future<bool> cancle(ActiveService activeService) async {



  

  await  FirebaseDatabase.instance.reference().child(Common.CANCLE).child(Common.user_number).push().set({
    "serviceManNumber" : activeService.serviceManNumber,
    "serviceType" :Common.help_request,
    "date" : "${new DateTime.now().day}/${new DateTime.now().month}/${new DateTime.now().year}",
    "location" : {

      "lat" : activeService.userlat,
      "lan":activeService.userLan,
    }

  }).then((value) {


    FirebaseDatabase.instance.reference().child(Common.help_request).child(Common.user_number).remove();

    FirebaseDatabase.instance.reference().child(Common.SERVE).child(activeService.serviceManNumber).child(activeService.id).remove();

  });


  notification_controller.sendNotificationToAdmin("${Common.user.name} cancel the request", Common.help_request,"cancle");


  return true;
}