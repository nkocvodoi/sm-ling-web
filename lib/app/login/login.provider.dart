import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  bool _logInButtonAbsorb = false;

  get logInButtonAbsorb => _logInButtonAbsorb;

  void logInAbsorb(bool value) {
    _logInButtonAbsorb = value;
    print(_logInButtonAbsorb);
    notifyListeners();
  }
}
