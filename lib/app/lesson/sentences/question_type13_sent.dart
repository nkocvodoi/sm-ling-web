import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/question/command.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class QuestionType13Sent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: SizeConfig.safeBlockHorizontal * 5, right: SizeConfig.safeBlockHorizontal * 5),
            child: Command(
              command: "Matching pair.".i18n,
            )),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
        MatchPair(),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 5,
        )
      ],
    );
  }
}
