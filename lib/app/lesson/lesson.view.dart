import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/lesson/question_common.view.dart';
import 'package:SMLingg/app/loading_screen/loading.view.dart';
import 'package:SMLingg/app/report/report_dialog.dart';
import 'package:SMLingg/app/unit/unit.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:SMLingg/services/lesson_info.service.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:SMLingg/utils/back_function_lession.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../models/lesson/lesson_info.dart';
import 'answer/match_pair.dart';
import 'answer/sort_words.dart';
import 'lesson.provider.dart';
import 'lesson_show_error_message.view.dart';

class LessonScreen extends StatefulWidget {
  final int userLevel;
  final int userLesson;
  final String id;
  final double offset;

  LessonScreen({Key key, this.userLesson, this.userLevel, this.id, this.offset}) : super(key: key);

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  TextEditingController errorController = TextEditingController();
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LessonModel>(context, listen: false)
      ..setOffset(widget.offset)
      ..clearAll();
    Provider.of<MatchPairModel>(context, listen: false).clearAll();
    Provider.of<SortWordsModel>(context, listen: false).clearAll();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    errorController.dispose();
    super.dispose();
  }

  double handleHeight({int textLength}) {
    if (textLength > 0) {
      double wordLength = (40 + TextSize.fontSize18 * textLength).toDouble();
      return SizeConfig.safeBlockHorizontal * 45 +
          SizeConfig.safeBlockVertical * 8 * (wordLength ~/ (SizeConfig.safeBlockHorizontal * 90 - 30) / 6).toDouble();
    } else {
      return SizeConfig.safeBlockHorizontal * 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Application.sharePreference.getInt("count") == 1) {
      Application.sharePreference
        ..putInt("saveGrade", Application.currentBook.grade)
        ..putString("saveBookId", Application.currentBook.id);
    }
    final int saveGrade = Application.sharePreference.getInt("saveGrade");
    final String saveCurrentBookId = Application.sharePreference.getString("saveBookId");
    // TODO: implement build
    return FutureBuilder(
        future: LessonInfoService().loadLessonInfo(bookID: saveCurrentBookId, lesson: widget.userLesson, level: widget.userLevel, unitID: widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Questions> questions = Application.lessonInfo.lesson.questions;
            if (questions.isNotEmpty) {
              return ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Colors.lightBlueAccent,
                  child: Scaffold(
                      backgroundColor: AppColor.mainBackGround,
                      body: Consumer3<LessonModel, MatchPairModel, SortWordsModel>(builder: (_, lessonModel, matchPairModel, sortWordsModel, __) {
                        return WillPopScope(
                            onWillPop: () async {
                              backFunction(context, lessonModel, matchPairModel, sortWordsModel, widget.offset, saveCurrentBookId, saveGrade);
                              return true;
                            },
                            child: Stack(alignment: Alignment.center, children: [
                              SizedBox(
                                  height: SizeConfig.screenHeight,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    children: [
                                      Container(
                                        height: SizeConfig.safeBlockVertical * 10,
                                        width: SizeConfig.screenWidth,
                                        color: AppColor.mainThemes,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                                left: SizeConfig.safeBlockHorizontal * 0.5,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: AppColor.mainThemesFocus,
                                                    ),
                                                    onPressed: () {
                                                      backFunction(context, lessonModel, matchPairModel, sortWordsModel, widget.offset,
                                                          saveCurrentBookId, saveGrade);
                                                    })),
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
                                                            left: (-SizeConfig.blockSizeHorizontal * 80 +
                                                                (lessonModel.rightAnswer) *
                                                                    SizeConfig.blockSizeHorizontal *
                                                                    80 /
                                                                    Application.lessonInfo.lesson.totalQuestions),
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
                                                                border: Border.all(color: Colors.white, width: 2),
                                                                borderRadius: BorderRadius.circular(90)),
                                                          )
                                                        ])))),
                                            Positioned(
                                              right: SizeConfig.safeBlockHorizontal * 5,
                                              child: Image.asset(
                                                "assets/class/droplets.png",
                                                height: SizeConfig.safeBlockVertical * 4.5,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      //Todo: Phân loại questionType
                                      QuestionCommon(
                                        question: Application.lessonInfo.lesson.questions[lessonModel.focusWordIndex],
                                      ),
                                      SizedBox(height: SizeConfig.safeBlockHorizontal * 15)
                                    ],
                                  ))),
                              Positioned(
                                  bottom: SizeConfig.safeBlockVertical * 1.5,
                                  child: lessonModel.hasCheckedAnswer != 0
                                      ? Container(
                                          alignment: Alignment.bottomCenter,
                                          width: SizeConfig.safeBlockHorizontal * 90,
                                          height: lessonModel.hasCheckedAnswer == 1
                                              ? SizeConfig.safeBlockHorizontal * 50
                                              : handleHeight(textLength: lessonModel.handleAnswerWhenWrong().length),
                                          decoration: BoxDecoration(
                                              color: lessonModel.hasCheckedAnswer == 1
                                                  ? AppColor.correctBackground
                                                  : lessonModel.hasCheckedAnswer == 2
                                                      ? AppColor.wrongBackground
                                                      : Color(0xFFFFED95),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                  bottomLeft: Radius.circular(30),
                                                  bottomRight: Radius.circular(30))),
                                          child: Column(children: [
                                            Expanded(child: SizedBox()),
                                            lessonModel.hasCheckedAnswer == 1
                                                ? Row(
                                                    children: [
                                                      SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                                                      Text(
                                                          (lessonModel.score >= 0.5 && lessonModel.score < 0.9)
                                                              ? "Almost Correct.".i18n
                                                              : "Correct.".i18n,
                                                          style: TextStyle(
                                                              color: AppColor.correctButtonShadow,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: TextSize.fontSize18)),
                                                      Expanded(child: SizedBox()),
                                                      reportButton(
                                                          color: AppColor.correctButtonShadow,
                                                          focusWordIndex: lessonModel.focusWordIndex,
                                                          saveCurrentBookId: saveCurrentBookId),
                                                      SizedBox(width: SizeConfig.safeBlockHorizontal * 5)
                                                    ],
                                                  )
                                                : lessonModel.hasCheckedAnswer == 2
                                                    ? lessonModel.isRecorderToText()
                                                        ? Row(
                                                            children: [
                                                              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                                                              Text("Better try next time !".i18n,
                                                                  style: TextStyle(
                                                                      color: AppColor.wrongButtonShadow,
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: TextSize.fontSize16)),
                                                              Expanded(child: SizedBox()),
                                                              reportButton(
                                                                  color: AppColor.wrongButtonShadow,
                                                                  focusWordIndex: lessonModel.focusWordIndex,
                                                                  saveCurrentBookId: saveCurrentBookId),
                                                              SizedBox(width: SizeConfig.safeBlockHorizontal * 5)
                                                            ],
                                                          )
                                                        : ListTile(
                                                            title: Text("The correct answer:".i18n,
                                                                style: TextStyle(
                                                                    fontFamily: TextSize.fontFamily,
                                                                    color: AppColor.wrongButtonShadow,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: TextSize.fontSize18)),
                                                            subtitle: Text(lessonModel.handleAnswerWhenWrong(),
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    fontFamily: TextSize.fontFamily,
                                                                    color: AppColor.wrongButtonShadow,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: TextSize.fontSize18)),
                                                            trailing: reportButton(
                                                                color: AppColor.wrongButtonShadow,
                                                                focusWordIndex: lessonModel.focusWordIndex,
                                                                saveCurrentBookId: saveCurrentBookId),
                                                          )
                                                    : ListTile(
                                                        title: Text("Hmmm... something not right".i18n,
                                                            style: TextStyle(
                                                                fontFamily: TextSize.fontFamily,
                                                                color: Color(0xFFEF8F00),
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: TextSize.fontSize18)),
                                                        subtitle: Text("Please try again".i18n,
                                                            textAlign: TextAlign.left,
                                                            style: TextStyle(
                                                                fontFamily: TextSize.fontFamily,
                                                                color: Color(0xFFEF8F00),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: TextSize.fontSize18)),
                                                        trailing: reportButton(
                                                            color: Color(0xFFEF8F00),
                                                            focusWordIndex: lessonModel.focusWordIndex,
                                                            saveCurrentBookId: saveCurrentBookId),
                                                      ),
                                            Expanded(child: SizedBox()),
                                            CustomButton(
                                                deactivate: lessonModel.onSubmitted,
                                                elevation: 6,
                                                child: Text("CONTINUE".i18n,
                                                    style:
                                                        TextStyle(fontWeight: FontWeight.w700, fontSize: TextSize.fontSize18, color: Colors.white)),
                                                radius: 90,
                                                height: SizeConfig.safeBlockHorizontal * 13,
                                                width: SizeConfig.safeBlockHorizontal * 90,
                                                backgroundColor: lessonModel.hasCheckedAnswer == 1
                                                    ? AppColor.correctButtonBackground
                                                    : lessonModel.hasCheckedAnswer == 2
                                                        ? AppColor.wrongButtonBackground
                                                        : Color(0xFFF8CD01),
                                                shadowColor: lessonModel.hasCheckedAnswer == 1
                                                    ? AppColor.correctButtonShadow
                                                    : lessonModel.hasCheckedAnswer == 2
                                                        ? AppColor.wrongButtonShadow
                                                        : Color(0xFFF8B301),
                                                onPressed: () async {
                                                  sortWordsModel.resetWordList();
                                                  matchPairModel.setIdAnswerList();
                                                  lessonModel.changeNextQuestion();
                                                })
                                          ]))
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            lessonModel.isRecorderToText()
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      sortWordsModel.resetWordList();
                                                      matchPairModel.setIdAnswerList();
                                                      lessonModel.changeNextQuestion();
                                                    },
                                                    child: Text("CANNOT TALK RIGHT NOW".i18n,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: TextSize.fontSize18,
                                                            color: AppColor.mainThemesFocus)),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              height: SizeConfig.safeBlockVertical * 2,
                                            ),
                                            CustomButton(
                                                elevation: 6,
                                                deactivate: !lessonModel.hasPicked(context: context),
                                                child: Text(
                                                  "CHECK".i18n,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: TextSize.fontSize18,
                                                      color: !lessonModel.hasPicked(context: context) ? AppColor.submitButtonText : Colors.white),
                                                ),
                                                radius: 90,
                                                height: SizeConfig.safeBlockHorizontal * 13,
                                                width: SizeConfig.safeBlockHorizontal * 90,
                                                backgroundColor:
                                                    lessonModel.hasPicked(context: context) ? AppColor.correctButtonBackground : AppColor.mainThemes,
                                                shadowColor:
                                                    lessonModel.hasPicked(context: context) ? AppColor.correctButtonShadow : AppColor.mainThemesFocus,
                                                onPressed: () async {
                                                  await lessonModel.handleTypeAnswer();
                                                  await lessonModel.checkRightAnswer(
                                                    listStringWord: matchPairModel.idAnswerList,
                                                    selectedStringSentence: sortWordsModel.wordSelectedString,
                                                  );
                                                  player.pause();
                                                  player.stop();
                                                })
                                          ],
                                        ))
                            ]));
                      })),
                ),
              );
            } else {
              return LessonShowLoadQuestionError(message: "Upcoming soon".i18n);
            }
          } else if (snapshot.hasError) {
            print("snapshot.error: ${snapshot.error}");
            return WillPopScope(
              onWillPop: () async {
                Get.off(UnitScreen(
                  grade: saveGrade,
                  bookID: saveCurrentBookId,
                  startPosition: widget.offset,
                ));
                return true;
              },
              child: LoadingScreen(),
            );
          } else {
            return WillPopScope(
              onWillPop: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UnitScreen(
                              grade: saveGrade,
                              bookID: saveCurrentBookId,
                              startPosition: widget.offset,
                            )));
                return true;
              },
              child: LoadingScreen(),
            );
          }
        });
  }

  Widget reportButton({int focusWordIndex, String saveCurrentBookId, Color color}) {
    return IconButton(
        icon: Icon(FontAwesomeIcons.flag, color: color, size: 25),
        onPressed: () {
          reportDialog(
              context,
              errorController,
              saveCurrentBookId,
              Application.currentUnit.sId,
              Application.currentUnit.userLevel ?? 0,
              Application.currentUnit.userLesson ?? 0,
              Application.lessonInfo.lesson.questions[focusWordIndex],
              Application.lessonInfo.lesson.questions[focusWordIndex].type == "word"
                  ? Application.lessonInfo.findWord(Application.lessonInfo.lesson.questions[focusWordIndex].focusWord).content
                  : Application.lessonInfo.findSentence(Application.lessonInfo.lesson.questions[focusWordIndex].focusSentence).enText,
              Application.lessonInfo.lesson.questions[focusWordIndex].type == "word"
                  ? Application.lessonInfo.findWord(Application.lessonInfo.lesson.questions[focusWordIndex].focusWord).meaning
                  : Application.lessonInfo.findSentence(Application.lessonInfo.lesson.questions[focusWordIndex].focusSentence).vnText,
              '',
              DateTime.now().toString());
        });
  }
}
