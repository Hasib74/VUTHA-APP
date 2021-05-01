import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vutha_app/src/Utls/Common.dart';
import 'package:vutha_app/src/View/Medical/MedicalInfoScreen.dart';

class MedicalInfoController {
  BuildContext _context;
  FirebaseDatabase _firebaseDatabase;

  static final MedicalInfoController _singleton =
      MedicalInfoController._internal();

  factory MedicalInfoController(BuildContext context) {
    _singleton._context = context;
    _singleton.blood_type_fn(0);
    _singleton.organic_donor = true;
    return _singleton;
  }

  MedicalInfoController._internal();

  //loading.............

  bool loading = false;

  TextEditingController medical_aid_name_controller =
      new TextEditingController();

  TextEditingController medical_aid_number_controller =
      new TextEditingController();

  TextEditingController medical_aid_option_or_plan_controller =
      new TextEditingController();

  TextEditingController main_member_name_controller =
      new TextEditingController();

  TextEditingController name_controller = new TextEditingController();

  TextEditingController contact_number_controller = new TextEditingController();

  bool organic_donor = true;
  String blood_type;

  List medical_conditions = [];

  void blood_type_fn(int value) {
    switch (value) {
      case 0:
        blood_type = "A";
        break;
      case 1:
        blood_type = "B";
        break;
      case 2:
        blood_type = "AB";
        break;
      case 3:
        blood_type = "O";
        break;
      case 4:
        blood_type = "A-";
        break;
      case 5:
        blood_type = "B-";
        break;
      case 6:
        blood_type = "AB-";
        break;
      case 7:
        blood_type = "O-";
        break;
    }
  }

  void medical_conditions_fn(String s) {
    if (medical_conditions.contains(s)) {
      medical_conditions.remove(s);
    } else {
      medical_conditions.add(s);
    }
  }

  save() {
    if (_validation()) {
      print("Organic Donor ${organic_donor}");
      print("Blood type group ${blood_type}");
      print("Medical Condition ${medical_conditions.toString()}");
      print(
          "medical aid name controller ${medical_aid_name_controller.value.text}");
      print(
          "medical aid number controller ${medical_aid_number_controller.value.text}");
      print(
          "Main member name controller ${main_member_name_controller.value.text}");
      print("name controller ${name_controller.value.text}");
      print(
          "contact number controller ${contact_number_controller.value.text}");

      Map<String, dynamic> _body = {
        "Medical Aid Name": medical_aid_name_controller.value.text,
        "Medical Aid Number": medical_aid_number_controller.value.text,
        "Medical Aid Option and Plan":
            medical_aid_option_or_plan_controller.value.text,
        "Main Member Name": main_member_name_controller.value.text,
        "Name": name_controller.value.text,
        "Contact Number": contact_number_controller.value.text,
        "Organ donor": organic_donor,
        "Blood type group": blood_type,
        "Medical Condition": medical_conditions
      };

      loading = true;
      MedicalInfoScreen().createState().update();
      FirebaseDatabase.instance
          .reference()
          .child(Common.USER)
          .child(Common.user_number)
          .child(Common.MEDICAL_INFO)
          .set(_body)
          .then((value) {
        loading = false;
        MedicalInfoScreen().createState().update();
        print("Successfully added data");
      }).catchError((err) {
        print("Error is ${err}");

        loading = false;
        MedicalInfoScreen().createState().update();
      });
    }
  }

  bool _validation() {
    bool _valid = false;

    if (medical_aid_name_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context, message: "Medical Aid name can not be empty");
    } else if (medical_aid_number_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context, message: "Medical Aid number can not be empty");
    } else if (medical_aid_option_or_plan_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context,
          message: "Medical Aid option/plan can not be empty");
    } else if (main_member_name_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context, message: "Main member name can not be empty");
    } else if (name_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context, message: "Name can not be empty");
    } else if (contact_number_controller.value.text.isEmpty) {
      _valid = false;
      showSnackBar(_context, message: "Contact number can not be empty");
    } else {
      _valid = true;
    }

    return _valid;
  }

  showSnackBar(BuildContext context,
      {@required String message, bool isSuccess = true}) {
    final snackBar = SnackBar(
      content: Text(
        "${message}",
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
