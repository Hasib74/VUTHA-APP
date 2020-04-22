import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Controller/NotificationController/NotificationController.dart'
    as notification_controller;

var lat;

var lan;

var var_check_for_help;
var help_type;
var isHelp;
LatLng requestLocation;

Future<User> loadUser() async {
  User user;

  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(Common.user_number)
      .once()
      .then((value) {
    user = User(
        name: value.value["Name"],
        email: value.value["Email"],
        number: Common.user_number);


    Common.user =user;
  });

  return user;
}

void chnageUpdate_location(_controller, Function changePosition) async {
  var geolocator = Geolocator();
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  final GoogleMapController controller = await _controller.future;

  geolocator.getPositionStream(locationOptions).listen((Position position) {
    print(position == null
        ? 'Unknown'
        : position.latitude.toString() + ', ' + position.longitude.toString());

    print(
        "Chnaging location  +  ${position.longitude} + ${position.latitude} ");

    lan = position.longitude;

    lat = position.latitude;

    changePosition();

    /*  setState(() {*/

    /*});*/

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14)));
  });
}

void checkRequestedBefor(chnageUi) {
  FirebaseDatabase.instance
      .reference()
      .child(Common.help_request)
      .child(Common.user_number)
      .once()
      .then((value) {
    if (value.value != null) {
      /*setState(() {*/
      var_check_for_help = true;

      help_type = value.value["request_type"];

      isHelp = true;

      requestLocation = new LatLng(
          value.value["location"]["lat"], value.value["location"]["lan"]);
      /*});*/

      chnageUi();
    }
  });
}

void firebase_request_for_help(name, helpType) async {
  print("Phone number  ${Common.user_number}");

  await FirebaseDatabase.instance
      .reference()
      .child(Common.help_request)
      .child(Common.user_number)
      .set({
    "request_type": helpType,
    "location": {
      "lat": lat,
      "lan": lan,
    }
  }).then((value) {
    //status = "requesting";

    notification_controller.sendNotification(name, helpType);
  }).catchError((err) {
    print("Error  ${err}");
  });
}

void firebase_cancel_request() {
  FirebaseDatabase.instance
      .reference()
      .child(Common.help_request)
      .child(Common.user_number)
      .remove()
      .then((value) => print("remove"))
      .catchError((err) => print("Error  ${err}"));
}
