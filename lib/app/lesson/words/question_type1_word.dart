import 'package:SMLingg/app/lesson/answer/choose_image.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType1Word extends StatelessWidget {
  Questions question;

  QuestionType1Word(this.question);

  @override
  Widget build(BuildContext context) {
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    Words w = Application.lessonInfo.findWord(question.focusWord);

    // TODO: implement build
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
          child: CommandVsContent(
            command: "Chọn ảnh của từ.",
            content: w.content,
          )),
      SizedBox(height: SizeConfig.safeBlockVertical * 2),
      ChooseImage(types: ["vi"]),
      SizedBox(
        height: SizeConfig.safeBlockVertical * 5,
      )
    ]);
  }
}
