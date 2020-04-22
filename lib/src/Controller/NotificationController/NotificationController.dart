import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vutha_app/src/Model/NotificationData.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Notification/NotificationService.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/View/Map/MapActivity.dart';

FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

void registerNotification() {
  firebaseMessaging.requestNotificationPermissions();

  tokenUpdate();

  firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
    print('onMessage: $message');

    if (message["data"]["type"].toString().endsWith("accepted service")) {
      print("Notifiation   ${message["data"]["type"]}");

      showNotification(message['data']);
    }

    //onSelectNotification(message["data"]["click_action"]);

    return;
  }, onResume: (Map<String, dynamic> message) {
    print('onResume: $message');

    if (message["data"]["type"].toString().endsWith("accepted service")) {
      print("Notifiation   ${message["data"]["type"]}");

      showNotification(message['data']);
    }

    // onSelectNotification(message["data"]["click_action"]);

    return;
  }, onLaunch: (Map<String, dynamic> message) {
    print('onLaunch: $message');

    if (message["data"]["type"].toString().endsWith("accepted service")) {
      print("Notifiation   ${message["data"]["type"]}");
      showNotification(message['data']);
    }

    // onSelectNotification(message["data"]["click_action"]);

    return;
  });
}

void tokenUpdate() {
  firebaseMessaging.getToken().then((token) {
    print('token: $token');

    FirebaseDatabase.instance
        .reference()
        .child("Token")
        .child(Common.USER)
        .child(Common.user_number)
        .set({"token": token}).then((_) {
      print("Token Update");
    }).catchError((err) => print(err));
  }).catchError((err) {
    print(err);
  });
}

void showNotification(message) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid
        ? 'com.monu.vutha_admin_app'
        : 'com.monu.vutha_admin_app',
    'Admin App',
    'your channel description',
    playSound: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin
      .show(new Random().nextInt(20), message['title'].toString(),
          message['body'].toString(), platformChannelSpecifics,
          payload: json.encode(message))
      .then((value) {
    print("Showing notification ${message}");
  }).catchError((err) => print("Errror notifiation  ${err}"));
}

void configLocalNotification() {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (value) {
    // print("Valueeeeeeeeeeeeeeeeeeeeeeeeee   ${value}");

    selectNotificationSubject.add(value);
  });
}

void configureSelectNotificationSubject(context) {
  selectNotificationSubject.stream.listen((payload) async {
    print(
        "Poyload =========================================================   ${json.decode(payload)["click_action".toString()]}");

    onSelectNotification(json.decode(payload)["type"].toString(), context);
  });
}

Future<void> onSelectNotification(String payload, context) async {
  if (payload == "accepted service") {
    routes.normalRoute(
        context,
        MapActivity(
          number: Common.user_number,
        ));
  }
}

void sendNotification(name, help_type) {
  //print("User Name   ${user.name}");

  FirebaseDatabase.instance
      .reference()
      .child(Common.TOKEN)
      .child(Common.ADMIN)
      .once()
      .then((value) {
    NotificationData notificationData = new NotificationData(
        data: Data(
            type: "send request",
            body: "${name} is requested for ${help_type}",
            title: "New Request",
            click_action: "newRequest"),
        to: value.value["token"]);

    NotificationService().sendRequest(notificationData);
  });
}




void sendNotificationToAdmin(body, help_type ,type) {
  //print("User Name   ${user.name}");

  FirebaseDatabase.instance
      .reference()
      .child(Common.TOKEN)
      .child(Common.ADMIN)
      .once()
      .then((value) {
    NotificationData notificationData = new NotificationData(
        data: Data(
            type: type,
            body: "${body}",
            title: "${type.toString().toUpperCase()}",
            click_action: "newRequest"),
        to: value.value["token"]);

    NotificationService().sendRequest(notificationData);
  });
}