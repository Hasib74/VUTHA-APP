import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Controller/SpController/SpController.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/Functions.dart';
import 'package:vutha_app/src/View/Chat/Chat.dart';
import 'package:vutha_app/src/View/Edit/ChangePasswordOrNumber.dart';
import 'package:vutha_app/src/View/History/History.dart';
import 'package:vutha_app/src/View/LogInAndRegistation/InitialPage.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
//import 'Chat';

class NavigationDrawer extends StatelessWidget {
  // final key;

  Function closeDrawer;
  var number;

  NavigationDrawer(Key key, this.closeDrawer, this.number) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      /* Navigator.of(context)
                      .push(new MaterialPageRoute(
                          builder: (context) => Chat(
                                number: number,
                              )))
                      .then((value) {
                    closeDrawer();
                  });*/

                      closeDrawer();

                      try {
                        routes.normalRoute(
                            context,
                            Chat(
                              number: number,
                            ));
                      } catch (err) {}
                    },
                    leading: Icon(
                      Icons.chat,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      "Chat",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      closeDrawer();
                      routes.normalRoute(context, HistoryPage());
                    },
                    leading: Icon(
                      Icons.history,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      "Histoty",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      //removeLogInInfo(context);

                      closeDrawer();

                      routes.normalRoute(
                          context, new ChnagePasswordAndUpdateDisplay());
                    },
                    leading: Icon(
                      Icons.autorenew,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      "Chnage Password Or Number",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      removeLogInInfo(context);
                    },
                    leading: Icon(
                      Icons.exit_to_app,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                          color: AppColors.primaryColor,
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

  void removeLogInInfo(BuildContext context) async {
    Functions.logOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => InitialPage()));
  }
}
