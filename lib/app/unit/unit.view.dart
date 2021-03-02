import 'dart:async';

import 'package:SMLingg/app/components/custom.class_appbar.component.dart';
import 'package:SMLingg/app/loading_screen/loading.view.dart';
import 'package:SMLingg/app/unit/tool_tip_model.dart';
import 'package:SMLingg/app/unit/tool_tips.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/services/save_result.service.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:SMLingg/services/unit_list.service.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';

class UnitScreen extends StatefulWidget {
  final int grade;
  final String bookID;
  final double startPosition;

  UnitScreen({this.grade, this.bookID, this.startPosition = 0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UnitState();
  }
}

class _UnitState extends State<UnitScreen> {
  List<Unit> unitList = [];
  int unitCount = 0;
  StreamController emit;
  ShowMore aPopup;
  ScrollController _controller = ScrollController();
  int currentIndex = 0;
  int pressTime = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Application.unitList = UnitList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (aPopup != null) {
      aPopup.dismiss();
    }
    if (emit != null) {
      emit.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController(
      initialScrollOffset: widget.startPosition ?? 0,
      keepScrollOffset: true,
    );

    // TODO: implement build
    return FutureBuilder(
        future: UnitListService().loadUnitList(widget.bookID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            unitList = Application.unitList.units;
            unitCount = unitList.length;
            var listKeys = List.generate(unitCount, (index) => GlobalKey());
            return Scaffold(
                backgroundColor: AppColor.mainBackGround,
                appBar: MyCustomAppbar(
                  classIndex: widget.grade,
                  unitScreen: true,
                  showAvatar: false,
                  title: '${'GRADE'} ${'${widget.grade}'}',
                  height: SizeConfig.screenHeight * 0.11,
                  width: SizeConfig.screenWidth,
                ),
                body: Consumer<UnitModel>(builder: (context, unitModel, child) {
                  unitModel.initUser(unitCount);
                  return ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: Colors.lightBlueAccent,
                        child: Center(child: Container(width: SizeConfig.screenWidth,child: SingleChildScrollView(
                          controller: _controller,
                          child: Column(children: [
                            ...List.generate(
                              (unitCount % 3 == 0)
                                  ? (unitCount ~/ 3 * 2)
                                  : (unitCount ~/ 3 * 2 + 1),
                                  (index) => ((index) % 2 == 1)
                                  ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 10),
                                child: Column(
                                  children: [
                                    _hexagon(index ~/ 2 * 3 + 3, listKeys,
                                        index, unitModel),
                                    _unitName(
                                        unitList[index ~/ 2 * 3 + 2].name)
                                  ],
                                ),
                              )
                                  : Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 10),
                                child: Container(
                                  height: (unitList[index ~/ 2 * 3]
                                      .name
                                      .length >
                                      unitList[index ~/ 2 * 3 + 1]
                                          .name
                                          .length)
                                      ? SizeConfig.blockSizeHorizontal *
                                      35 +
                                      (unitList[index ~/ 2 * 3]
                                          .name
                                          .length ~/
                                          10 +
                                          3) *
                                          SizeConfig
                                              .blockSizeHorizontal *
                                          4
                                      : SizeConfig.blockSizeHorizontal *
                                      35 +
                                      (unitList[index ~/ 2 * 3 + 1]
                                          .name
                                          .length ~/
                                          10 +
                                          3) *
                                          SizeConfig
                                              .blockSizeHorizontal *
                                          4,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          _hexagon(index ~/ 2 * 3 + 1,
                                              listKeys, index, unitModel),
                                          _unitName(
                                              unitList[index ~/ 2 * 3]
                                                  .name),
                                        ],
                                      ),
                                      (index > unitCount ~/ 2 &&
                                          unitCount % 3 == 1)
                                          ? SizedBox(
                                        width: SizeConfig
                                            .blockSizeHorizontal *
                                            35,
                                      )
                                          : Column(
                                        children: [
                                          _hexagon(
                                              index ~/ 2 * 3 + 2,
                                              listKeys,
                                              index,
                                              unitModel),
                                          _unitName(unitList[
                                          index ~/ 2 * 3 +
                                              1]
                                              .name),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ))),
                      ));
                }));
          } else {
            return LoadingScreen();
          }
        });
  }

  Widget _hexagon(int unit, List listKeys, int index, UnitModel unitModel) {
    return GestureDetector(
      key: listKeys[unit - 1] as Key,
      onTap: () {
        if (currentIndex == index) {
          pressTime++;
        } else {
          currentIndex = index;
          pressTime = 0;
        }
        if (Provider.of<UnitModel>(context, listen: false).open) {
          if (aPopup != null) {
            aPopup.dismiss();
          }
          Provider.of<UnitModel>(context, listen: false).setOpen(false);
        }
        emit = StreamController();
        aPopup = popup(tooltips(context, widget.grade, widget.bookID,
            Application.unitList.units, unit - 1, emit,
            offset: _controller.offset));
        emit.stream.listen((a) => {
              aPopup.dismiss(),
              emit.close(),
              Provider.of<UnitModel>(context, listen: false).setOpen(false)
            });

        showToolTips(
            aPopup, listKeys[unit - 1] as GlobalKey<State<StatefulWidget>>);
        if (pressTime >= 3) {
          SaveResultService()
              .saveResult(
                  bookId: widget.bookID,
                  lessonIndex: Application.unitList.units[unit - 1].userLesson,
                  levelIndex: Application.unitList.units[unit - 1].userLevel,
                  unitId: Application.unitList.units[unit - 1].sId,
                  timeEnd: DateTime.now().microsecondsSinceEpoch,
                  timeStart: DateTime.now().microsecondsSinceEpoch,
                  results: [],
                  doneQuestion: 0)
              .then((value) {
            if (Application.sharePreference.getString("token") != null) {
              UserProfile().loadUserProfile();
              Provider.of<ClassModel>(context, listen: false).refreshData();
            }
            UnitListService().loadUnitList(Application.currentBook.id);
          }).then((value) =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UnitScreen(
                          grade: Application.currentBook.grade,
                          bookID: Application.currentBook.id,
                          startPosition: _controller.offset)))
          );

          pressTime = 0;
        }
        print("pressTime: $pressTime");
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: ClipPolygon(
              sides: 6,
              borderRadius: 10,
              rotate: 90,
              child: Container(
                color: (unitModel.userLevel(unit - 1) ==
                            Application.unitList.units[unit - 1].totalLevels &&
                        unitModel.userLesson(unit - 1) ==
                            Application
                                .unitList.units[unit - 1].totalLessonsOfLevel)
                    ? LevelColor.levelLightColor[index % 7].withOpacity(0.6)
                    : LevelColor.defaultLightColor,
              ),
            ),
            width: SizeConfig.blockSizeHorizontal * 35,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: ClipPolygon(
                    sides: 6,
                    borderRadius: 10,
                    rotate: 90,
                    child: Stack(
                      children: [
                        Container(
                          color: (unitModel.userLevel(unit - 1) == Application.unitList.units[unit - 1].totalLevels &&
                                  unitModel.userLesson(unit - 1) == Application.unitList.units[unit - 1].totalLessonsOfLevel)
                              ? LevelColor.levelDarkColor[index % 7]
                              : LevelColor.defaultDarkColor,
                        ),
                        AnimatedPositioned(
                            duration: Duration(milliseconds: 1500),
                            bottom: (unitModel.userLesson(unit - 1) !=
                                    Application.unitList.units[unit - 1]
                                        .totalLessonsOfLevel)
                                ? -SizeConfig.blockSizeHorizontal * 28 +
                                    (unitModel.userLesson(unit - 1) /
                                            Application.unitList.units[unit - 1]
                                                .totalLessonsOfLevel) *
                                        SizeConfig.blockSizeHorizontal *
                                        28
                                : -SizeConfig.blockSizeHorizontal * 28,
                            child: Container(
                              color: Color(0xFFFDDD45),
                              height: SizeConfig.blockSizeHorizontal * 28,
                              width: SizeConfig.blockSizeHorizontal * 28,
                            ))
                      ],
                    )),
                width: SizeConfig.blockSizeHorizontal * 28,
              ),
              (unitModel.userLevel(unit - 1) ==
                          Application.unitList.units[unit - 1].totalLevels &&
                      unitModel.userLesson(unit - 1) ==
                          Application
                              .unitList.units[unit - 1].totalLessonsOfLevel)
                  ? Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -3,
                            child: Image.asset(
                              'assets/star.jpg',
                              width: SizeConfig.blockSizeHorizontal * 12,
                              color: LevelColor.coreShadowColor[index % 7],
                            ),
                          ),
                          Image.asset(
                            'assets/star.jpg',
                            width: SizeConfig.blockSizeHorizontal * 12,
                            color: LevelColor.coreColor[index % 7],
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        unitModel.userLesson(unit - 1).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD7EBFA),
                            fontSize: SizeConfig.blockSizeHorizontal * 15,
                            shadows: [
                              BoxShadow(
                                color: Color(0xFF76B9E8),
                                offset: Offset(0, 3),
                              ),
                            ]),
                      ),
                    )
            ],
          ),
          Positioned(
              top: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  (unitModel.userLevel(unit - 1) == Application.unitList.units[unit - 1].totalLevels &&
                      unitModel.userLesson(unit - 1) == Application.unitList.units[unit - 1].totalLessonsOfLevel)
                     ? Image.asset('assets/unit/lucigacfinish.png',
                          height: SizeConfig.blockSizeVertical * 5)
                      : Image.asset('assets/unit/lucgiac.png',
                          height: SizeConfig.blockSizeVertical * 5),
                  Text(
                    (unitModel.userLevel(unit - 1)).toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (unitModel.userLevel(unit - 1) ==
                                  Application
                                      .unitList.units[unit - 1].totalLevels &&
                              unitModel.userLesson(unit - 1) ==
                                  Application.unitList.units[unit - 1]
                                      .totalLessonsOfLevel)
                          ? Color(0xFFED8100)
                          : LevelColor.defaultTextColor,
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  ShowMore popup(Widget child) {
    Provider.of<UnitModel>(context, listen: false).setOpen(true);
    return ShowMore(
      context,
      child: child,
      height: SizeConfig.blockSizeHorizontal * 35,
      width: SizeConfig.blockSizeHorizontal * 70,
      backgroundColor: Color(0xFF4285F4),
      borderRadius: BorderRadius.circular(20),
    );
  }

  void showToolTips(ShowMore popup, GlobalKey key) {
    popup.show(widgetKey: key);
  }

  Widget _unitName(String name) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 35,
      child: Text(
        name,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColor.unitColor,
          fontSize: SizeConfig.blockSizeHorizontal * 4,
        ),
      ),
    );
  }
}
