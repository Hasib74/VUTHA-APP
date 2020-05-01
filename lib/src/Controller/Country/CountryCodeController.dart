import 'package:flutter/services.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

Future<String> getCountry() async {
  String platformVersion;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    platformVersion = await FlutterSimCountryCode.simCountryCode;
  } on PlatformException {
    platformVersion = 'Failed to get platform version.';
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.


  return platformVersion;

}