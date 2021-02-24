import 'package:SMLingg/app/lesson/answer/choose_word.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class QuestionType10Sent extends StatelessWidget {
  Questions question;

  QuestionType10Sent(this.question);

  @override
  Widget build(BuildContext context) {
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsContent(
              command: "Choose the correct answer.",
              content: s.vnText,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        ChooseWord(type: "en"),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
