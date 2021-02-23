import 'package:SMLingg/app/lesson/answer/fill_text_field.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content_vs_sound.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType15Sent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    String content = Application.lessonInfo.createContentHasHiddenWord(s.en, question.hiddenWord);
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsContentVsSound(
                command: "Listen and complete the blank.".i18n, content: content, soundUrl: s.audio, blank: true, type: "sentence")),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        FillTextField()
      ],
    );
  }
}
