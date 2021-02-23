import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/app/lesson/question/command.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType17Sent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
//    var question = Application.lessonInfo.lesson.questions[4];
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: Command(
              command: "Arrange words into sentences correctly.".i18n,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        SortWords(type: "en"),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
