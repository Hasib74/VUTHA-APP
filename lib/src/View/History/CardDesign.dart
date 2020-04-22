import 'package:flutter/material.dart';
import 'package:vutha_app/src/Model/History.dart';
import 'package:vutha_app/src/Utls/Common.dart';

class CardDesign extends StatelessWidget {
  History history;

  CardDesign({this.history});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Container(
        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.all(Radius.circular(7))

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Text(
                  "Date:",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  " ${history.date}",

                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Service Type :",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  " ${history.serviceType}",

                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Confrom From :",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  " ${history.serviceManNumber}",

                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "Location :",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                FutureBuilder(
                    future:
                    Common.getUserLocation(history.location.lat, history.location.lan),
                    builder: (context, data) {
                      if (data.data == null) {
                        return Container();
                      } else {
                        return Flexible(
                            child: Text(
                              " ${data.data} ",
                              softWrap: true,
                            ));
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
