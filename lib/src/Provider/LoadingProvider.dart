import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  var _loading;

  get loading => _loading;

  LoadingProvider() {
    _loading = false;
  }

  setLoading(value) {
    _loading = value;

    notifyListeners();
  }
}
