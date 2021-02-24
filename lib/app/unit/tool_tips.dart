import 'dart:async';

import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/lesson/lesson.view.dart';
import 'package:SMLingg/app/tip/tip.view.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Widget tooltips(context, int grade, String bookID, List<Unit> units, int index, StreamController stream, {double offset = 0}) {
  return Container(
    height: SizeConfig.blockSizeHorizontal * 30,
    width: SizeConfig.blockSizeHorizontal * 70,
    child: Column(
      children: [
        Expanded(child: SizedBox()),
        Container(
          width: SizeConfig.blockSizeHorizontal * 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'Level'} ${units[index].userLevel}/${units[index].totalLevels}',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF3FAFF),
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                  Text(
                    (units[index].doneLessons == units[index].totalLessons)
                        ? '${'Learned'} ${'${units[index].doneLessons}/${units[index].totalLessons}'}'
                        : '${'Learned'} ${'${units[index].userLesson}/${units[index].totalLessonsOfLevel}'}',
                    style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3, fontWeight: FontWeight.w700, color: Color(0xFFC5DBFF)),
                  ),
                ],
              ),
              CustomButton(
                backgroundColor: Color(0xFF6EA5FF),
                child: Text(
                  'TIPS',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                height: SizeConfig.blockSizeHorizontal * 10,
                width: SizeConfig.blockSizeHorizontal * 15,
                shadowColor: Color(0xFF5392FA),
                radius: SizeConfig.blockSizeHorizontal * 5,
                onPressed: () {
                  stream.add(1);
                  Get.to(TipScreen(
                    url: units[index].tips,
                  ));
                },
              )
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        CustomButton(
            elevation: SizeConfig.safeBlockHorizontal * 1.3,
            backgroundColor: Color(0xFFE5F3FD),
            child: Text(
              (units[index].userLevel == units[index].totalLevels && units[index].userLesson == units[index].totalLessonsOfLevel)
                  ? 'PRACTICE'
                  : 'START',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4285F4),
              ),
            ),
            height: SizeConfig.blockSizeHorizontal * 10,
            width: SizeConfig.blockSizeHorizontal * 60,
            shadowColor: Color(0xFFADD6F3),
            radius: SizeConfig.blockSizeHorizontal * 5,
            onPressed: () => {
                  Provider.of<UnitModel>(context, listen: false).save(units[index].userLevel, units[index].userLesson, units[index].sId),
                  Get.off(LessonScreen(userLevel: units[index].userLevel, userLesson: units[index].userLesson, id: units[index].sId, offset: offset)),
                  stream.add(1),
                }),
        Expanded(child: SizedBox()),
      ],
    ),
  );
}
