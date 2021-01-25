import 'package:SMLingg/config/application.dart';
import 'package:flutter/material.dart';

class UnitModel extends ChangeNotifier {
  int _saveUserLevel;
  int _saveUserLesson;
  String _saveId = "";

  int get saveUserLevel => _saveUserLevel;

  int get saveUserLesson => _saveUserLesson;

  String get saveId => _saveId;

  void save(int saveUserLevel, int saveUserLesson, String saveId) {
    _saveUserLevel = saveUserLevel;
    _saveUserLesson = saveUserLesson;
    _saveId = saveId;
    Application.sharePreference
      ..putInt("saveUserLevel", saveUserLevel)
      ..putInt("saveUserLesson", saveUserLesson)
      ..putString("saveId", saveId)
      ..putInt("count", 1);
    notifyListeners();
  }

  void clearSave() {
    Application.sharePreference
      ..remove("saveUserLevel")
      ..remove("saveUserLesson")
      ..remove("saveId")
      ..remove("count")
      ..remove("saveGrade")
      ..remove("saveBookId");
    _saveUserLevel = null;
    _saveUserLesson = null;
    _saveId = "";
  }

  bool _open = false;

  bool get open => _open;

  void setOpen(bool value) {
    _open = value;
    notifyListeners();
  }

  List<int> _userLevel = [];
  List<int> _userLesson = [];

  void initUser(unitLength) {
    _userLevel = List.generate(
        unitLength, (index) => Application.unitList.units[index].userLevel);
    _userLesson = List.generate(
        unitLength, (index) => Application.unitList.units[index].userLesson);
  }

  userLevel(int index) => _userLevel[index];

  userLesson(int index) => _userLesson[index];
}