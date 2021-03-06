import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

class ChangePasswordAndNumberProvider extends ChangeNotifier {
  var _update_password;
  var _password_status;
  var _update_number;
  var _password_or_number;
  bool _error;
  bool _loading;
  bool _updateing;


  get update_password => _update_password;
  get update_number => _update_number;
  get password_or_number => _password_or_number;
  get error => _error;
  get loading => _loading;
  get updateing => _updateing;
  get password_status=>_password_status;

  ChangePasswordAndNumberProvider() {
    _password_or_number = null;
    _loading=false;
    _error=false;
    _updateing=false;
    _password_status=null;
    notifyListeners();
  }

  isPasswordOrNumber(value) {
    _password_or_number = value;

    notifyListeners();
  }

  setError(v) {
    _error = v;
    notifyListeners();
  }

  setLoading(v) {
    _loading = v;
    notifyListeners();
  }

  setUpdating(v){
    _updateing = v;
    notifyListeners();
  }

  setPasswordStatus(value){
    _password_status=value;

    notifyListeners();
  }
}
