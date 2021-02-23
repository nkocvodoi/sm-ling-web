import 'dart:math';

import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/components/dialog_show_message_and_action.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:conreality_headset/conreality_headset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import './match_pair.dart';
import './sort_words.dart';

// ignore: directives_ordering
import '../lesson.provider.dart';

class RecorderToText extends StatefulWidget {
  final String type;

  RecorderToText({this.type});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecorderToTextState();
  }
}

class _RecorderToTextState extends State<RecorderToText> {
  var words = Application.lessonInfo.words;
  String _currentLocaleId = "vi_VN";
  var sentences = Application.lessonInfo.sentences;
  Map<String, dynamic> languages = {"en_US": "Tiếng Anh (Hoa Kỳ)", "vi_VN": "Tiếng Việt (Việt Nam)"};
  int count = 0;
  bool _hasSpeech = false;
  double level = 0.0;
  int currentIndex = 0;
  double minSoundLevel = 0;
  double maxSoundLevel = 100;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String answer = "";
  List<String> answerLetters = <String>[];
  List<double> soundWaveList = [0, 0, 0, 0, 0, 0, 0];
  Questions question;
  final SpeechToText speech = SpeechToText();
  bool headphonesConnected;
  bool recording = false;

  @override
  void initState() {
    super.initState();
    checkForHeadphoneConnection();
    if (!_hasSpeech) initSpeechState();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speech.cancel();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(onStatus: statusListener, onError: errorListener);
    if (hasSpeech) {
      _currentLocaleId = widget.type == "vi" ? "vi_VN" : "en_US";
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  // ignore: avoid_void_async
  void checkForHeadphoneConnection() async {
    try {
      headphonesConnected = await await Headset.isConnected;
    } on PlatformException {
      headphonesConnected = false;
    }
    if (!headphonesConnected) {
      createDialogShowMessageAndAction(
          context: context,
          top: SizeConfig.blockSizeVertical * 50,
          title: "Please plugin headphone for better recorder!".i18n,
          titleLeftButton: "".i18n,
          titleRightButton: "Understand!".i18n,
          leftAction: () {},
          rightAction: () {
            Get.back();
          });
    }
  }

  void startListening() {
    lastWords = "";
    Provider.of<LessonModel>(context, listen: false).setInputValue(lastWords);
    Provider.of<LessonModel>(context, listen: false).handleTypeAnswer();
    answer = Provider.of<LessonModel>(context, listen: false).handleAnswerWhenWrong();
    answerLetters = answer.split(" ");
    print(answerLetters);
    lastError = "";
    speech.listen(
        onResult: resultListener,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: false,
        listenMode: ListenMode.search);

    Future.delayed(Duration(milliseconds: question.type == "sentence" ? (answerLetters.length * 1200) : 3000), () {
      speech.stop();
      if (lastWords.isEmpty) {
        if (currentIndex == Provider.of<LessonModel>(context, listen: false).focusWordIndex) {
          Fluttertoast.showToast(
            msg: "Please speak louder".i18n,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 0.5.toInt(),
            backgroundColor: Colors.redAccent.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else if (lastWords.isNotEmpty) {
        count += 1;
        Provider.of<LessonModel>(context, listen: false).handleTypeAnswer();
        Provider.of<LessonModel>(context, listen: false).checkRightAnswer(
            listStringWord: Provider.of<MatchPairModel>(context, listen: false).idAnswerList,
            selectedStringSentence: Provider.of<SortWordsModel>(context, listen: false).wordSelectedString,
            addFalseQuestionToList: false,
            numberOfRecorderToText: count);
        if (count >= 3) {
          count = 0;
        }
      }
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      Provider.of<LessonModel>(context, listen: false).setInputValue(lastWords);
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    print(level);
    setState(() {
      this.level = level;
      soundWaveList.removeAt(0);
      soundWaveList.add(level);
    });
  }

  void errorListener(SpeechRecognitionError error) {}

  void statusListener(String status) {}

  @override
  Widget build(BuildContext context) {
    if (currentIndex != Provider.of<LessonModel>(context, listen: false).focusWordIndex) {
      count = 0;
      question =
          Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
      currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    }
    return Container(
        height: SizeConfig.safeBlockVertical * 50,
        child: Column(children: [
          Container(
              height: SizeConfig.safeBlockHorizontal * 45,
              width: SizeConfig.safeBlockHorizontal * 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: .26, spreadRadius: level * 1.5, color: Color(0xFFD965F4).withOpacity(.1))
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(180)),
              ),
              child: CustomButton(
                  deactivate: Provider.of<LessonModel>(context, listen: false).hasCheckedAnswer != 0,
                  height: SizeConfig.safeBlockHorizontal * 40,
                  width: SizeConfig.safeBlockHorizontal * 40,
                  backgroundColor: Color(0xFFE88FFD),
                  shadowColor: Color(0xFFD965F4),
                  radius: 360,
                  child:
                      // !_hasSpeech || speech.isListening
                      //     ? Container(
                      //         width: SizeConfig.safeBlockHorizontal * 30,
                      //         child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      //           ...List.generate(
                      //               soundWaveList.length,
                      //               (index) => Container(
                      //                   height: SizeConfig.safeBlockHorizontal * 5 + soundWaveList[index] * SizeConfig.safeBlockHorizontal * 1,
                      //                   width: SizeConfig.safeBlockHorizontal * 2.5,
                      //                   decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(90))))
                      //         ]))
                      //     :
                      SvgPicture.asset("assets/16typh_on_the_mic.svg"),
                  onPressed: () => !_hasSpeech || speech.isListening ? null : startListening())),
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TextSize.fontSize18,
                      color: AppColor.buttonText,
                      fontFamily: TextSize.fontFamily),
                  children: [
                    ...List.generate(
                        Provider.of<LessonModel>(context, listen: false).inputValue.split(" ").length,
                        (index) => TextSpan(
                            text: "${Provider.of<LessonModel>(context, listen: false).inputValue.split(" ")[index]} ",
                            style: TextStyle(
                                color: (answerLetters.contains(
                                        Provider.of<LessonModel>(context, listen: false).inputValue.split(" ")[index]))
                                    ? AppColor.correctButtonBackground
                                    : AppColor.wrongButtonBackground)))
                  ]),
            ),
          )
        ]));
  }
}
