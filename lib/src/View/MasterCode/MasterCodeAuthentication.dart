import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Provider/LoadingProvider.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Route/Routs.dart' as routes;
import 'package:vutha_app/src/View/Map/MapActivity.dart';

class MasterCode extends StatelessWidget {
  final _master_code_controller = new TextEditingController();

  final number;

  MasterCode({this.number});

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadingProvider(),
      child: Scaffold(
        key: _globalKey,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    children: <Widget>[
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
                        child: Consumer<LoadingProvider>(
                          builder: (context, provider, _) {
                            return new InkWell(
                              onTap: () => master_code_check(context, provider),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 1)
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
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Pay Now",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color(0xffF5F4F6),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "www.payfast.co.za",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.orange),
                        )),
                      )
                    ],
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Pay At Retallers",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffF5F4F6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "ShopRte Store",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Coke Store PepSlove",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Massmart etc",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Pay At Retallers",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child:
                    Consumer<LoadingProvider>(builder: (context, provider, _) {
                  return provider.loading
                      ? CircularProgressIndicator()
                      : Container();
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  master_code_check(context, LoadingProvider provider) {
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
            _globalKey.currentState.showSnackBar(new SnackBar(
                content: Text("Admin did not authorized yet !!!")));
          } else {
            print("authorization trying ");

            provider.setLoading(true);
            if (value.value
                .toString()
                .endsWith(_master_code_controller.value.text)) {
              print("authorization  ");

              FirebaseDatabase.instance
                  .reference()
                  .child(Common.USER)
                  .child(user.phoneNumber)
                  .update({"authorization": true}).then((_) {
                print("authorization updated ");

                provider.setLoading(false);
                routes.routeAndRemovePreviousRoute(context, new MapActivity());
              });
            }
          }
        });
      });
    }
  }
}
