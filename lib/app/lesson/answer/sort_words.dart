import 'dart:io';

import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class SortWords extends StatefulWidget {
  final String type;

  SortWords({this.type});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SortWordsState();
  }
}

enum TtsState { playing, stopped }

class _SortWordsState extends State<SortWords> {
  var words = Application.lessonInfo.words;
  var sentences = Application.lessonInfo.sentences;
  int currentIndex = 0;
  FlutterTts flutterTts;
  String language = "en-US";
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.8;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  var _wordList = <Word>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    var sentence = Application.lessonInfo.findSentence(question.focusSentence);

    int i = 0;
    for (var element in question.wrongWords) {
      var x = Word(text: element, index: i);
      _wordList.add(Word(text: element, index: i));
      i++;
    }
    if (widget.type == "en") {
      sentence.en.forEach((element) {
        _wordList.add(Word(text: element.text, index: i));
        i++;
      });
      language = "en-US";
    } else if (widget.type == "vi") {
      sentence.vn.forEach((element) {
        _wordList.add(Word(text: element.text, index: i));
        i++;
      });
      language = "vi-VN";
    }
    _wordList.shuffle();
    initTts();
  }

  // ignore: avoid_void_async
  void initTts() async {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    var question = Application.lessonInfo.lesson.questions[Provider.of<LessonModel>(context, listen: false).focusWordIndex];
    if (currentIndex != Provider.of<LessonModel>(context, listen: false).focusWordIndex) {
      var sentence = Application.lessonInfo.findSentence(question.focusSentence);
      _wordList = <Word>[];
      int i = 0;
      for (var element in question.wrongWords) {
        var x = Word(text: element, index: i);
        _wordList.add(Word(text: element, index: i));
        i++;
      }
      if (widget.type == "en") {
        language = "en-US";
        sentence.en.forEach((element) {
          _wordList.add(Word(text: element.text, index: i));
          i++;
        });
      } else if (widget.type == "vi") {
        language = "vi-VN";
        sentence.vn.forEach((element) {
          _wordList.add(Word(text: element.text, index: i));
          i++;
        });
      }
      _wordList.shuffle();
      initTts();
      currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    }
    return Consumer<SortWordsModel>(builder: (_, sortWordsModel, __) {
      return Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
            width: SizeConfig.safeBlockHorizontal * 96,
            alignment: Alignment.center,
            child: Wrap(
                spacing: SizeConfig.safeBlockHorizontal * 1,
                runSpacing: SizeConfig.safeBlockHorizontal * 2,
                alignment: WrapAlignment.start,
                children: [
                  ...List.generate(
                      sortWordsModel.wordSelected.length,
                      (index) =>
                          _wordButton(text: sortWordsModel.wordSelected[index].text, type: "answer", index: sortWordsModel.wordSelected[index].index))
                ])),
        Image.asset('assets/divider.jpg', width: SizeConfig.safeBlockHorizontal * 90),
        SizedBox(height: SizeConfig.safeBlockVertical * 3),
        Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            alignment: Alignment.center,
            child: Wrap(
                spacing: SizeConfig.safeBlockHorizontal * 3,
                runSpacing: SizeConfig.safeBlockHorizontal * 5,
                alignment: WrapAlignment.center,
                children: [
                  ...List.generate(
                      _wordList.length, (index) => _wordButton(text: _wordList[index].text, type: "option", index: _wordList[index].index))
                ])),
      ]));
    });
  }

  Widget _wordButton({String text, String type, int index}) {
    return Consumer<SortWordsModel>(builder: (_, sortWordsModel, __) {
      return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: (sortWordsModel.wordSelected.indexWhere((it) => it.index == index) != -1 && type == "option") ? 0 : 1,
          child: CustomButton(
              elevation: 4,
              deactivate: (sortWordsModel.wordSelected.indexWhere((it) => it.index == index) != -1 && type == "option") ||
                  Provider.of<LessonModel>(context, listen: false).hasCheckedAnswer != 0,
              radius: 90,
              onPressed: () {
                if (widget.type == "en" && !(sortWordsModel.wordSelected.indexWhere((it) => it.index == index) != -1)) {
                  _speak(text);
                }
                Provider.of<SortWordsModel>(context, listen: false).selectWord(text: text, index: index);
              },
              padding: EdgeInsets.only(left: 2, right: 2),
              child: FittedBox(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: TextSize.fontSize16, color: AppColor.buttonText),
                  ),
                  fit: BoxFit.fill),
              width: (text.length < 6) ? SizeConfig.blockSizeVertical * 10 : (SizeConfig.blockSizeVertical * 1.75 * text.length).toDouble(),
              height: SizeConfig.blockSizeVertical * 6,
              shadowColor: AppColor.mainThemesFocus));
    });
  }

  Future _speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.setLanguage(language);

    if (text != null) {
      if (text.isNotEmpty) {
        var result = await flutterTts.speak(text);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }
}

class SortWordsModel extends ChangeNotifier {
  List<Word> _wordSelected = <Word>[];

  List<Word> get wordSelected => _wordSelected;

  List<String> _wordSelectedString = <String>[];

  List<String> get wordSelectedString => _wordSelectedString;

  void selectWord({String text, int index}) {
    var x = Word(text: text, index: index);
    if (_wordSelected.indexWhere((it) => it.index == index) != -1) {
      _wordSelectedString.removeAt(_wordSelected.indexWhere((it) => it.index == index));
      _wordSelected.removeAt(_wordSelected.indexWhere((it) => it.index == index));
    } else {
      _wordSelected.add(x);
      _wordSelectedString.add(text);
    }
    notifyListeners();
  }

  void resetWordList() {
    _wordSelected.clear();
    _wordSelectedString.clear();
    notifyListeners();
  }

  void clearAll() {
    _wordSelected = <Word>[];
    _wordSelectedString = <String>[];
    notifyListeners();
  }
}

class Word {
  int index;
  String text;

  Word({this.text, this.index});
}
