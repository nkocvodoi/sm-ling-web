import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/models/save_questions/save_questions.dart';
import 'package:SMLingg/services/recheck_question.service.dart';
import 'package:SMLingg/services/save_result.service.dart';
import 'package:SMLingg/services/unit_list.service.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:provider/provider.dart';
import 'finish_screen/finish_lesson.view.dart';

class LessonModel extends ChangeNotifier {
  List<int> questionTypeWordEN = [4, 6, 11, 7, 13, 14, 12];
  List<int> questionTypeWordVI = [3, 8, 9];
  List<int> questionTypeWordImage = [1, 2, 3, 4];
  List<int> questionTypeSentencesEN = [10, 1, 2, 17, 14, 7, 15, 18, 4];
  List<int> questionTypeSentencesVI = [12, 13, 16];
  List<int> matchPairType = [9];
  List<AnswerForMatchPairType> answerForMatchPairType =
      <AnswerForMatchPairType>[];
  List<dynamic> results = [];
  int timeStart;
  int timeEnd;
  String _type;
  double _score = 0;
  double _offset = 0;

  double get offset => _offset;

  void setOffset(double value) {
    _offset = value;
    notifyListeners();
  }

  double get score => _score;

  bool _startSound = false;

  void Function() get startSound => _playSound;

  String get type => _type;

  int _rightAnswer = 0;

  int get rightAnswer => _rightAnswer;

  String _wordAnswer;

  String get wordAnswer => _wordAnswer;

  int _focusWordIndex = 0;

  int get focusWordIndex => _focusWordIndex;

  int _hasCheckedAnswer = 0;

  int get hasCheckedAnswer => _hasCheckedAnswer;

  bool _show = true;

  bool get show => _show;

  String _inputValue = "";

  String get inputValue => _inputValue;

  bool _onSubmitted = false;

  bool get onSubmitted => _onSubmitted;

  String _idAnswer;

  String get idAnswer => _idAnswer;

  void cancelSound() {
    _startSound = !_startSound;
    notifyListeners();
  }

  void clearAll() {
    answerForMatchPairType = <AnswerForMatchPairType>[];
    results = [];
    timeStart = null;
    timeEnd = null;
    _type = null;
    _rightAnswer = 0;
    _wordAnswer = null;
    _focusWordIndex = 0;
    _hasCheckedAnswer = 0;
    _inputValue = "";
    _onSubmitted = false;
    _idAnswer = null;
    notifyListeners();
  }

  void setOnSubmitted(bool value) {
    _onSubmitted = value;
    notifyListeners();
  }

  void addPairForSaveQuestion(AnswerForMatchPairType answer) {
    if (answer != null) {
      print("answer: ${answer.first} ${answer.second}");
      print("answerForMatchPairType: $answerForMatchPairType");
      answerForMatchPairType.add(answer);
      print("answerForMatchPairType: $answerForMatchPairType");

      notifyListeners();
    }
  }

  void setHasCheckedAnswer(int value) {
    _hasCheckedAnswer = value;
    notifyListeners();
  }

  void setIdAnswer(String value) {
    _idAnswer = value;
    notifyListeners();
  }

  void setShow() {
    _show = !_show;
    notifyListeners();
  }

  void setWordAnswer(String value) {
    _wordAnswer = value;
    notifyListeners();
  }

  void setInputValue(String value) {
    _inputValue = value;
    notifyListeners();
  }

  void setRightAnswer(int value) {
    _rightAnswer = value;
    notifyListeners();
  }

  void startLesson() {
    timeStart = DateTime.now().microsecondsSinceEpoch;
  }

  void finishLesson() {
    timeEnd = DateTime.now().microsecondsSinceEpoch;
  }

  void addFalseQuestionToEndList(Questions question) {
    if (_hasCheckedAnswer == 2) {
      print("addFalseQuestionToEndList!!!!!!");
      Application.lessonInfo.lesson.questions.add(question);
    }
  }

  bool isRecorderToText() {
    var question = Application.lessonInfo.lesson.questions[_focusWordIndex];
    if (question.type == "word" && question.questionType == 12) return true;
    if (question.type == "sentence" && question.questionType == 4) return true;
    return false;
  }

  // ignore: avoid_void_async
  void _playSound() async {
    final player = AudioPlayer();
    switch (_hasCheckedAnswer) {
      case 1:
        var duration = await player.setAsset('assets/sounds/correct_answer.mp3',
            preload: true);
        player.play();
        break;
      case 2:
        var duration =
            await player.setAsset('assets/sounds/wrong.mp3', preload: true);
        player.play();
        break;
    }
  }

  Future<void> checkString(Questions question,
      {bool addFalseQuestionToList = true, numberOfRecorderToText = 3}) async {
    List<String> inputStrings = formatWord(_inputValue).split(" ");
    inputStrings.forEach((element) {
      if (double.tryParse(element) != null) {
        element = NumberToWord().convert('en-in', int.parse(element));
      }
    });
    List<String> answerString = <String>[];
    if (question.type == "word") {
      Words word = Application.lessonInfo.findWord(question.focusWord);
      List<int> typeCanBeCheck = [11, 7, 12, 8, 14];
      if (typeCanBeCheck.contains(question.questionType)) {
        List<int> typeEn = [7, 11, 12, 14];
        if (typeEn.contains(question.questionType)) {
          _score = await RecheckQuestionService()
              .callApiCompareInputValueVsResultText(
                  inputValue: _inputValue, text: word.content, language: "en");
        } else {
          _score = await RecheckQuestionService()
              .callApiCompareInputValueVsResultText(
                  inputValue: _inputValue, text: word.meaning, language: "vi");
        }
      }
    } else {
      List<int> typeCanBeCheck = [14, 15, 16, 4, 18];
      if (typeCanBeCheck.contains(question.questionType)) {
        Sentences sentence =
            Application.lessonInfo.findSentence(question.focusSentence);
        List<int> typeEn = [14, 15, 4, 18];
        if (question.hiddenWord != -1) {
          if (typeEn.contains(question.questionType)) {
            String enText = sentence.en[question.hiddenWord].text;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(
                    inputValue: _inputValue, text: enText, language: "en");
          } else {
            String vnText = sentence.vn[question.hiddenWord].text;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(
                    inputValue: _inputValue, text: vnText, language: "vi");
          }
        } else {
          if (typeEn.contains(question.questionType)) {
            answerString = formatWord(sentence.enText).split(" ");
            for (int i = 0; i < answerString.length; i++) {
              if (inputStrings.contains(answerString[i])) {
                _score += 1;
              } else if (i < inputStrings.length) {
                _score += await RecheckQuestionService()
                    .callApiCompareInputValueVsResultText(
                        inputValue: inputStrings[i],
                        text: answerString[i],
                        language: "en");
              }
            }
            _score /= answerString.length;
          } else {
            answerString = formatWord(sentence.vnText).split(" ");
            for (int i = 0; i < answerString.length; i++) {
              if (inputStrings.contains(answerString[i])) {
                _score += 1;
              } else if (i < inputStrings.length) {
                _score += await RecheckQuestionService()
                    .callApiCompareInputValueVsResultText(
                        inputValue: inputStrings[i],
                        text: answerString[i],
                        language: "vi");
              }
            }
            _score /= answerString.length;
          }
        }
      }
    }
    if (isRecorderToText()) {
      if (_score >= 0.9) {
        _hasCheckedAnswer = 1;
        _inputValue = "";
        Future.delayed(Duration(milliseconds: 2000), () {
          changeNextQuestion(changeQuestion: false);
        });
      } else if (numberOfRecorderToText < 3) {
        _hasCheckedAnswer = 3;
        _inputValue = "";
        Future.delayed(Duration(seconds: 2), () {
          _hasCheckedAnswer = 0;
          notifyListeners();
        });
      } else {
        _inputValue = "";
        _hasCheckedAnswer = 2;
        Future.delayed(Duration(milliseconds: 2000), () {
          changeNextQuestion(changeQuestion: false);
        });
      }
    } else {
      if (_score >= 0.9) {
        _hasCheckedAnswer = 1;
      } else {
        _hasCheckedAnswer = 2;
      }
    }
    notifyListeners();
  }

  void checkRightAnswer(
      {List<String> listStringWord,
      List<String> selectedStringSentence,
      bool addFalseQuestionToList = true,
      int numberOfRecorderToText = 3}) {
    Questions question =
        Application.lessonInfo.lesson.questions[_focusWordIndex];
    bool result;
    if (question.type == "word") {
      Words word = Application.lessonInfo.findWord(question.focusWord);
      if (question.words.isNotEmpty) {
        if (_type == "VIWord") {
          result = (listStringWord.length >= question.words.length ||
              _idAnswer == question.focusWord ||
              formatWord(_inputValue) == formatWord(word.meaning));
        } else {
          result = (listStringWord.length >= question.words.length ||
              _idAnswer == question.focusWord ||
              formatWord(_inputValue) == formatWord(word.content));
        }
      } else {
        if (_type == "VIWord") {
          result = (_idAnswer == question.focusWord ||
              formatWord(_inputValue) == formatWord(word.meaning));
        } else {
          result = (_idAnswer == question.focusWord ||
              formatWord(_inputValue) == formatWord(word.content));
        }
      }
    } else if (question.type == "sentence") {
      var sentences =
          Application.lessonInfo.findSentence(question.focusSentence);
      String sentence = "";
      if (selectedStringSentence.isNotEmpty) {
        selectedStringSentence.forEach((element) {
          sentence += "$element ";
        });
        sentence = sentence.substring(0, sentence.length - 1);
        sentence = formatWord(sentence);
      }
      print("sentence $sentence");
      print("formatWord(sentences.vnText) ${formatWord(sentences.vnText)}");
      print("formatWord(sentences.vnText) ${formatWord(sentences.enText)}");
      if (question.hiddenWord != -1) {
        if (_type == "VISentence") {
          result = _idAnswer == question.focusSentence ||
              _wordAnswer == sentences.vn[question.hiddenWord].text ||
              formatWord(sentences.vnText) == sentence ||
              formatWord(_inputValue) ==
                  formatWord(sentences.vn[question.hiddenWord].text);
        } else {
          print(
              "question.hiddenWord: ${question.hiddenWord} sentences.vn[question.hiddenWord].text: ${sentences.vnText}");
          result = _idAnswer == question.focusSentence ||
              _wordAnswer == sentences.en[question.hiddenWord].text ||
              formatWord(sentences.enText) == sentence ||
              formatWord(_inputValue) ==
                  formatWord(sentences.en[question.hiddenWord].text);
        }
        print("result $result");
      } else {
        if (_type == "VISentence") {
          result = _idAnswer == question.focusSentence ||
              formatWord(sentences.vnText) == sentence ||
              formatWord(_inputValue) == formatWord(sentences.vnText);
        } else {
          result = _idAnswer == question.focusSentence ||
              formatWord(sentences.enText) == sentence ||
              formatWord(_inputValue) == formatWord(sentences.enText);
        }
        print("result $result");
        print("result ${_idAnswer == question.focusSentence}");
        print(
            "${formatWord(sentences.enText)}== $sentence = ${formatWord(sentences.enText) == sentence}");
        print(
            "${formatWord(sentences.vnText)}== $sentence = ${formatWord(sentences.vnText) == sentence}");
        print(
            "result ${formatWord(_inputValue) == formatWord(sentences.enText)}");
      }
    }
    if (_inputValue.isNotEmpty && !result) {
      print("_inputValue $_inputValue");
      checkString(question,
          numberOfRecorderToText: numberOfRecorderToText,
          addFalseQuestionToList: addFalseQuestionToList);
    } else {
      _hasCheckedAnswer = result ? 1 : 2;
    }
    if (_hasCheckedAnswer == 1 || _hasCheckedAnswer == 2) {
      _playSound();
      if (addFalseQuestionToList) {
        addFalseQuestionToEndList(question);
      }
      addElementForQuestionToSave(question, selectedStringSentence);
      increaseRightAnswer();
    }
    notifyListeners();
  }

  void increaseRightAnswer() {
    if (_rightAnswer < Application.lessonInfo.lesson.questions.length - 1) {
      if (_hasCheckedAnswer == 1) {
        _rightAnswer++;
      }
    }
    notifyListeners();
  }

  Future<void> changeNextQuestion({bool changeQuestion = true}) async {
    var question = Application.lessonInfo.lesson.questions[_focusWordIndex];
    if (!(changeQuestion &&
            matchPairType.contains(question.questionType) &&
            question.type == "word") ||
        isRecorderToText()) {
      if (_focusWordIndex <
          Application.lessonInfo.lesson.questions.length - 1) {
        _focusWordIndex++;
        answerForMatchPairType = <AnswerForMatchPairType>[];
      } else if (_focusWordIndex ==
          Application.lessonInfo.lesson.questions.length - 1) {
        setOnSubmitted(true);
        finishLesson();
        Get.off(FinishLessonScreen(
          focusWordIndex: focusWordIndex,
          results: results,
          timeEnd: timeEnd,
          timeStart: timeStart,
          correctAnswer: rightAnswer,
          offset: offset,
          totalQuestion: Application.lessonInfo.lesson.totalQuestions,
        ));
        SaveResultService().saveResult(
            bookId: Application.currentBook.id,
            lessonIndex: Application.currentUnit.userLesson,
            levelIndex: Application.currentUnit.userLevel,
            unitId: Application.currentUnit.sId,
            timeEnd: timeEnd,
            timeStart: timeStart,
            results: results,
            doneQuestion: focusWordIndex + 1);
        UnitListService().loadUnitList(Application.currentBook.id);

        if (Application.sharePreference.getString("token") != null) {
          UserProfile().loadUserProfile();
        }

        setOnSubmitted(false);
      }
      _score = 0;
      setIdAnswer(null);
      setWordAnswer(null);
      setInputValue("");
      _hasCheckedAnswer = 0;
    }
  }

  bool hasPicked({BuildContext context}) {
    bool pick = false;
    var question = Application.lessonInfo.lesson.questions[_focusWordIndex];
    var selectedStringSentence =
        Provider.of<SortWordsModel>(context).wordSelectedString;
    var words = question.words;
    var sentences = question.sentences;
    var pickAll;
    if (words != null) {
      pickAll = Provider.of<MatchPairModel>(context).idAnswerList.length >=
              words.length &&
          words.isNotEmpty;
    } else {
      pickAll = Provider.of<MatchPairModel>(context).idAnswerList.length >=
              sentences.length &&
          sentences.isNotEmpty;
    }
    if (question.type == "word") {
      if (question.words != null && question.words.isNotEmpty) {
        pick = _idAnswer != null ||
            _inputValue.isNotEmpty ||
            pickAll && !isRecorderToText();
      } else {
        pick =
            _idAnswer != null || _inputValue.isNotEmpty && !isRecorderToText();
      }
    } else if (question.type == "sentence") {
      pick = selectedStringSentence.isNotEmpty ||
          _idAnswer != null ||
          _wordAnswer != null ||
          _inputValue.isNotEmpty && !isRecorderToText();
    }
    return pick;
  }

  void handleTypeAnswer() {
    var question = Application.lessonInfo.lesson.questions[_focusWordIndex];
    if (question.type == "word") {
      if (questionTypeWordImage.contains(question.questionType)) {
        _type = "imageWord";
      } else if (questionTypeWordEN.contains(question.questionType)) {
        _type = "ENWord";
      } else if (questionTypeWordVI.contains(question.questionType)) {
        _type = "VIWord";
      }
    } else if (question.type == "sentence") {
      if (questionTypeSentencesEN.contains(question.questionType)) {
        _type = "ENSentence";
      } else if (questionTypeSentencesVI.contains(question.questionType)) {
        _type = "VISentence";
      }
    }
    notifyListeners();
  }

  String formatWord(String word) {
    return word.replaceAll(RegExp(r'[^\w\s]+'), "").toLowerCase();
  }

  void addElementForQuestionToSave(
      Questions currentQuestion, List<String> selectedStringSentence) {
    String type = currentQuestion.type;
    int questionType = currentQuestion.questionType;
    if (type == 'word') {
      if (questionType == 1 ||
          questionType == 2 ||
          questionType == 3 ||
          questionType == 4 ||
          questionType == 6 ||
          questionType == 13) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _idAnswer);
        results.add(r);
      } else if (questionType == 7 ||
          questionType == 14 ||
          questionType == 8 ||
          questionType == 11) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _inputValue);
        results.add(r);
      } else if (questionType == 9) {
        ResultHasListAnswer r = ResultHasListAnswer(
            sId: currentQuestion.sId, answers: answerForMatchPairType);
        results.add(r);
      } else if (questionType == 12) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      }
    } else {
      if (questionType == 1 ||
          questionType == 2 ||
          questionType == 12 ||
          questionType == 17) {
        ResultHasListAnswer r = ResultHasListAnswer(
            sId: currentQuestion.sId, answers: selectedStringSentence);
        results.add(r);
      } else if (questionType == 7 ||
          questionType == 15 ||
          questionType == 14 ||
          questionType == 18) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _wordAnswer);
        results.add(r);
      } else if (questionType == 10) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _idAnswer);
        results.add(r);
      } else if (questionType == 4) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      } else if (questionType == 16) {
        ResultHasPrimitiveVariableAnswer r = ResultHasPrimitiveVariableAnswer(
            sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      }
    }
  }

  String handleAnswerWhenWrong() {
    if ((Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord !=
                null &&
            Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord
                .isNotEmpty) ||
        (Application.lessonInfo.lesson.questions[_focusWordIndex]
                    .focusSentence !=
                null &&
            Application.lessonInfo.lesson.questions[_focusWordIndex]
                .focusSentence.isNotEmpty)) {
      return _type == "ENWord"
          ? Application.lessonInfo
              .findWord(Application
                  .lessonInfo.lesson.questions[_focusWordIndex].focusWord)
              .content
          : _type == "VIWord" || _type == "imageWord"
              ? Application.lessonInfo
                  .findWord(Application
                      .lessonInfo.lesson.questions[_focusWordIndex].focusWord)
                  .meaning
              : _type == "VISentence"
                  ? Application.lessonInfo
                      .findSentence(Application.lessonInfo.lesson
                          .questions[_focusWordIndex].focusSentence)
                      .vnText
                  : Application.lessonInfo
                      .findSentence(Application.lessonInfo.lesson
                          .questions[_focusWordIndex].focusSentence)
                      .enText;
    } else {
      return "";
    }
  }
}
