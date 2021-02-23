import 'dart:convert';

import 'package:SMLingg/app/lesson/answer/choose_word.dart';
import 'package:SMLingg/app/lesson/question/command_vs_sound.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class QuestionType6Word extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuestionType6WordState();
  }
}

// ignore: must_be_immutable
class _QuestionType6WordState extends State<QuestionType6Word> {
  String soundUrl;

  @override
  Widget build(BuildContext context) {
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    Words w = Application.lessonInfo.findWord(question.focusWord);
    md5.convert(utf8.encode(w.content)).toString();
    String soundUrl = 'https://s.sachmem.vn/public/audio/dictionary/${md5.convert(utf8.encode(w.content)).toString()}.mp3';
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsSound(command: "Chọn từ phù hợp với âm thanh.", soundUrl: soundUrl)),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        ChooseWord(),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
