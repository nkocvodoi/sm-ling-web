import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/utils/check_locale.dart';
import 'package:flutter/cupertino.dart';

class SettingStates extends ChangeNotifier {
  // String _languageIndex = checkLocale().languageCode == "vi" ? "vi_vn" : "en_us";
  //
  // String get languageIndex => _languageIndex;
  //
  // void setCurrentSegment() {
  //   if (_languageIndex == "vi_vn") {
  //     _languageIndex = "en_us";
  //   } else {
  //     _languageIndex = "vi_vn";
  //   }
  //   notifyListeners();
  // }

  bool _trainingIndicator = Application.sharePreference.getBool("trainingIndicator") ?? false;

  bool get trainingIndicator => _trainingIndicator;

  void setTrainingIndicator() {
    _trainingIndicator = !_trainingIndicator;
    Application.sharePreference.putBool("trainingIndicator", _trainingIndicator);
    notifyListeners();
  }

  bool _hearIndicator = Application.sharePreference.getBool("hearIndicator") ?? false;

  bool get hearIndicator => _hearIndicator;

  void setHearIndicator() {
    _hearIndicator = !_hearIndicator;
    Application.sharePreference.putBool("hearIndicator", _hearIndicator);
    notifyListeners();
  }

  bool _speakIndicator = Application.sharePreference.getBool("speakIndicator") ?? false;

  bool get speakIndicator => _speakIndicator;

  void setSpeakIndicator() {
    _speakIndicator = !_speakIndicator;
    Application.sharePreference.putBool("speakIndicator", !_speakIndicator);
    notifyListeners();
  }
}
