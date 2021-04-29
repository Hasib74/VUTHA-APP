import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vutha_app/src/Controller/Country/CountryCodeController.dart'
    as conutry_controller;
import 'package:vutha_app/src/Controller/UpdateNumberAndPassword/OtpController/OtpController.dart'
    as otp_controller;
import 'package:vutha_app/src/Provider/Update/ChnagePasswordAndNumber.dart';
import 'package:vutha_app/src/Utls/AppConstant/AppColors.dart';
import 'package:vutha_app/src/Utls/Common.dart';

class ChangeNumber extends StatelessWidget {
  var _number_controller = new TextEditingController();
  var country_code;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangePasswordAndNumberProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: conutry_controller.getCountry(),
              builder: (context, AsyncSnapshot<String> data) {
                print("Dataaaa  ${data.data}");

                if (data.data == "BD") {
                  country_code = "+88";
                } else {
                  country_code = "+27";
                }

                return TextField(
                  controller: _number_controller,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    prefixIcon: SizedBox(
                      child: Center(
                        widthFactor: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text('${country_code}',
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ),
                    filled: true,
                    //fillColor: Colors.grey[300],
                    hintText: '',
                    border: InputBorder.none,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                provider.setLoading(true);

                otp_controller.verifyPhone(_number_controller.value.text,
                    country_code, context, provider);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, blurRadius: 1, spreadRadius: 1)
                    ]),
                child: Center(
                    child: Text(
                  "Change Number",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
