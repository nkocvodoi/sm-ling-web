import 'package:SMLingg/app/choose_book/book.provider.dart';
import 'package:SMLingg/app/components/custom.class_appbar.component.dart';
import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/config/resouces.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'class.provider.dart';

Widget classScreen(context, ClassModel model) {
  return Scaffold(
    appBar: MyCustomAppbar(
      height: SizeConfig.screenHeight * 0.11,
      width: SizeConfig.screenWidth,
      showAvatar: true,
    ),
    body: Container(
      color: AppColor.mainBackGround,
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.lightBlueAccent,
          child: GridView.count(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.fromLTRB(
                SizeConfig.safeBlockHorizontal * 2,
                SizeConfig.safeBlockHorizontal * 3,
                SizeConfig.safeBlockHorizontal * 2,
                SizeConfig.safeBlockHorizontal * 0),
            crossAxisCount: 2,
            childAspectRatio: 10 / 7.5,
            children: List.generate(12, (index) {
              return Center(
                  child: CustomButton(
                elevation: SizeConfig.safeBlockVertical * 0.7,
                radius: SizeConfig.safeBlockVertical * 1.3,
                onPressed: () {
                  Provider.of<BookModel>(context as BuildContext, listen: false)
                      .setGrade(index);
                  Get.toNamed("/book");
                },
                height: SizeConfig.safeBlockHorizontal * 25,
                child: Image.asset(ClassImage.classImage[index],
                    width: SizeConfig.blockSizeHorizontal * 35),
                width: SizeConfig.safeBlockHorizontal * 40,
                backgroundColor: AppColor.mainThemes,
                shadowColor: Color(0xFFADD6F3),
              ));
            }),
          ),
        ),
      ),
    ),
  );
}