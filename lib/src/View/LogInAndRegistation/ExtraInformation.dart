import 'package:flutter/material.dart';

class ExtraInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExtraInfo(),
    );
  }
}

class ExtraInfo extends StatefulWidget {
  @override
  _ExtraInfoState createState() => _ExtraInfoState();
}

class _ExtraInfoState extends State<ExtraInfo> {
  var _master_code_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Enter mastercode

              Container(
                padding: EdgeInsets.all(10),
                // margin: EdgeInsets.all(10),

                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 4)
                ]),

                child: Column(
                  children: <Widget>[
                    Text(
                      "Enter Your Master Code",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _master_code_controller,
                      decoration: new InputDecoration(
                        filled: true,
                        //fillColor: Colors.grey[300],
                        hintText: ' ',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),

              //pay now

               Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 1)
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Pay Now",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Text(
                        "www.payfirst.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(letterSpacing: 3),
                      ),
                    )
                  ],  
                ),
              ),

              //pay at retailers

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, spreadRadius: 1, blurRadius: 1)
                    ]),
                child: Column(
                  children: <Widget>[
                    Text("PAY AT RETAILERS",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(color: Colors.black38)),
                      child: Column(
                        children: <Widget>[
                          Text("ShopRate Store"),
                          Text("Coke Store Pep Store"),
                          Text("Massmart etc"),
                          Divider(
                            color: Colors.black,
                          ),
                          Text("ww.payat.w.za"),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
