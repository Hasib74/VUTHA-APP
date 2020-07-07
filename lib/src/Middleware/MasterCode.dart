import 'package:firebase_database/firebase_database.dart';
import 'package:vutha_app/src/Utls/Common.dart';

Future<bool> isMasterCodeChecked() async {
  bool auth = false;

  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(Common.user_number)
      .child("authorization")
      .once()
      .then((value) {
    if (value.value != null) {
      auth = value.value;
    }
  });

  return auth;
}

Future<bool> isRegisterMiddleWare() async {
  bool auth = false;

  await FirebaseDatabase.instance
      .reference()
      .child(Common.USER)
      .child(Common.user_number)
      .once()
      .then((value) {
    if (value.value != null) {
      auth = true;
    } else {
      auth = false;
    }
  });

  return auth;
}
