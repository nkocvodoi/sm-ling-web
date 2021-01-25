import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/question/command.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class QuestionType9Word extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Phần câu hỏi vẫn chưa được thiết kế
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding:
                EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: Command(command: "Nối cặp từ tương ứng.")),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),

        MatchPair(),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
