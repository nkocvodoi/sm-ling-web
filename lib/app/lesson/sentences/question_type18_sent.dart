import 'package:SMLingg/app/lesson/answer/fill_text_field.dart';
import 'package:SMLingg/app/lesson/question/command_vs_vncontent_enarray.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType18Sent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var question =
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    List<String> enArray = [];
    for (int i = 0; i < s.en.length; i++) {
      enArray.add(s.en[i].text);
    }
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: CommandVsVnContentVsEnArray(
              command: "Hoàn thành bản dịch.",
              vnContent: s.vnText,
              enArray: s.en,
              isHiddenWord: true,
              hiddenWord: question.hiddenWord,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        FillTextField(
          type: "en",
        )
      ],
    );
  }
}
