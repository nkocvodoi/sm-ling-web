import 'package:SMLingg/app/lesson/answer/choose_word.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType13Word extends StatelessWidget {
  Questions question;
  QuestionType13Word(this.question);
  @override
  Widget build(BuildContext context) {
    var question =
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    Words w = Application.lessonInfo.findWord(question.focusWord);
    // Phần câu hỏi vẫn chưa được thiết kế
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsContent(command: "Tìm từ tiếng Anh tương ứng.", content: w.meaning)),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        ChooseWord(
          type: "en"
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
