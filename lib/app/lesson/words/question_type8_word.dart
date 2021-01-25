import 'package:SMLingg/app/lesson/answer/fill_text_field.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType8Word extends StatelessWidget {
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
            child: CommandVsContent(
              command: "Điền từ tiếng Việt tương ứng.",
              content: w.content,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        FillTextField(type: "vi"),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
