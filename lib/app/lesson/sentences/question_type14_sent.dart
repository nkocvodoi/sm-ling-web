import 'package:SMLingg/app/lesson/answer/fill_text_field.dart';
import 'package:SMLingg/app/lesson/question/command_vs_sound.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType14Sent extends StatelessWidget {
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
            child: CommandVsSound(
              command: "Listen and write.",
              soundUrl: s.audio,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        FillTextField(
          type: "en",
          hintText: "Nhập câu bạn nghe được",
        )
      ],
    );
  }
}
