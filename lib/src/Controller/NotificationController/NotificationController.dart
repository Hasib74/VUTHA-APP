import 'package:firebase_database/firebase_database.dart';
import 'package:vutha_app/src/Model/NotificationData.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Utls/Notification/NotificationService.dart';

void sendNotification(name , help_type) {
  //print("User Name   ${user.name}");

  FirebaseDatabase.instance
      .reference()
      .child(Common.TOKEN)
      .child(Common.ADMIN)
      .once()
      .then((value) {
    NotificationData notificationData = new NotificationData(
        data: Data(
            text: "Good",
            body: "${name} is requested for ${help_type}",
            title: "New Request",
            click_action: "newRequest"),
        to: value.value["token"]);

    NotificationService().sendRequest(notificationData);
  });
}