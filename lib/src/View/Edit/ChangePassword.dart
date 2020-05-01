import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  var _previous_password = new TextEditingController();
  var _new_password = new TextEditingController();
  var _re_new_password = new TextEditingController();

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
              obscureText: true,
              controller: _previous_password,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                /*prefixIcon: SizedBox(
                  child: Center(
                    widthFactor: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text('+27', style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ),*/
                filled: true,
                //fillColor: Colors.grey[300],
                hintText: 'Previous Password',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              controller: _new_password,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                /*prefixIcon: SizedBox(
                  child: Center(
                    widthFactor: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text('+27', style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ),*/
                filled: true,
                //fillColor: Colors.grey[300],
                hintText: 'New Password',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              controller: _re_new_password,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                /*prefixIcon: SizedBox(
                  child: Center(
                    widthFactor: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text('+27', style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ),*/
                filled: true,
                //fillColor: Colors.grey[300],
                hintText: 'Confirm Password',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 1, spreadRadius: 1)
              ]),
              child: Center(
                  child: Text(
                "Change Password",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
