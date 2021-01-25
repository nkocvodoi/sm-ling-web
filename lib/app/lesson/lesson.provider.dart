import 'package:SMLingg/app/lesson/answer/match_pair.dart';
import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/models/save_questions/save_questions.dart';
import 'package:SMLingg/services/recheck_question.service.dart';
import 'package:SMLingg/services/save_result.service.dart';
import 'package:SMLingg/services/unit_list.service.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'finish_screen/finish_lesson.view.dart';

class LessonModel extends ChangeNotifier {
  List<int> questionTypeWordEN = [4, 6, 11, 7, 13, 14, 12];
  List<int> questionTypeWordVI = [3, 8, 9];
  List<int> questionTypeWordImage = [1, 2, 3, 4];
  List<int> questionTypeSentencesEN = [10, 1, 2, 17, 14, 7, 15, 18, 4];
  List<int> questionTypeSentencesVI = [12, 13, 16];
  List<int> matchPairType = [9];
  List<AnswerForMatchPairType> answerForMatchPairType = <AnswerForMatchPairType>[];
  List<dynamic> results = [];
  int timeStart;
  int timeEnd;
  String _type;
  double _score = 0;

  get score => _score;

  bool _startSound = false;

  get startSound => _playSound;

  get type => _type;

  int _rightAnswer = 0;

  get rightAnswer => _rightAnswer;

  String _wordAnswer;

  get wordAnswer => _wordAnswer;

  int _focusWordIndex = 0;

  get focusWordIndex => _focusWordIndex;

  int _hasCheckedAnswer = 0;

  get hasCheckedAnswer => _hasCheckedAnswer;

  String _inputValue = "";

  get inputValue => _inputValue;

  bool _onSubmitted = false;

  get onSubmitted => _onSubmitted;

  String _idAnswer;

  get idAnswer => _idAnswer;

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
    AudioCache player = AudioCache();
    player.loadAll(['sounds/correct_answer.mp3', "sounds/wrong.mp3"]);
    if (_hasCheckedAnswer == 1) {
      await player.play("sounds/correct_answer.mp3");
    } else if (_hasCheckedAnswer == 2) {
      await player.play("sounds/wrong.mp3");
    }
    player.clearCache();
  }

  void reCheckQuestion(Questions question, int result,
      {bool addFalseQuestionToList = true, numberOfRecorderToText = 3}) async {
    if (result == 2) {
      _score = 0;
      if (question.type == "word") {
        List<int> typeCanBeCheck = [11, 7, 12, 8, 14];
        if (typeCanBeCheck.contains(question.questionType)) {
          List<int> typeEn = [7, 11, 12, 14];
          if (typeEn.contains(question.questionType)) {
            String content = Application.lessonInfo
                .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)].content;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(inputValue: _inputValue, text: content, language: "en");
          } else {
            String meaning = Application.lessonInfo
                .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)].meaning;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(inputValue: _inputValue, text: meaning, language: "vi");
          }
        }
      } else {
        List<int> typeCanBeCheck = [14, 15, 16, 4, 18];
        if (typeCanBeCheck.contains(question.questionType)) {
          List<int> typeEn = [14, 15, 4, 18];
          if (typeEn.contains(question.questionType)) {
            String enText = question.hiddenWord != -1
                ? Application.lessonInfo.findSentence(question.focusSentence).en[question.hiddenWord].text
                : Application.lessonInfo.findSentence(question.focusSentence).enText;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(inputValue: _inputValue, text: enText, language: "en");
          } else {
            String vnText = question.hiddenWord != -1
                ? Application.lessonInfo.findSentence(question.focusSentence).vn[question.hiddenWord].text
                : Application.lessonInfo.findSentence(question.focusSentence).vnText;
            _score = await RecheckQuestionService()
                .callApiCompareInputValueVsResultText(inputValue: _inputValue, text: vnText, language: "vi");
          }
        }
      }
      if (isRecorderToText()) {
        if (_score >= 0.5) {
          _hasCheckedAnswer = 1;
          _inputValue = "";
          Future.delayed(Duration(seconds: 2), () {
            changeNextQuestion();
            notifyListeners();
          });
        } else if (numberOfRecorderToText < 3) {
          _hasCheckedAnswer = 3;
          _inputValue = "";
          Future.delayed(Duration(seconds: 2), () {
            _hasCheckedAnswer = 0;
            notifyListeners();
          });
        } else {
          _hasCheckedAnswer = 2;
        }
      } else {
        if (_score >= 0.9) {
          _hasCheckedAnswer = 1;
        } else {
          _hasCheckedAnswer = 2;
        }
      }
    } else {
      _hasCheckedAnswer = result;
      if (isRecorderToText()) {
        _inputValue = "";
        Future.delayed(Duration(seconds: 2), () {
          changeNextQuestion();
          notifyListeners();
        });
      }
    }
    _playSound();
    if (addFalseQuestionToList) {
      addFalseQuestionToEndList(question);
    }
    notifyListeners();
  }

  void checkRightAnswer(
      {List<String> listStringWord,
      List<String> selectedStringSentence,
      bool addFalseQuestionToList = true,
      int numberOfRecorderToText = 3}) {
    var question = Application.lessonInfo.lesson.questions[_focusWordIndex];
    bool result;
    if (question.type == "word") {
      if (question.words.isNotEmpty) {
        if (_type == "VIWord") {
          result = (listStringWord.length >= question.words.length ||
              _idAnswer == question.focusWord ||
              formatWord(_inputValue) ==
                  formatWord(Application
                      .lessonInfo
                      .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)]
                      .meaning));
        } else {
          result = (listStringWord.length >= question.words.length ||
              _idAnswer == question.focusWord ||
              formatWord(_inputValue) ==
                  formatWord(Application
                      .lessonInfo
                      .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)]
                      .content));
        }
      } else {
        if (_type == "VIWord") {
          result = (_idAnswer == question.focusWord ||
              formatWord(_inputValue) ==
                  formatWord(Application
                      .lessonInfo
                      .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)]
                      .meaning));
        } else {
          result = (_idAnswer == question.focusWord ||
              formatWord(_inputValue) ==
                  formatWord(Application
                      .lessonInfo
                      .words[Application.lessonInfo.words.indexWhere((element) => element.sId == question.focusWord)]
                      .content));
        }
      }
    } else if (question.type == "sentence") {
      var sentences = Application.lessonInfo.findSentence(question.focusSentence);
      String sentence = "";
      selectedStringSentence.forEach((element) {
        sentence += element;
      });
      sentence = formatWord(sentence);
      if (question.hiddenWord != -1) {
        if (_type == "VISentence") {
          result = _idAnswer == question.focusSentence ||
              _wordAnswer == sentences.vn[question.hiddenWord].text ||
              _wordAnswer == sentences.en[question.hiddenWord].text ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).enText) == sentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).vnText) == sentence ||
              formatWord(_inputValue) ==
                  formatWord(Application.lessonInfo.findSentence(question.focusSentence).vn[question.hiddenWord].text);
        } else {
          result = _idAnswer == question.focusSentence ||
              _wordAnswer == sentences.vn[question.hiddenWord].text ||
              _wordAnswer == sentences.en[question.hiddenWord].text ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).enText) == sentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).vnText) == sentence ||
              formatWord(_inputValue) ==
                  formatWord(Application.lessonInfo.findSentence(question.focusSentence).en[question.hiddenWord].text);
        }
      } else {
        if (_type == "VISentence") {
          result = _idAnswer == question.focusSentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).enText) == sentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).vnText) == sentence ||
              formatWord(_inputValue) == formatWord(Application.lessonInfo.findSentence(question.focusSentence).vnText);
        } else {
          result = _idAnswer == question.focusSentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).enText) == sentence ||
              formatWord(Application.lessonInfo.findSentence(question.focusSentence).vnText) == sentence ||
              formatWord(_inputValue) == formatWord(Application.lessonInfo.findSentence(question.focusSentence).enText);
        }
      }
    }
    reCheckQuestion(question, result ? 1 : 2,
        addFalseQuestionToList: addFalseQuestionToList, numberOfRecorderToText: numberOfRecorderToText);
    addElementForQuestionToSave(question, selectedStringSentence);
    increaseRightAnswer();
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
    if (!(changeQuestion && matchPairType.contains(question.questionType) && question.type == "word") ||
        isRecorderToText()) {
      if (_focusWordIndex < Application.lessonInfo.lesson.questions.length - 1) {
        _focusWordIndex++;
        answerForMatchPairType = <AnswerForMatchPairType>[];
      } else if (_focusWordIndex == Application.lessonInfo.lesson.questions.length - 1) {
        setOnSubmitted(true);
        finishLesson();
        Get.off(FinishLessonScreen(
          focusWordIndex: focusWordIndex,
          results: results,
          timeEnd: timeEnd,
          timeStart: timeStart,
          correctAnswer: rightAnswer,
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
    var selectedStringSentence = Provider.of<SortWordsModel>(context).wordSelectedString;
    var words = question.words;
    var sentences = question.sentences;
    var pickAll;
    if (words != null) {
      pickAll = Provider.of<MatchPairModel>(context).idAnswerList.length >= words.length && words.isNotEmpty;
    } else {
      pickAll = Provider.of<MatchPairModel>(context).idAnswerList.length >= sentences.length && sentences.isNotEmpty;
    }
    if (question.type == "word") {
      if (question.words != null && question.words.isNotEmpty) {
        pick = _idAnswer != null || _inputValue.isNotEmpty || pickAll && !isRecorderToText();
      } else {
        pick = _idAnswer != null || _inputValue.isNotEmpty && !isRecorderToText();
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
    return word.replaceAll(RegExp(r"\s+"), "").replaceAll(RegExp(r'[^\w\s]+'), "").toLowerCase();
  }

  void addElementForQuestionToSave(Questions currentQuestion, List<String> selectedStringSentence) {
    String type = currentQuestion.type;
    int questionType = currentQuestion.questionType;
    if (type == 'word') {
      if (questionType == 1 ||
          questionType == 2 ||
          questionType == 3 ||
          questionType == 4 ||
          questionType == 6 ||
          questionType == 13) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _idAnswer);
        results.add(r);
      } else if (questionType == 7 || questionType == 14 || questionType == 8 || questionType == 11) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _inputValue);
        results.add(r);
      } else if (questionType == 9) {
        ResultHasListAnswer r = ResultHasListAnswer(sId: currentQuestion.sId, answers: answerForMatchPairType);
        results.add(r);
      } else if (questionType == 12) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      }
    } else {
      if (questionType == 1 || questionType == 2 || questionType == 12 || questionType == 17) {
        ResultHasListAnswer r = ResultHasListAnswer(sId: currentQuestion.sId, answers: selectedStringSentence);
        results.add(r);
      } else if (questionType == 7 || questionType == 15 || questionType == 14 || questionType == 18) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _wordAnswer);
        results.add(r);
      } else if (questionType == 10) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _idAnswer);
        results.add(r);
      } else if (questionType == 4) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      } else if (questionType == 16) {
        ResultHasPrimitiveVariableAnswer r =
            ResultHasPrimitiveVariableAnswer(sId: currentQuestion.sId, answer: _hasCheckedAnswer == 1 ? 1 : 0);
        results.add(r);
      }
    }
  }

  String handleAnswerWhenWrong() {
    if ((Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord != null &&
            Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord.isNotEmpty) ||
        (Application.lessonInfo.lesson.questions[_focusWordIndex].focusSentence != null &&
            Application.lessonInfo.lesson.questions[_focusWordIndex].focusSentence.isNotEmpty)) {
      return _type == "ENWord"
          ? Application.lessonInfo.findWord(Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord).content
          : _type == "VIWord" || _type == "imageWord"
              ? Application.lessonInfo
                  .findWord(Application.lessonInfo.lesson.questions[_focusWordIndex].focusWord)
                  .meaning
              : _type == "VISentence"
                  ? Application.lessonInfo
                      .findSentence(Application.lessonInfo.lesson.questions[_focusWordIndex].focusSentence)
                      .vnText
                  : Application.lessonInfo
                      .findSentence(Application.lessonInfo.lesson.questions[_focusWordIndex].focusSentence)
                      .enText;
    } else {
      return "";
    }
  }
}
