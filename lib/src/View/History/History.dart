import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Model/History.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/View/History/CardDesign.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child(Common.HISTORY)
            .child(Common.user_number)
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: new Container(
                child: Text("No History"),
              ),
            );
          } else {
            Map<dynamic, dynamic> historys = snapshot.data.snapshot.value;

            List<History> history_list = new List();
            historys.forEach((key, value) {

              print("Key  ${key}");

              print("Value  ${value}");

              history_list.add(new History(
                  date: value["date"],
                  serviceManNumber: value["serviceManNumber"],
                  serviceType: value["serviceType"],
                  location: new Location(
                      lat: value["location"]["lat"],
                      lan: value["location"]["lan"])));
            });


            return ListView.builder(  itemCount: history_list.length ,itemBuilder: (context,int index){


              return  CardDesign(history:history_list[index]);

            });
          }
        },
      ),
    );
  }
}
