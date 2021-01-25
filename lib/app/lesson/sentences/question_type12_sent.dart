import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/app/lesson/question/command_vs_vncontent_enarray.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType12Sent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var question =
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
//    var question = Application.lessonInfo.lesson.questions[4];
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsContent(
              command: "Sắp xếp thành bản dịch đúng.",
              content: s.enText,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        SortWords(type: "vi"),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
