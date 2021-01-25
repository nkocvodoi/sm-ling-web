import 'dart:convert';

import 'package:SMLingg/themes/style.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/application.dart';
import '../../../config/config_screen.dart';
import '../../components/custom_button.component.dart';
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
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  int currentIndex = 0;
  var question, wordsLength;
  int maxLength = 0;

  double handleHeight() {
    double wordLength = (10 + TextSize.fontSize16 * 1.25 * maxLength).toDouble();
    return widget.types.contains("image")
        ? SizeConfig.safeBlockVertical * 18
        : SizeConfig.safeBlockVertical * 20 +
            SizeConfig.safeBlockVertical *
                8 *
                (wordLength ~/ (SizeConfig.safeBlockHorizontal * 40 - 10) / 6).toDouble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.release();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex as int;
    question =
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
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
    audioPlayer.stop();
    audioPlayer.dispose();
    audioCache.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<LessonModel>(
      builder: (_, lessonModel, __) {
        if (currentIndex != lessonModel.focusWordIndex) {
          question = Application
              .lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
          wordsLength = question.words.length;
          question.words.shuffle();
          if (question.words.length > 0) {
            for (var wordId in question.words) {
              var word = widget.types.contains("vi")
                  ? words[words.indexWhere((element) => element.sId == wordId)].meaning
                  : words[words.indexWhere((element) => element.sId == wordId)].content;
              if (maxLength < word.length) {
                maxLength = word.length ;
              }
            }
          }
          currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex as int;
        }
        print((SizeConfig.safeBlockHorizontal * 40 - 10) / 8);
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                                      ? words[words
                                              .indexWhere((element) => element.sId == question.words[index * 2 + dex])]
                                          .meaning
                                      : words[words
                                              .indexWhere((element) => element.sId == question.words[index * 2 + dex])]
                                          .content,
                                  idAnswer: question.words[index * 2 + dex]))
                        ],
                      )
                    : _imageTextCustomButton(
                        text: widget.types.contains("vi")
                            ? words[words.indexWhere((element) => element.sId == question.words[index + 1])].meaning
                            : words[words.indexWhere((element) => element.sId == question.words[index + 1])].content,
                        idAnswer: question.words[index + 1]))
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
            onPressed: () {
              audioPlayer.stop();
              audioPlayer.release();
              Provider.of<LessonModel>(context, listen: false).setIdAnswer(idAnswer);
              if (widget.types.contains("audio")) {
                md5.convert(utf8.encode(word.content)).toString();
                String soundUrl =
                    'https://s.sachmem.vn/public/audio/dictionary/${md5.convert(utf8.encode(word.content)).toString()}.mp3';
                audioPlayer.play(soundUrl, isLocal: false);
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
                !widget.types.contains("image")
                    ? Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: AppColor.buttonText, fontSize: TextSize.fontSize16))
                    : SizedBox()
              ],
            ),
            width: SizeConfig.safeBlockHorizontal * 40,
            height: handleHeight(),
            borderColor: (idAnswer == Provider.of<LessonModel>(context, listen: false).idAnswer)
                ? AppColor.mainThemesFocus
                : Colors.transparent,
            shadowColor: (idAnswer == Provider.of<LessonModel>(context, listen: false).idAnswer)
                ? AppColor.mainThemesFocus
                : AppColor.mainThemes));
  }
}
