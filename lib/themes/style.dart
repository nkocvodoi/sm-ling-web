import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color mainTextColor = Color(0xFF121917);
  static const Color mainThemes = Color(0xFFD9EEFD);
  static const Color mainThemesFocus = Color(0xFFADD6F3);

  static const Color mainBackGround = Color(0xFFF3FAFF);
  static const Color answerButtonShadow = Color(0xFFD7EBFA);

  static const Color correctBackground = Color(0xFFD4FDB4);
  static const Color correctButtonBackground = Color(0xFF72D356);
  static const Color correctLightButtonBackground = Color(0xFFD4FDB4);
  static const Color correctDarkButtonBackground = Color(0xFF72D356);
  static const Color correctButtonShadow = Color(0xFF5ABB3E);
  static const Color buttonCorrectText = Color(0xFF57B23D);

  static const Color wrongBackground = Color(0xFFFFD3D3);
  static const Color wrongButtonBackground = Color(0xFFFF6060);
  static const Color wrongLightButtonBackground = Color(0xFFFFD3D3);
  static const Color wrongDarkButtonBackground = Color(0xFFFF6060);
  static const Color wrongButtonShadow = Color(0xFFE83434);
  static const Color buttonWrongText = Color(0xFFEF2626);

  static const Color submitButtonText = Color(0xFFADD6F3);
  static const Color buttonText = Color(0xFF43669F);
  static const Color backButton = Color(0xFF8EA9D5);
  static const Color unitColor = Color(0xFF84BDE5);
  static const Color checkBoxColor = Color(0xFFE5F3FD);
  static const Color tickCheckBox = Color(0xFF4285F4);
}

class TextSize {
  static double fontSize18 =
      Application.sharePreference.getInt("setGrade") >= 5 ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockVertical * 2.5;
  static double fontSize16 =
      Application.sharePreference.getInt("setGrade") >= 5 ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockVertical * 2.25;
  static double fontSize20 =
      Application.sharePreference.getInt("setGrade") >= 5 ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockVertical * 3;
  static double fontSize25 =
      Application.sharePreference.getInt("setGrade") >= 5 ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockVertical * 3.5;
  static double fontSize40 =
      Application.sharePreference.getInt("setGrade") >= 5 ? SizeConfig.safeBlockHorizontal * 5 : SizeConfig.safeBlockVertical * 6;
  static double fontSize51 = SizeConfig.safeBlockVertical * 13;
  static double fontSize30 = SizeConfig.safeBlockVertical * 6;
  static double fontSize15 = SizeConfig.safeBlockVertical * 4;
  static String fontFamily = "Quicksand";
}

class LevelColor {
  static Color defaultLightColor = Color(0xFFADD6F3).withOpacity(0.4);
  static const Color defaultTextColor = Color(0xFF84BDE5);
  static const Color defaultDarkColor = Color(0xFFADD6F3);
  static List<Color> coreColor = [
    Color(0xFFFFB55D),
    Color(0xFFC0C2FF),
    Color(0xFF74E9F8),
    Color(0xFFFFFB90),
    Color(0xFFF7D5FF),
    Color(0xFFB8F9A5),
    Color(0xFFBDD6FF),
  ];
  static List<Color> coreShadowColor = [
    Color(0xFFEC6600),
    Color(0xFF6C71EF),
    Color(0xFF29AEC0),
    Color(0xFFE9AB09),
    Color(0xFFD76BF0),
    Color(0xFF52C033),
    Color(0xFF478CFF),
  ];

  static List<Color> levelDarkColor = [
    Color(0xFFED8100),
    Color(0xFF868BFF),
    Color(0xFF48CEE0),
    Color(0xFFFFC639),
    Color(0xFFE88FFD),
    Color(0xFF72D356),
    Color(0xFF73A8FF),
  ];
  static List<Color> levelLightColor = [
    Color(0xFFFFC639),
    Color(0xFFD3D5FF),
    Color(0xFF48CEE0),
    Color(0xFFFFC639),
    Color(0xFFE88FFD),
    Color(0xFF72D356),
    Color(0xFF73A8FF)
  ];
}
