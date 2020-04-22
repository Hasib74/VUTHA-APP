import 'package:geocoder/geocoder.dart';
import 'package:vutha_app/src/Model/User.dart';


class Common{

 static  String USER="User";

 static  String user_number  ;
 static  String help_request = "HelpRequest";
 static  var Chat ="Chat";

 static var TOKEN ="Token";
 static var ADMIN="Admin";
 static var HISTORY = "History" ;

 static var CANCLE = "Cancle";

 static var SERVE = "Serve";

 static User user;

 static Future<String> getUserLocation(lat, lan) async {
  final coordinates = new Coordinates(lat, lan);
  var addresses =
  await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;

  return '${first.addressLine}   ';
 }


}