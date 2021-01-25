import 'package:SMLingg/app/lesson/answer/choose_word.dart';
import 'package:SMLingg/app/lesson/question/command_vs_content_vs_sound.dart';
import 'package:SMLingg/app/lesson/question/command_vs_vncontent_vs_sound.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

// ignore: must_be_immutable
class QuestionType7Sent extends StatelessWidget {
  Questions question;

  QuestionType7Sent(this.question);

  @override
  Widget build(BuildContext context) {
    Sentences s = Application.lessonInfo.findSentence(question.focusSentence);
    // TODO: implement build
    print(s.en);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
          child: CommandVsVnContentVsSound(
            command: "Nghe và chọn từ còn thiếu vào chỗ trống.",
            enArray: s.en,
            isHiddenWord: true,
            hiddenWord: question.hiddenWord,
            soundUrl: s.audio,
          ),
        ),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        ChooseWord(type: "en"),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
