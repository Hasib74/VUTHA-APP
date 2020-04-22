import 'package:firebase_database/firebase_database.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Utls/Common.dart';

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