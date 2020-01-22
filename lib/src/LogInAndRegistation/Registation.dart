import 'package:flutter/material.dart';


class RegsiationPage extends StatefulWidget {
  @override
  _RegsiationPageState createState() => _RegsiationPageState();
}

class _RegsiationPageState extends State<RegsiationPage> {
  var _name_controller = TextEditingController();
  var _surName_controller = TextEditingController();
  var _email_controller = TextEditingController();
  var _date_of_birth_controller = TextEditingController();
  var _confirm_password_controller = TextEditingController();
  var _phone_controller = TextEditingController();

  bool _value = false;

  void _value1Changed(bool value) => setState(() => _value = value);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: new Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image.asset("Img/piza.jpg"),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Sign up ",
                  style: TextStyle(
                      color: Color(0xff172E4B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Name',
                    border: InputBorder.none,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _surName_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Surname',
                    border: InputBorder.none,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _phone_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Phone',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email_controller,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _date_of_birth_controller,
                  obscureText: true,
                  decoration: new InputDecoration(
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: 'Date Of Birth',
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(color: Colors.orange),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color(0xffFDEBE3), fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Spacer(),


              
              Row(

                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[

                  new Checkbox(value: _value , onChanged: _value1Changed ,activeColor: Colors.orange,),
                  
                  
                  Text("Terms and conditions",style: TextStyle(color: Colors.black38,fontSize: 15),),
                  
                  
                ],
                
              )



            ],
          ),
        ),
      ),
    );
  }
}
