import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Middleware/MasterCode.dart';
import 'package:vutha_app/src/Model/ChatModel.dart';
import 'package:vutha_app/src/Model/User.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/Controller/ChatController/ChatController.dart'
    as controller;
import 'package:vutha_app/src/Route/Routs.dart' as route;
import 'package:vutha_app/src/View/MasterCode/MasterCodeAuthentication.dart';

class Chat extends StatefulWidget {
  var number;

  Chat({this.number});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  double size;

  var text;

  var chat_edit_text_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print("Number is  ${number}");

    isMasterCodeChecked().then((value) {
      if (!value) {
        route.routeAndRemovePreviousRoute(
            context,
            MasterCode(
              number: Common.user.number,
            ));
      }
    });

    size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Icon(
              Icons.arrow_back,
              color: Colors.amber,
            )),
      ),
      body: Column(
        children: <Widget>[ChatBody(), TextFiledAndSendButton(context)],
      ),
    );
  }

  Expanded ChatBody() {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child(Common.Chat)
              .child(widget.number)
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<ChatModel> _chat_list = new List();

              List<dynamic> step1 = snapshot.data.snapshot.value;

              step1.forEach((element) {
                if (element != null) {
                  _chat_list.add(new ChatModel(
                      type: element["type"], message: element["message"]));
                }
              });

              _chat_list = _chat_list.reversed.toList();

              return ListView.builder(
                itemCount: _chat_list.length,
                reverse: true,
                itemBuilder: (context, int index) {
                  if (_chat_list[index].type == "user") {
                    return AdminMessage(_chat_list, index);
                  } else {
                    return UserMessage(_chat_list, index);
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Padding UserMessage(List<ChatModel> _chat_list, int index) {
    return Padding(
      padding: EdgeInsets.only(right: size / 2, top: 3, bottom: 3, left: 3),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            _chat_list[index].message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding AdminMessage(List<ChatModel> _chat_list, int index) {
    return Padding(
      padding: EdgeInsets.only(left: size / 2, top: 3, bottom: 3, right: 3),
      child: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            _chat_list[index].message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Padding TextFiledAndSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  child: TextField(
                      onChanged: (v) {
                        setState(() {
                          text = v;
                        });
                      },
                      controller: chat_edit_text_controller,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true)),
                ),
              )),
              text != null
                  ? InkWell(
                      onTap: () => controller.send_message(
                          chat_edit_text_controller, widget.number),
                      child: Icon(
                        Icons.send,
                        color: Colors.orange,
                        size: 30,
                      ),
                    )
                  : InkWell(
                      //  onTap: ()=>send_message(),
                      child: Icon(
                        Icons.send,
                        color: Colors.black54,
                        size: 30,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
