import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/components/water_wave.component.dart';
import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/app/lesson/lesson.provider.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/app/unit/unit.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../config/application.dart';

class FinishLessonScreen extends StatefulWidget {
  final int correctAnswer, totalQuestion;
  final List<dynamic> results;
  final int timeStart;
  final int timeEnd;
  final int focusWordIndex;
  final double offset;

  // type = 1 thể hiện hoàn thành bài học
  // type = 2 thể hiện hoàn thành cấp độ

  FinishLessonScreen(
      {this.correctAnswer,
      this.totalQuestion,
      this.results,
      this.timeStart,
      this.timeEnd,
      this.focusWordIndex,
      this.offset});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState;
    return _FinishLessonScreenState();
  }
}

class _FinishLessonScreenState extends State<FinishLessonScreen> {
  bool _firstPoint = false;
  bool _secondPoint = false;
  bool _thirdPoint = false;
  bool _fourthPoint = false;
  bool _levelup = false;
  int plusMark, type;

  // int userLesson = 3, userLevel = 3, totalLessonsOfLevel = 4, correctAnswer = 9, totalQuestion = 10;

  void checkType() {
    if ((Application.currentUnit.userLesson + 1) == Application.currentUnit.totalLessonsOfLevel) {
      // người dùng hoàn thành cấp độ
      type = 2;
    } else {
      // người dùng hoàn thành bài học
      type = 1;
      plusMark = 1;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("correctAnswer: ${widget.correctAnswer}");
    print("offset: ${widget.offset}");
    print("focusWordIndex: ${widget.focusWordIndex}");
    print("timeStart: ${widget.timeStart}");
    print("timeEnd: ${widget.timeEnd}");
    print("results: ${widget.results}");
    print("totalQuestion: ${widget.totalQuestion}");
    checkType();
    Future.delayed(Duration(milliseconds: 1000), () => setState(() => _firstPoint = true)).then((value) =>
        Future.delayed(Duration(milliseconds: 700), () => setState(() => _secondPoint = true)).then((value) =>
            Future.delayed(Duration(milliseconds: 1000), () => setState(() => _thirdPoint = true))
                .then((value) => Future.delayed(Duration(milliseconds: 500), () => setState(() => _fourthPoint = true)))
                .then((value) => Future.delayed(Duration(milliseconds: 2000), () => setState(() => _levelup = true)))));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    // checkType();
    return Scaffold(
        backgroundColor: AppColor.mainBackGround,
        body: Center(
            child: SizedBox(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                child: Stack(alignment: Alignment.topCenter, children: [
                  AnimatedOpacity(
                      opacity: _secondPoint ? 0 : 1,
                      duration: Duration(milliseconds: 500),
                      child: Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: AppColor.mainThemes,
                          child:  SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Stack(alignment: Alignment.center, children: [
                              Positioned(
                                  left: SizeConfig.safeBlockHorizontal * 0.5,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColor.mainThemesFocus,
                                      ),
                                      onPressed: () {})),
                              Positioned(
                                  left: SizeConfig.safeBlockHorizontal * 12,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Container(
                                          height: SizeConfig.safeBlockHorizontal * 4.8,
                                          width: SizeConfig.safeBlockHorizontal * 80,
                                          child: Stack(alignment: Alignment.center, children: [
                                            Container(
                                              width: SizeConfig.blockSizeHorizontal * 80,
                                              color: Colors.white,
                                            ),
                                            AnimatedPositioned(
                                              left: _firstPoint
                                                  ? 0
                                                  : -SizeConfig.blockSizeHorizontal * 80 +
                                                      (widget.correctAnswer) *
                                                          SizeConfig.blockSizeHorizontal *
                                                          80 /
                                                          widget.totalQuestion,
                                              duration: Duration(milliseconds: 500),
                                              child: Container(
                                                height: SizeConfig.safeBlockHorizontal * 6,
                                                width: SizeConfig.safeBlockHorizontal * 80,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFFDDD45),
                                                    border: Border.all(color: Colors.white),
                                                    borderRadius: BorderRadius.circular(90)),
                                              ),
                                            ),
                                            Container(
                                              height: SizeConfig.safeBlockHorizontal * 4.8,
                                              width: SizeConfig.safeBlockHorizontal * 80,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(color: Colors.white, width: 1.5),
                                                  borderRadius: BorderRadius.circular(90)),
                                            )
                                          ]))))
                            ]),
                          )
                      )
                  ),
                  Positioned(
                      top: 0,
                      child: AnimatedOpacity(
                          opacity: _fourthPoint ? 1 : 0,
                          duration: Duration(milliseconds: 2000),
                          child: Lottie.asset('assets/lottie/fireworks-background.json',
                              height: SizeConfig.safeBlockVertical * 50))),
                  AnimatedPositioned(
                      top: _secondPoint ? SizeConfig.safeBlockVertical * 20 : SizeConfig.safeBlockVertical * 75,
                      duration: Duration(milliseconds: 2000),
                      child: AnimatedOpacity(
                          opacity: _thirdPoint ? 1 : 0,
                          duration: Duration(milliseconds: 1000),
                          child: Image.asset('assets/congrats.png', height: SizeConfig.safeBlockVertical * 15))),
                  AnimatedPositioned(
                      top: _secondPoint ? SizeConfig.safeBlockVertical * 23 : SizeConfig.safeBlockVertical * 75,
                      duration: Duration(milliseconds: 2000),
                      child: AnimatedOpacity(
                          opacity: _thirdPoint ? 1 : 0,
                          duration: Duration(milliseconds: 1000),
                          child:
                              // Image.asset('assets/congrats.png', height: SizeConfig.safeBlockVertical * 15)
                              Text("CONGRATS",
                                  style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontSize: SizeConfig.safeBlockHorizontal * 8,
                                      color: Color(0xFF4285F4),
                                      fontWeight: FontWeight.w800)))),
                  AnimatedPositioned(
                      top: _secondPoint ? SizeConfig.safeBlockVertical * 35 : SizeConfig.safeBlockVertical * 75,
                      duration: Duration(milliseconds: 2000),
                      child: AnimatedOpacity(
                          opacity: _levelup && type == 2
                              ? 0
                              : _thirdPoint
                                  ? 1
                                  : 0,
                          duration: Duration(milliseconds: _levelup && type == 2 ? 500 : 1000),
                          child: Column(
                            children: [
                              SizedBox(height: SizeConfig.safeBlockVertical * 2),
                              Text(
                                  (Application.currentUnit.userLesson + 1) > Application.currentUnit.totalLessonsOfLevel
                                      ? 'You have completed the practice'
                                      : 'You have completed the lesson',
                                  style: TextStyle(
                                      color: Color(0xFF4285F4),
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
                              SizedBox(height: SizeConfig.safeBlockVertical * 2),
                              AnimatedOpacity(
                                  opacity: _fourthPoint ? 1 : 0,
                                  duration: Duration(milliseconds: 500),
                                  child: (Application.currentUnit.userLesson + 1) >
                                          Application.currentUnit.totalLessonsOfLevel
                                      ? SizedBox()
                                      : type == 1
                                          ? Row(
                                              children: [
                                                Text('+${plusMark.toString()} ',
                                                    style: TextStyle(
                                                        color: Color(0xFF4285F4),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: TextSize.fontSize40)),
                                                Image.asset(
                                                    "assets/class/droplets.png",
                                                  height: SizeConfig.safeBlockVertical * 4.5,
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text('+1 ',
                                                    style: TextStyle(
                                                        color: Color(0xFF4285F4),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: TextSize.fontSize40)),
                                                Image.asset('assets/class/bee.png', width: TextSize.fontSize40),
                                              ],
                                            ))
                            ],
                          ))),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      top: _fourthPoint ? SizeConfig.safeBlockVertical * 50 : SizeConfig.safeBlockVertical * 120,
                      child: AnimatedOpacity(
                          opacity: _levelup && type == 2
                              ? 0
                              : _fourthPoint
                                  ? 1
                                  : 0,
                          duration: Duration(milliseconds: _levelup && type == 2 ? 500 : 1100),
                          child: ClipRRect(
                              child: Container(
                                  height: SizeConfig.safeBlockVertical * 30,
                                  width: SizeConfig.safeBlockVertical * 30,
                                  child: Stack(alignment: Alignment.center, children: [
                                    WaveBall(
                                      circleColor: Color(0xFFE5F3FD),
                                      backgroundColor: Colors.yellowAccent,
                                      foregroundColor: Colors.yellow,
                                      size: SizeConfig.safeBlockVertical * 28,
                                      progress: (Application.currentUnit.userLesson + 1) >=
                                              Application.currentUnit.totalLessonsOfLevel
                                          ? 1
                                          : (Application.currentUnit.userLesson + 1) /
                                              Application.currentUnit.totalLessonsOfLevel,
                                    ),
                                    Image.asset('assets/hive2.png', height: SizeConfig.safeBlockVertical * 30)
                                  ]))))),
                  Positioned(
                      top: SizeConfig.safeBlockVertical * 20 + SizeConfig.safeBlockHorizontal * 28,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: _levelup && type == 2 ? 1 : 0,
                        child: Column(
                          children: [
                            Image.asset('assets/medal.png', height: SizeConfig.safeBlockVertical * 30),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2),
                            Text(
                                Application.currentUnit.userLevel == Application.currentUnit.totalLevels
                                    ? "You have completed the unit"
                                    : "",
                                // "LEVEL ${(Application.currentUnit.userLevel + 1).toString()}",
                                style: TextStyle(
                                    color: Color(0xFF4285F4),
                                    fontWeight: FontWeight.w700,
                                    fontSize: TextSize.fontSize25)),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2),
                            Application.currentUnit.userLevel == Application.currentUnit.totalLevels
                                ? SizedBox()
                                : Text('PROMOTION',
                                    style: TextStyle(
                                        color: Color(0xFF4285F4),
                                        fontSize: TextSize.fontSize40,
                                        fontWeight: FontWeight.w700))
                          ],
                        ),
                      )),
                  Application.currentUnit.userLevel == Application.currentUnit.totalLevels
                      ? SizedBox()
                      : Positioned(
                          top: SizeConfig.safeBlockVertical * 20 + SizeConfig.safeBlockHorizontal * 34,
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _levelup && type == 2 ? 1 : 0,
                              child: Text((Application.currentUnit.userLevel + 1).toString(),
                                  style:
                                      TextStyle(color: Color(0xFFE88B00), fontSize: 70, fontWeight: FontWeight.w700)))),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: _thirdPoint ? 1000 : 800),
                      right: _thirdPoint
                          ? SizeConfig.safeBlockHorizontal * 42.5
                          : _secondPoint
                          ? SizeConfig.safeBlockHorizontal * 40
                          : SizeConfig.safeBlockHorizontal * 4.5,
                      top: _thirdPoint
                          ? SizeConfig.safeBlockVertical * 60
                          : _secondPoint
                          ? SizeConfig.safeBlockVertical * 25
                          : SizeConfig.safeBlockVertical * 0.25,
                      child: AnimatedContainer(
                          height: SizeConfig.safeBlockHorizontal * 15,
                          width: _thirdPoint
                              ? SizeConfig.safeBlockHorizontal * 15
                              : _secondPoint
                              ? SizeConfig.safeBlockHorizontal * 20
                              : SizeConfig.safeBlockHorizontal * 6,
                          duration: Duration(milliseconds: 500),
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _fourthPoint ? 0 : 1,
                              child:
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child:
                                Image.asset("assets/class/droplets.png",height: SizeConfig.safeBlockHorizontal * 5),
                              // )
                          ))),

                ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AnimatedOpacity(
            opacity: _fourthPoint ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: CustomButton(
                elevation: 6,
                child: Text(
                  "CONTINUE",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: TextSize.fontSize18, color: Color(0xff6CA9D3)),
                ),
                radius: 90,
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 80,
                backgroundColor: AppColor.mainThemes,
                shadowColor: AppColor.mainThemesFocus,
                onPressed: () async {
                  int index =
                      Application.unitList.units.indexWhere((element) => element.sId == Application.currentUnit.sId);
                  Provider.of<UnitModel>(context, listen: false).clearSave();
                  Provider.of<LessonModel>(context, listen: false).clearAll();
                  Provider.of<MatchPairModel>(context, listen: false).clearAll();
                  Provider.of<SortWordsModel>(context, listen: false).clearAll();
                  Provider.of<ClassModel>(context, listen: false).refreshData();
                  !Provider.of<UnitModel>(context, listen: false).checkContinue
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnitScreen(
                                  grade: Application.currentBook.grade,
                                  bookID: Application.currentBook.id,
                                  startPosition: widget.offset)))
                      : Get.offAllNamed("/class");
                })));
  }
}
