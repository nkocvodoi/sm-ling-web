import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/setting/setting.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

Widget userProfile(context, ClassModel classModel) {
  return Scaffold(
      backgroundColor: AppColor.mainBackGround,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.lightBlueAccent,
          child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeHorizontal * 90,
              color: Color(0xFF4285F4),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  circle(color: Color(0xFF4C8FFE), size: SizeConfig.safeBlockHorizontal * 80),
                  circle(color: Color(0xFF659FFF), size: SizeConfig.safeBlockHorizontal * 62),
                  circle(color: Color(0xFF77AAFF), size: SizeConfig.safeBlockHorizontal * 42),
                  circle(color: Color(0xFFFDDD45), size: SizeConfig.safeBlockHorizontal * 28),
                  circle(color: Color(0xFFFFFFFF), size: SizeConfig.safeBlockHorizontal * 25),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 22,
                    height: SizeConfig.safeBlockHorizontal * 22,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(Application.user.avatar),
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.blockSizeVertical * 7,
                    child: CustomButton(
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Text(
                            Application.user.displayName,
                            style: TextStyle(fontSize: TextSize.fontSize20, fontWeight: FontWeight.w700, color: Color(0xFF4285F4)),
                          ),
                        ),
                      ),
                      height: SizeConfig.safeBlockHorizontal * 12,
                      width: SizeConfig.safeBlockHorizontal * 65,
                      radius: 90,
                      shadowColor: Color(0xFFFDDD45),
                      onPressed: null,
                      deactivate: true,
                    ),
                  ),
                  Positioned(
                      top: 30,
                      right: SizeConfig.safeBlockVertical * 4,
                      child: InkWell(
                        onTap: () {
                          classModel.setScreenIndicator(true);
                          Navigator.push(
                            context as BuildContext,
                            MaterialPageRoute(builder: (context) => Setting()),
                          );
                        },
                        child: Container(
                          child: Icon(Icons.settings,
                              size: SizeConfig.safeBlockVertical * 3.5),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Achievement'.i18n,
                style: TextStyle(color: Color(0xFF5877AA), fontSize: TextSize.fontSize20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  achievement(image: 'assets/honey_point.svg', message: 'Level'.i18n, userNumber: Application.user.level.toString()),
                  achievement(image: 'assets/droplets_yellow.svg', message: 'Lesson'.i18n, userNumber: Application.user.score.toString())
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Divider(
                color: Color(0xFFBCE2FF),
                thickness: 1.5,
                endIndent: SizeConfig.blockSizeHorizontal * 10,
                indent: SizeConfig.blockSizeHorizontal * 10,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'More App'.i18n,
                style: TextStyle(color: Color(0xFF5877AA), fontSize: TextSize.fontSize20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                margin: EdgeInsets.only(bottom: 20),
                width: SizeConfig.blockSizeHorizontal * 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5), color: Color(0xFFE5F3FD)),
                child: Column(children: [
                  relativeApp(appIcon: 'assets/profile/1.png', name: 'Từ vựng tiếng Anh - Sách Mềm', top: 0, bottom: 15),
                  relativeApp(appIcon: 'assets/profile/2.png', name: 'SM Song - Sách Mềm', top: 0, bottom: 15),
                  relativeApp(appIcon: 'assets/profile/3.png', name: 'Nghe nói tiếng anh - Sách Mềm', top: 0, bottom: 0)
                ]))
          ])),
        ),
      ));
}

Widget circle({double size, Color color}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

Widget achievement({String image, String userNumber, String message}) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 18,
    width: SizeConfig.blockSizeHorizontal * 42,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
        border: Border.all(color: Color(0xFFBCE2FF)),
        boxShadow: [
          BoxShadow(color: Color(0xFF97CFF5)),
          BoxShadow(
              color: Colors.white, // background color
              spreadRadius: 1,
              blurRadius: 14.0)
        ]),
    child: Row(
      children: [
        Container(
            margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
            child: Image.asset(image, width: SizeConfig.blockSizeHorizontal * 10),
            width: SizeConfig.blockSizeHorizontal * 12,
            alignment: Alignment.center),
        VerticalDivider(
          width: SizeConfig.blockSizeHorizontal * 2,
          color: Color(0xFFBCE2FF),
          thickness: 3,
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 25,
          alignment: Alignment.center,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '$userNumber ',
              style: TextStyle(fontSize: TextSize.fontSize30, color: Color(0xFF4285F4), fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                    text: (userNumber.length * SizeConfig.blockSizeHorizontal * 5 + message.length * SizeConfig.blockSizeHorizontal * 3 >
                            SizeConfig.blockSizeHorizontal * 25)
                        ? '\n'
                        : '',
                    style: TextStyle(fontSize: TextSize.fontSize15, color: Color(0xFF4285F4), fontWeight: FontWeight.w400)),
                TextSpan(text: '$message', style: TextStyle(fontSize: TextSize.fontSize15, color: Color(0xFF4285F4), fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget relativeApp({String name, String appIcon, double bottom, double top}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottom, top: top),
    child: ListTile(
      title: Text(name, style: TextStyle(color: Color(0xFF5877AA), fontWeight: FontWeight.w500, fontSize: TextSize.fontSize18)),
      leading: Image.asset(appIcon, height: SizeConfig.blockSizeVertical * 7),
    ),
  );
}
