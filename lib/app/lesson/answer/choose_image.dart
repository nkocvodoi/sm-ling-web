import 'dart:convert';

import 'package:SMLingg/resources/i18n.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../config/application.dart';
import '../../../config/config_screen.dart';
import '../../components/custom_button.component.dart';
import '../lesson.provider.dart';
import '../lesson.provider.dart';

class ChooseImage extends StatefulWidget {
  final List<String> types;

  ChooseImage({this.types});

  @override
  State<StatefulWidget> createState() {
    return _ChooseImageState();
  }
}

class _ChooseImageState extends State<ChooseImage> {
  var words = Application.lessonInfo.words;
  var sentences = Application.lessonInfo.sentences;

  // AudioPlayer audioPlayer = AudioPlayer();
  int currentIndex = 0;
  var question, wordsLength;
  int maxLength = 0;
  final player = AudioPlayer();

  double handleHeight() {
    double wordLength = (10 + TextSize.fontSize16 * 1.25 * maxLength).toDouble();
    return widget.types.contains("image")
        ? SizeConfig.safeBlockVertical * 18
        : SizeConfig.safeBlockVertical * 20 +
        SizeConfig.safeBlockVertical * 8 * (wordLength ~/ (SizeConfig.safeBlockHorizontal * 40 - 10) / 6).toDouble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LessonModel>(context,listen: false).chooseImageState(true);
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    wordsLength = question.words.length;
    question.words.shuffle();
    if (question.words.length > 0) {
      for (var wordId in question.words) {
        var word = widget.types.contains("vi")
            ? words[words.indexWhere((element) => element.sId == wordId)].meaning
            : words[words.indexWhere((element) => element.sId == wordId)].content;
        if (maxLength < word.length) {
          maxLength = word.length;
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<LessonModel>(
      builder: (_, lessonModel, __) {
        if (currentIndex != lessonModel.focusWordIndex) {
          lessonModel.chooseImageState(true);
          question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
          question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
          wordsLength = question.words.length;
          question.words.shuffle();
          if (question.words.length > 0) {
            for (var wordId in question.words) {
              var word = widget.types.contains("vi")
                  ? words[words.indexWhere((element) => element.sId == wordId)].meaning
                  : words[words.indexWhere((element) => element.sId == wordId)].content;
              if (maxLength < word.length) {
                maxLength = word.length;
              }
            }
          }
          currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
        }
        print((SizeConfig.safeBlockHorizontal * 40 - 10) / 8);
        return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text("* In case you need help".i18n,
                //         style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.mainThemesFocus, fontSize: TextSize.fontSize16)),
                //     Container(
                //       decoration: BoxDecoration(
                //         color: Colors.transparent,
                //         borderRadius: BorderRadius.circular(180),
                //       ),
                //       height: SizeConfig.screenHeight * 0.04,
                //       width: SizeConfig.safeBlockHorizontal * 23,
                //       alignment: Alignment.center,
                //       child: Stack(
                //         children: [
                //           Positioned(
                //               left: SizeConfig.blockSizeHorizontal * 8,
                //               top: SizeConfig.screenHeight * 0.006,
                //               child: Container(
                //                 decoration: BoxDecoration(color: Color(0xFFADD6F3), borderRadius: BorderRadius.circular(180)),
                //                 height: SizeConfig.screenHeight * 0.03,
                //                 width: SizeConfig.safeBlockHorizontal * 23 / 2,
                //               )),
                //           AnimatedPositioned(
                //               left: Provider.of<LessonModel>(context, listen: false).show
                //                   ? SizeConfig.safeBlockHorizontal * 4
                //                   : SizeConfig.safeBlockHorizontal * 12,
                //               child: GestureDetector(
                //                 onTap: () async => Provider.of<LessonModel>(context, listen: false).setShow(),
                //                 child: Container(
                //                   decoration: BoxDecoration(
                //                       border: Border.all(color: Colors.white, width: 3),
                //                       color: Provider.of<LessonModel>(context, listen: false).show ? Color(0xFFADD6F3) : Color(0xFF4285F4),
                //                       shape: BoxShape.circle),
                //                   height: SizeConfig.screenHeight * 0.04,
                //                   width: SizeConfig.safeBlockHorizontal * 13,
                //                   alignment: Alignment.center,
                //                 ),
                //               ),
                //               duration: Duration(milliseconds: 400)),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: SizeConfig.safeBlockHorizontal * 5),
                ...List.generate(
                    (wordsLength % 2 == 1) ? (wordsLength ~/ 2 + 1).toInt() : wordsLength ~/ 2,
                        (index) => (index * 2 + 2 <= wordsLength)
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                            2,
                                (dex) => _imageTextCustomButton(
                                text: widget.types.contains("vi")
                                    ? words[words.indexWhere((element) => element.sId == question.words[index * 2 + dex])].meaning
                                    : words[words.indexWhere((element) => element.sId == question.words[index * 2 + dex])].content,
                                idAnswer: question.words[index * 2 + dex]))
                      ],
                    )
                        : _imageTextCustomButton(
                        text: widget.types.contains("vi")
                            ? words[words.indexWhere((element) => element.sId == question.words[index * 2])].meaning
                            : words[words.indexWhere((element) => element.sId == question.words[index * 2])].content,
                        idAnswer: question.words[index * 2]))
              ],
            ));
      },
    );
  }

  Widget _imageTextCustomButton({
    String text,
    String idAnswer,
  }) {
    var word = Application.lessonInfo.findWord(idAnswer);
    var imageUrl = "https://s.sachmem.vn/public/dics_stable/${word.imageRoot}/${word.content}.jpg";
    return Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 4),
        child: CustomButton(
            deactivate: (Provider.of<LessonModel>(context, listen: false).hasCheckedAnswer != 0),
            onPressed: () async {
              Provider.of<LessonModel>(context, listen: false).setIdAnswer(idAnswer);
              if (widget.types.contains("audio")) {
                md5.convert(utf8.encode(word.content)).toString();
                String soundUrl = 'https://s.sachmem.vn/public/audio/dictionary/${md5.convert(utf8.encode(word.content)).toString()}.mp3';
                // audioPlayer.play(soundUrl, isLocal: false);
                player.setUrl(soundUrl);
                player.play();
              }
            },
            padding: EdgeInsets.only(right: 5, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  imageUrl,
                  height: SizeConfig.safeBlockVertical * 15,
                ),
                (!widget.types.contains("image") && !Provider.of<LessonModel>(context, listen: false).show)
                    ? Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.buttonText, fontSize: TextSize.fontSize16))
                    : SizedBox()
              ],
            ),
            width: SizeConfig.safeBlockHorizontal * 40,
            height: handleHeight(),
            borderColor: (idAnswer == Provider.of<LessonModel>(context, listen: false).idAnswer) ? AppColor.mainThemesFocus : Colors.transparent,
            shadowColor: (idAnswer == Provider.of<LessonModel>(context, listen: false).idAnswer) ? AppColor.mainThemesFocus : AppColor.mainThemes));
  }
}
