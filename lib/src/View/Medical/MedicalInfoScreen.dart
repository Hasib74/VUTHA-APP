import 'package:flutter/material.dart';
import 'package:vutha_app/src/Controller/MedicalInfoController/MedicalInfoController.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppSpaces.dart';

class MedicalInfoScreen extends StatefulWidget {
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  var _organic_donor = 0;
  var _blood_type = 0;

  MedicalInfoController _medicalInfoController;

  @override
  Widget build(BuildContext context) {
    _medicalInfoController = new MedicalInfoController(context);
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
          child: SingleChildScrollView(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSpaces.spaces_height_15,
                _icon(),
                AppSpaces.spaces_height_15,
                _medical_aid(),
                AppSpaces.spaces_height_15,
                _generalMedicalInfo(),
                AppSpaces.spaces_height_5,
                _blood_type_group(),
                AppSpaces.spaces_height_15,
                _next_of_kin(),
                AppSpaces.spaces_height_15,
                _medical_condition(),
                AppSpaces.spaces_height_15,
                _save_button(),
                AppSpaces.spaces_height_15,
                AppSpaces.spaces_height_15,
              ],
            ),
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
              controller: _medicalInfoController.medical_aid_name_controller,
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
              controller: _medicalInfoController.medical_aid_number_controller,
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
              controller:
                  _medicalInfoController.medical_aid_option_or_plan_controller,
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
              controller: _medicalInfoController.main_member_name_controller,
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
                .copyWith(color: Colors.white, fontSize: 16),
          ),
          AppSpaces.spaces_height_15,
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

  _blood_type_group() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Blood type group",
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
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "A",
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
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "B",
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
                  value: 2,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "AB",
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
                  value: 3,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "O",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                  activeColor: Colors.white,
                  hoverColor: Colors.white,
                  toggleable: true,
                  value: 4,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "A -",
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
                  value: 5,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "B-",
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
                  value: 6,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "AB-",
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
                  value: 7,
                  groupValue: _blood_type,
                  onChanged: _bloodRadioButtonHandle),
              Text(
                "O-",
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

    _medicalInfoController.organic_donor = value == 0 ? true : false;

    setState(() {});
  }

  void _bloodRadioButtonHandle(int value) {
    _blood_type = value;

    _medicalInfoController.blood_type_fn(value);
    setState(() {});
  }

  _next_of_kin() {
    return Container(
      height: 200,
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
            "Next of Kin",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: AppColors.primaryColor),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _medicalInfoController.name_controller,
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Name",
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
              controller: _medicalInfoController.contact_number_controller,
              decoration: new InputDecoration(
                //  hintText: "Medical Aid Name",
                labelText: "Contact Number",
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

  _medical_condition() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Medical Conditions",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontSize: 16)),
          ListTile(
            title: Text(
              "Heat Disease / Previous heart attacks",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Heat Disease / Previous heart attacks"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn(
                    "Heat Disease / Previous heart attacks");

                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Previous Stroke",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Previous Stroke"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Previous Stroke");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Diabetes",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Diabetes"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Diabetes");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Asthma / Respiratory disease",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Asthma / Respiratory disease"),
              onChanged: (value) {
                _medicalInfoController
                    .medical_conditions_fn("Asthma / Respiratory disease");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Epilepsy",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Epilepsy"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Epilepsy");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "High Blood",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("High Blood"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("High Blood");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Pacer",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value:
                  _medicalInfoController.medical_conditions.contains("Pacer"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Pacer");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Cholesterol",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Cholesterol"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Cholesterol");
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Text(
              "Thyroid Gland",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            ),
            trailing: Checkbox(
              hoverColor: Colors.white,
              checkColor: AppColors.secondaryColor,
              activeColor: Colors.white,
              value: _medicalInfoController.medical_conditions
                  .contains("Thyroid Gland"),
              onChanged: (value) {
                _medicalInfoController.medical_conditions_fn("Thyroid Gland");
                setState(() {});
              },
            ),
          ),
          /* ListTile(
            title: Row(
              children: [Text("Other"), TextField()],
            ),
            trailing: Checkbox(
              value: false,
              onChanged: (value) {},
            ),
          ),*/
        ],
      ),
    );
  }

  _save_button() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => _medicalInfoController.save(),
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [BoxShadow(color: Colors.black12)]),
            child: Center(
              child: Text(
                "Save",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
