import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  bool _logInButtonAbsorb = false;

  bool get logInButtonAbsorb => _logInButtonAbsorb;

  void logInAbsorb(bool value) {
    _logInButtonAbsorb = value;
    print(_logInButtonAbsorb);
    notifyListeners();
    Future.delayed(Duration(milliseconds: 3000), () {
      (_logInButtonAbsorb) ? _logInButtonAbsorb = !_logInButtonAbsorb : null;
      notifyListeners();
    });
  }
}
