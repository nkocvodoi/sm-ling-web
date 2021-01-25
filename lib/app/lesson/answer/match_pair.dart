import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/save_questions/save_questions.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: directives_ordering
import '../lesson.provider.dart';

class MatchPair extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MatchPairState();
  }
}

class _MatchPairState extends State<MatchPair> {
  var words = Application.lessonInfo.words;
  var sentences = Application.lessonInfo.sentences;
  int currentIndex = 0;
  var question, wordsLength;
  List<Word> wordList = <Word>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex as int;
    question =
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int];
    if (question.type == "word") {
      if (wordList.isEmpty) {
        question.words.forEach((element) {
          wordList.add(Word(word: words[words.indexWhere((value) => value.sId == element)].meaning, idAnswer: element));
          wordList.add(Word(word: words[words.indexWhere((value) => value.sId == element)].content, idAnswer: element));
        });
        wordList.shuffle();
      }
    } else if (question.type == "sentence") {
      if (wordList.isEmpty) {
        question.sentences.forEach((element) {
          if (element != null) {
            wordList.add(
                Word(word: sentences[sentences.indexWhere((value) => value.sId == element)].vnText, idAnswer: element));
            wordList.add(
                Word(word: sentences[sentences.indexWhere((value) => value.sId == element)].enText, idAnswer: element));
          }
        });
        wordList.shuffle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchPairModel>(builder: (_, matchPairModel, __) {
      if (currentIndex != Provider.of<LessonModel>(context, listen: false).focusWordIndex) {
        wordList = <Word>[];
        if (question.type == "word") {
          if (wordList.isEmpty) {
            question.words.forEach((element) {
              wordList
                  .add(Word(word: words[words.indexWhere((value) => value.sId == element)].meaning, idAnswer: element));
              wordList
                  .add(Word(word: words[words.indexWhere((value) => value.sId == element)].content, idAnswer: element));
            });
            wordList.shuffle();
          }
        } else if (question.type == "sentence") {
          if (wordList.isEmpty) {
            question.sentences.forEach((element) {
              if (element != null) {
                wordList.add(Word(
                    word: sentences[sentences.indexWhere((value) => value.sId == element)].vnText, idAnswer: element));
                wordList.add(Word(
                    word: sentences[sentences.indexWhere((value) => value.sId == element)].enText, idAnswer: element));
              }
            });
            wordList.shuffle();
          }
        }
        currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
      }
      return Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: SizeConfig.safeBlockVertical * 2),
        ...List.generate(
            wordList.length,
            (index) =>
                _sentenceButton(text: wordList[index].word, idAnswer: wordList[index].idAnswer, context: context)),
        SizedBox(height: SizeConfig.safeBlockVertical * 5),
      ]));
    });
  }

  Widget _sentenceButton({String text, String idAnswer, BuildContext context}) {
    double wordLength = (40 + TextSize.fontSize18 * text.length).toDouble();
    return Consumer<MatchPairModel>(builder: (_, matchPairModel, __) {
      return Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
          child: AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: matchPairModel.idAnswerList.contains(idAnswer) ? 0 : 1,
              child: CustomButton(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  elevation: 4,
                  deactivate: matchPairModel.idAnswerList.contains(idAnswer),
                  radius: 90,
                  onPressed: () {
                    matchPairModel.setAnswer(idAnswer: idAnswer, text: text, context: context);
                  },
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: TextSize.fontSize16,
                        color: matchPairModel.textFirst == text || matchPairModel.textSecond == text
                            ? matchPairModel.isEqual == null
                                ? AppColor.buttonText
                                : matchPairModel.isEqual
                                    ? AppColor.buttonCorrectText
                                    : AppColor.buttonWrongText
                            : AppColor.buttonText),
                  ),
                  backgroundColor: matchPairModel.textFirst == text || matchPairModel.textSecond == text
                      ? matchPairModel.isEqual == null
                          ? Colors.white
                          : matchPairModel.isEqual
                              ? AppColor.correctLightButtonBackground
                              : AppColor.wrongLightButtonBackground
                      : Colors.white,
                  width: SizeConfig.safeBlockHorizontal * 80,
                  height: SizeConfig.blockSizeVertical * 8 +
                      SizeConfig.blockSizeVertical *
                          8 *
                          (wordLength ~/ (SizeConfig.safeBlockHorizontal * 80 - 40) / 8).toDouble(),
                  borderColor: matchPairModel.textFirst == text || matchPairModel.textSecond == text
                      ? matchPairModel.isEqual == null
                          ? AppColor.mainThemesFocus
                          : matchPairModel.isEqual
                              ? AppColor.correctButtonBackground
                              : AppColor.wrongButtonBackground
                      : Colors.transparent,
                  shadowColor: matchPairModel.textFirst == text || matchPairModel.textSecond == text
                      ? matchPairModel.isEqual == null
                          ? AppColor.mainThemesFocus
                          : matchPairModel.isEqual
                              ? AppColor.correctButtonShadow
                              : AppColor.wrongButtonShadow
                      : AppColor.mainThemes)));
    });
  }
}

class MatchPairModel extends ChangeNotifier {
  List<String> _idAnswerList = <String>[];

  get idAnswerList => _idAnswerList;

  bool _isEqual;

  get isEqual => _isEqual;

  String _idAnswerFirst;

  get idAnswerFirst => _idAnswerFirst;

  String _textFirst;

  get textFirst => _textFirst;

  String _textSecond;

  get textSecond => _textSecond;

  String _idAnswerSecond;

  get idAnswerSecond => _idAnswerSecond;

  void clearAll() {
    _idAnswerList = <String>[];
    _isEqual = null;
    _idAnswerFirst = null;
    _idAnswerSecond = null;
    _textFirst = null;
    _textSecond = null;
    notifyListeners();
  }

  void setAnswer({String text, String idAnswer, BuildContext context}) {
    if (text == _textFirst && idAnswer == _idAnswerFirst) {
      _textFirst = null;
      _idAnswerFirst = null;
    } else if (text == _textSecond && idAnswer == _idAnswerSecond) {
      _textSecond = null;
      _idAnswerSecond = null;
    } else if (_textFirst == null && _idAnswerFirst == null) {
      _textFirst = text;
      _idAnswerFirst = idAnswer;
    } else if (_textFirst != null && _idAnswerFirst != null && _textSecond == null && _idAnswerSecond == null) {
      _textSecond = text;
      _idAnswerSecond = idAnswer;
    }
    if (_textFirst != null && _textSecond != null) {
      checkEqual(context);
    }
    notifyListeners();
  }

  void setIdAnswerList() {
    _idAnswerList = <String>[];
    notifyListeners();
  }

  void setIsEqual(bool value, BuildContext context) {
    _isEqual = value;
    if (value && !_idAnswerList.contains(_idAnswerFirst)) {
      _idAnswerList.add(_idAnswerFirst);
    }
    if (_idAnswerList.length ==
        Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex as int]
            .words.length) {
      Provider.of<LessonModel>(context, listen: false).setHasCheckedAnswer(1);
      Provider.of<LessonModel>(context, listen: false).startSound();
      Provider.of<LessonModel>(context, listen: false).increaseRightAnswer();
      Future.delayed(Duration(milliseconds: 1000), () {
        Provider.of<LessonModel>(context, listen: false).handleTypeAnswer();
        Provider.of<LessonModel>(context, listen: false).changeNextQuestion( changeQuestion: false);
        setIdAnswerList();
      });
    }
    Future.delayed(Duration(milliseconds: 500), () {
      _textFirst = null;
      _idAnswerFirst = null;
      _textSecond = null;
      _idAnswerSecond = null;
      _isEqual = null;
      notifyListeners();
    });
    notifyListeners();
  }

  void checkEqual(BuildContext context) {
    setIsEqual(_idAnswerFirst == _idAnswerSecond, context);
    AnswerForMatchPairType a = AnswerForMatchPairType(first: _idAnswerFirst, second: _idAnswerSecond);
    Provider.of<LessonModel>(context, listen: false).addPairForSaveQuestion(a);
    notifyListeners();
  }
}

class Word {
  String word;
  String idAnswer;

  Word({this.word, this.idAnswer});
}
