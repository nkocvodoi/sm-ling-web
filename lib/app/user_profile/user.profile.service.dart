import 'package:flutter/material.dart';

class UserProfileService extends ChangeNotifier {
  String _nickName = '';

  String getName() => _nickName;

  void setName(String name) {
    _nickName = name;
    notifyListeners();
  }

  bool _enableEdit = false;

  bool getEnableEdit() => _enableEdit;

  void enableEdit(bool value) {
    _enableEdit = value;
    notifyListeners();
  }
}
