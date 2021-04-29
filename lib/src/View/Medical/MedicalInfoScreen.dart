import 'package:flutter/material.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';

class MedicalInfoScreen extends StatefulWidget {
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  var _organic_donor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.secondaryColor,
            AppColors.primaryColor,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _icon(),
              _medical_aid(),
              _generalMedicalInfo(),
            ],
          ),
        ),
      ),
    );
  }

  _icon() {
    return Image(image: AssetImage("Img/logo.jpg"));
  }

  _medical_aid() {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Medical Aid",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Medical Aid Name",
                labelStyle: new TextStyle(color: AppColors.primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Medical Aid Number",
                labelStyle: new TextStyle(color: AppColors.primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Medical Aid Option/Plan",
                labelStyle: new TextStyle(color: AppColors.primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Main Member Name",
                labelStyle: new TextStyle(color: AppColors.primaryColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _generalMedicalInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "General Medical Info",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Organ Donor",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white),
                ),
              )),
          Row(
            children: [
              Radio(
                  activeColor: Colors.white,
                  hoverColor: Colors.white,
                  toggleable: true,
                  value: 0,
                  groupValue: _organic_donor,
                  onChanged: _organicRadioButtonHandle),
              Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ),
              Container(
                width: 10,
              ),
              Radio(
                  activeColor: Colors.white,
                  hoverColor: Colors.white,
                  toggleable: true,
                  value: 1,
                  groupValue: _organic_donor,
                  onChanged: _organicRadioButtonHandle),
              Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _organicRadioButtonHandle(int value) {
    _organic_donor = value;
    setState(() {});
  }
}
