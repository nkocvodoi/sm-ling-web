import 'package:SMLingg/config/application.dart';

class ClassImage {
  static List<String> classImage = [
    'assets/class_image/class1.png',
    'assets/class_image/class2.png',
    'assets/class_image/class3.png',
    'assets/class_image/class4.png',
    'assets/class_image/class5.png',
    'assets/class_image/class6.png',
    'assets/class_image/class7.png',
    'assets/class_image/class8.png',
    'assets/class_image/class9.png',
    'assets/class_image/class10.png',
    'assets/class_image/class11.png',
    'assets/class_image/class12.png',
  ];
}

class SettingInfo {
  // ignore: non_constant_identifier_names
  static List<String> imageInfo = [
    'assets/setting/earth.svg',
    'assets/setting/bell.svg',
    'assets/setting/clock.svg',
    'assets/setting/speak.svg',
    'assets/setting/hear.svg',
    'assets/setting/star.svg',
    'assets/setting/help.svg',
  ];

  static List<CustomTextField> customTextField= [
    CustomTextField(title: "Name",display: Application.user.displayName),
    CustomTextField(title: "Email", display: Application.user.email),
  ];
}
class CustomTextField {
  String title;
  String display;

  CustomTextField({this.title, this.display});
}


