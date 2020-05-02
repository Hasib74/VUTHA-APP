import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Utls/Common.dart';

class MasterCode extends StatelessWidget {
  final _master_code_controller = new TextEditingController();

  final number;

  MasterCode({this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _master_code_controller,
              textInputAction: TextInputAction.next,
              decoration: new InputDecoration(
                filled: true,
                //fillColor: Colors.grey[300],
                hintText: 'Master Code',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => master_code_check(context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 1, blurRadius: 1)
                ]),
                child: Center(
                  child: Text(
                    "Master Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  master_code_check(context) {
    if (_master_code_controller.value.text.isNotEmpty) {
      FirebaseAuth.instance.currentUser().then((user) {
        FirebaseDatabase.instance
            .reference()
            .child(Common.USER)
            .child(user.phoneNumber)
            .child("master_code")
            .once()
            .then((value) {
          if (value.value == null) {
            Scaffold.of(context).showSnackBar(new SnackBar(
                content: Text("Admin did not authorized yet !!!")));
          } else {
            if (value.value == _master_code_controller.value.text) {
              FirebaseDatabase.instance
                  .reference()
                  .child(Common.USER)
                  .child(user.phoneNumber)
                  .update({"authorization": true});
            }
          }
        });
      });
    }
  }
}
