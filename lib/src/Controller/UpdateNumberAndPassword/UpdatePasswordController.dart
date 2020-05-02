import 'package:firebase_database/firebase_database.dart';
import 'package:vutha_app/src/Utls/Common.dart';

Future<String> validation(
    previous_password, new_password, confirm_password) async {
  String status;

  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(Common.user_number)
      .child("Password")
      .once()
      .then((value) {
    if (previous_password.toString().isNotEmpty &&
            new_password.toString().isNotEmpty ||
        confirm_password.toString().isNotEmpty) {
      print("valueeeee  ${value}");

      if (value.value == previous_password) {
        if (new_password == confirm_password) {
          if (new_password.toString().length > 5) {
            status = "success";
          } else {
            status = "Password shouldbe more then 6 charecter";
          }
        } else {
          status = "Password Not Matched";
        }
      } else {
        status = "Wrong Password";
      }
    } else {
      status = "Empty";
    }
  });

  return status;
}

Future<bool> updatePassword(password) async {
  bool status;

  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(Common.user_number)
      .update({"Password": password}).then((value) {
    status = true;
  }).catchError((err) => status = false);

  return status;
}
