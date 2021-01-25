import 'package:flutter/material.dart';

class ReportModel extends ChangeNotifier {
  List<String> errorText = [
    "Đáp án sai",
    "Từ sai chính tả",
    "Không phát âm thanh",
    "Đáp án không hiển thị hình ảnh",
    "Xảy ra lỗi khác"
  ];

  List<bool> _isChecked = List.generate(5, (index) => false);

  List<bool> get isChecked => _isChecked;

  void setChecked(int index) {
    _isChecked[index] = !_isChecked[index];
    notifyListeners();
  }

  List<String> _errors = [];

  void initError() {
    _errors = [];
    _comment = '';
    _isChecked = List.generate(5, (index) => false);
  }

  List<String> get errors => _errors;

  void addError(String value) {
    _errors.add(value);
    notifyListeners();
  }

  String _comment = '';

  String get comment => _comment;

  void saveComment(String value) {
    _comment = value;
    notifyListeners();
  }
}
