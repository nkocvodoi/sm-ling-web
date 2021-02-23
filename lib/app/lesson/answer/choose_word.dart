import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class ChooseWord extends StatefulWidget {
  final String type;

  ChooseWord({this.type});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChooseWordState();
  }
}

class _ChooseWordState extends State<ChooseWord> {
  var words = Application.lessonInfo.words;
  var sentences = Application.lessonInfo.sentences;
  var question, wordsLength;
  List<String> sentenceAnswerWords = <String>[];
  int currentIndex = 0;
  int longestWord = 0;

  double handleWidth({bool isTypeSentence, bool hasHiddenWord}) {
    double wordLength = (40 + TextSize.fontSize18 * longestWord).toDouble();
    return isTypeSentence && !hasHiddenWord
        ? SizeConfig.safeBlockHorizontal * 80
        : wordLength <= SizeConfig.safeBlockHorizontal * 80
            ? wordLength
            : SizeConfig.safeBlockHorizontal * 80;
  }

  double handleHeight({bool isTypeSentence, bool hasHiddenWord, int textLength}) {
    double wordLength = (40 + TextSize.fontSize18 * textLength).toDouble();
    return !isTypeSentence
        ? SizeConfig.blockSizeVertical * 8
        : hasHiddenWord
            ? SizeConfig.blockSizeVertical * 8
            : SizeConfig.blockSizeVertical * 8 +
                SizeConfig.blockSizeVertical * 8 * (wordLength ~/ (SizeConfig.safeBlockHorizontal * 80 - 40) / 8).toDouble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    sentenceAnswerWords = <String>[];
    if (question.type == "sentence") {
      var sentence = Application.lessonInfo.findSentence(question.focusSentence);
      sentenceAnswerWords.addAll(question.wrongWords);
      if (question.hiddenWord != -1) {
        if (widget.type == "en") {
          sentenceAnswerWords.add(sentence.en[question.hiddenWord].text);
        } else {
          sentenceAnswerWords.add(sentence.vn[question.hiddenWord].text);
        }
        sentenceAnswerWords.forEach((element) {
          if (element.length > longestWord) longestWord = element.length;
        });
      }
    } else {
      question.words.forEach((element) {
        if (widget.type == "vi") {
          int wordLength = words.indexWhere((dex) => dex.sId == element)!= -1 ? words[words.indexWhere((dex) => dex.sId == element)].meaning.length : 0;
          if (wordLength > longestWord) longestWord = wordLength;
        } else {
          int wordLength = words.indexWhere((dex) => dex.sId == element) != -1 ?words[words.indexWhere((dex) => dex.sId == element)].content.length : 0;
          if (wordLength > longestWord) longestWord = wordLength;
        }
      });
      print(longestWord);
      question.words.shuffle();
    }
    wordsLength = question.words != null
        ? question.words.length
        : question.sentences.isNotEmpty
            ? question.sentences.length
            : question.hiddenWord != -1
                ? question.wrongWords.length + 1
                : question.wrongWords.length;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LessonModel>(
      builder: (_, lessonModel, __) {
        if (currentIndex != lessonModel.focusWordIndex) {
          question = Application.lessonInfo.lesson.questions[lessonModel.focusWordIndex];
          sentenceAnswerWords = <String>[];
          if (question.type == "sentence") {
            var sentence = Application.lessonInfo.findSentence(question.focusSentence);
            sentenceAnswerWords.addAll(question.wrongWords);
            if (question.hiddenWord != -1) {
              if (widget.type == "en") {
                sentenceAnswerWords.add(sentence.en[question.hiddenWord].text);
              } else {
                sentenceAnswerWords.add(sentence.vn[question.hiddenWord].text);
              }
              sentenceAnswerWords.forEach((element) {
                if (element.length > longestWord) longestWord = element.length;
              });
            }
          } else {
            question.words.forEach((element) {
              if (widget.type == "vi") {
                int wordLength = words[words.indexWhere((dex) => dex.sId == element)].meaning.length;
                if (wordLength > longestWord) longestWord = wordLength;
              } else {
                int wordLength = words[words.indexWhere((dex) => dex.sId == element)].content.length;
                if (wordLength > longestWord) longestWord = wordLength;
              }
            });
            question.words.shuffle();
          }
          wordsLength = question.words != null
              ? question.words.length
              : question.sentences.isNotEmpty
                  ? question.sentences.length
                  : question.hiddenWord != -1
                      ? question.wrongWords.length + 1
                      : question.wrongWords.length;
          currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
        }
        return Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          ...List.generate(
              wordsLength,
              (index) => question.words != null
                  ? _wordButton(
                      text: widget.type == "vi"
                          ? words[words.indexWhere((element) => element.sId == question.words[index])].meaning
                          : words[words.indexWhere((element) => element.sId == question.words[index])].content,
                      idAnswer: question.words[index],
                      type: question.type)
                  : question.sentences.isNotEmpty
                      ? _wordButton(
                          text: widget.type == "vi"
                              ? sentences[sentences.indexWhere((element) => element.sId == question.sentences[index])].vnText
                              : sentences[sentences.indexWhere((element) => element.sId == question.sentences[index])].enText,
                          idAnswer: question.sentences[index],
                          type: question.type)
                      : _wordButton(text: sentenceAnswerWords[index], idAnswer: null, type: question.type)),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
        ]));
      },
    );
  }

  Widget _wordButton({String text, String idAnswer, String type}) {
    return Consumer<LessonModel>(
        builder: (_, lessonModel, __) => Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
            child: CustomButton(
                elevation: 5,
                radius: 25,
                deactivate: lessonModel.hasCheckedAnswer != 0,
                padding: EdgeInsets.only(left: 20, right: 20),
                onPressed: () {
                  if (idAnswer != null) {
                    lessonModel.setIdAnswer(idAnswer);
                  } else {
                    lessonModel.setWordAnswer(text);
                  }
                },
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: TextSize.fontSize18, color: AppColor.buttonText)),
                width: handleWidth(
                    isTypeSentence: type == "sentence",
                    hasHiddenWord: Application.lessonInfo.lesson.questions[lessonModel.focusWordIndex].hiddenWord != -1),
                height: handleHeight(
                    isTypeSentence: type == "sentence",
                    hasHiddenWord: Application.lessonInfo.lesson.questions[lessonModel.focusWordIndex].hiddenWord != -1,
                    textLength: text.length),
                borderColor: idAnswer != null
                    ? idAnswer == lessonModel.idAnswer
                        ? AppColor.mainThemesFocus
                        : Colors.transparent
                    : text == lessonModel.wordAnswer
                        ? AppColor.mainThemesFocus
                        : Colors.transparent,
                shadowColor: text == lessonModel.wordAnswer || idAnswer == lessonModel.idAnswer && idAnswer != null
                    ? AppColor.mainThemesFocus
                    : AppColor.mainThemes)));
  }
}
