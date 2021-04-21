import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';

class ChangeNumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changePasswordAndNumberProvider =
        Provider.of<ChangePasswordAndNumberProvider>(context);

    return InkWell(
      onTap: () {
        print("chnageNumber");

        changePasswordAndNumberProvider.isPasswordOrNumber("chnageNumber");
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 40,
        decoration: BoxDecoration(color: AppColors.primaryColor, boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 1, spreadRadius: 1)
        ]),
        child: Center(
            child: Text(
          "Change Number",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
