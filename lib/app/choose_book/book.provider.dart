import 'package:SMLingg/app/components/dialog_show_message_and_action.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:get/get.dart';

class BookModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void setCount(int value) {
    _count += value;
    notifyListeners();
  }

  bool _play6To12 = true;

  bool get play6To12 => _play6To12;

  void setPlay6To12(bool value) {
    _play6To12 = value;
    notifyListeners();
  }

  int _current = 0;

  int getGrade() => _current;

  void setGrade(int value, BuildContext context) {
    _current = value;
    notifyListeners();
    if (value > 4 && _count == 0) {
      Future.delayed(Duration(milliseconds: 200), () {
        createDialogShowMessageAndAction(
            context: context,
            top: SizeConfig.blockSizeVertical * 50,
            title:
                "Grades from 6 to 12 are currently testing, do you still want to play?"
                    .i18n,
            titleLeftButton: "No".i18n,
            titleRightButton: "Yes".i18n,
            leftAction: () {
              setCount(0);
              setGrade(4, context);
              Application.sharePreference.putInt("setGrade", 4);
              Get.back();
              Get.offAndToNamed("/book");
            },
            rightAction: () {
              setCount(1);
              setPlay6To12(true);
              Get.back();
            });
      });
    }
  }

  int _previous = 0;

  getPrevious() => _previous;

  setPrevious(int value) {
    _previous = value;
    notifyListeners();
  }
}
