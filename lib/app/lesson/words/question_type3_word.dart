import 'dart:convert';

import 'package:SMLingg/app/lesson/answer/choose_image.dart';
import 'package:SMLingg/app/lesson/question/command_vs_sound.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType3Word extends StatelessWidget {
  Questions question;

  QuestionType3Word(this.question);

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
            child: CommandVsSound(command: "Chọn hình ảnh và nghĩa tương ứng.", soundUrl: soundUrl)),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        ChooseImage(
          types: ["vi"],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
