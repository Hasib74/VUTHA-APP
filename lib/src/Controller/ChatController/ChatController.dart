
import 'package:firebase_database/firebase_database.dart';
import 'package:vutha_app/src/Utls/Common.dart';

send_message(chat_edit_text_controller,number) {
  var message;

  if (chat_edit_text_controller.value.text.isNotEmpty) {
    message = chat_edit_text_controller.value.text;

    chat_edit_text_controller.text = "";
    FirebaseDatabase.instance
        .reference()
        .child(Common.Chat)
        .child(number)
        .once()
        .then((value) {
      if (value.value == null) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.Chat)
            .child(number)
            .child("1")
            .set({
          "message": message,
          "type": "user",
          "time": new DateTime.now()
              .toIso8601String()
              .replaceAll(":", ".")
              .replaceAll("-", "."),
        });
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(Common.Chat)
            .child(number)
            .child("${value.value.length + 1}")
            .set({
          "message": message,
          "type": "user",
          "time": new DateTime.now()
              .toIso8601String()
              .replaceAll(":", ".")
              .replaceAll("-", "."),
        });
      }
    });
  }
}