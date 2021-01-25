import 'package:SMLingg/app/lesson/answer/choose_image.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class QuestionType4Word extends StatelessWidget {
  Questions question;

  QuestionType4Word(this.question);

  @override
  Widget build(BuildContext context) {
    Words w = Application.lessonInfo.findWord(question.focusWord);
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsContent(command: "Chọn hình ảnh và âm thanh tương ứng.", content: w.content)),
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        ChooseImage(
          types: ["vi", "audio"],
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
