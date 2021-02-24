import 'package:SMLingg/app/components/dialog_show_message_and_action.dart';
import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/app/lesson/lesson.provider.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/app/unit/unit.view.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

final player = AudioPlayer();

void backFunction(BuildContext context, LessonModel lessonModel, MatchPairModel matchPairModel, SortWordsModel sortWordsModel, double offset,
    String bookId, int grade) {
  createDialogShowMessageAndAction(
      context: context,
      top: SizeConfig.blockSizeVertical * 50,
      title: "Do you want to quit?",
      message: "The previous results will not be saved",
      titleLeftButton: "Cancel",
      titleRightButton: "Quit",
      leftAction: () {
        Navigator.pop(context);
      },
      rightAction: () {
        Provider.of<UnitModel>(context, listen: false).clearSave();
        player.pause();
        player.stop();
        sortWordsModel.clearAll();
        matchPairModel.clearAll();
        lessonModel.clearAll();
        Navigator.pop(context);
        Get.off(UnitScreen(
          startPosition: offset,
          grade: grade,
          bookID: bookId,
        ));
      });
}
