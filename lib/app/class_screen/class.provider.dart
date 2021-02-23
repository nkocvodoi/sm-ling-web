import 'package:SMLingg/config/application.dart';
import 'package:flutter/cupertino.dart';

class ClassModel extends ChangeNotifier {
  bool _show = false;

  get show => _show;

  int _hive = Application.user.level;

  get hive => _hive;

  int _diamond = Application.user.score;

  get diamond => _diamond;

  String _face = "face";

  getFace() => _face;

  String _dot = "dot1";

  getDot() => _dot;

  int _index = 0;

  getIndex() => _index;

  void refreshData() {
    _hive = Application.user.level;
    _diamond = Application.user.score;
    print("hive: $_hive diamond $_diamond");
    notifyListeners();
  }

  void setShowValue() {
    _show = !_show;
    notifyListeners();
  }

  setIndex(int value) {
    _index = value;
    notifyListeners();
    if (_index == 0) {
      _dot = "dot1";
      _face = "face";
    } else {
      _dot = "dot";
      _face = "face1";
    }
    notifyListeners();
  }

  bool _screenIndicator = false;

  getScreenIndicator() => _screenIndicator;

  setScreenIndicator(bool value) {
    _screenIndicator = value;
    notifyListeners();
  }
}
