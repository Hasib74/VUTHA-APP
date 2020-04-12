import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Display/Chat/Chat.dart';
//import 'Chat';

class NavigationDrawer extends StatelessWidget {
  // final key;

  Function closeDrawer;
  var number;

  NavigationDrawer(Key key, this.closeDrawer, this.number) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          width: MediaQuery.of(context).size.width / 1.8,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(
                          builder: (context) => Chat(
                                number: number,
                              )))
                      .then((value) {
                    closeDrawer();
                  });
                },
                leading: Icon(
                  Icons.chat,
                  color: Colors.orange,
                ),
                title: Text(
                  "Chat",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              )
            ],
          ),
        ),
        closeDrawerIcon()
      ],
    ));
  }

  Positioned closeDrawerIcon() {
    return Positioned(
        top: 15,
        right: 15,
        child: InkWell(
            onTap: () {
              // this.

              closeDrawer();
            },
            child: Icon(
              Icons.close,
            )));
  }
}
