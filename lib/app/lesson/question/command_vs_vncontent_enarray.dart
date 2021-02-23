import 'dart:async';

import 'package:SMLingg/app/components/show_tool_tip.component.dart';
////                decoration: TextDecoration.underline,
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandVsVnContentVsEnArray extends StatefulWidget {
  final String command;
  final String vnContent;
  final List<TranslateWord> enArray;
  final bool isHiddenWord;
  final int hiddenWord;

  CommandVsVnContentVsEnArray({
    @required this.command,
    @required this.vnContent,
    @required this.enArray,
    Key key,
    this.isHiddenWord,
    this.hiddenWord,
  }) : super(key: key);

  @override
  _CommandVsVnContentVsEnArrayState createState() => _CommandVsVnContentVsEnArrayState();
}

class _CommandVsVnContentVsEnArrayState extends State<CommandVsVnContentVsEnArray> {
  List<String> translateWord = [];
  List<String> content = [];
  List<TextSpan> sentences = [];
  StreamController emit;
  ShowMoreModel aPopup;

  void initContent() {
    content = widget.vnContent.split(' ');
    print(content);
  }

  String createHiddenWord(int hiddenIndex) {
    String text = widget.enArray[hiddenIndex].text;
    String under = "";
    for (int j = 0; j < text.length; j++) {
      under = (j < text.length - 1) ? '${under}_ ' : '${under}_';
    }
    return under;
  }

  String findWordInLib(String wordID) {
    Words w = LessonInfo().findWord2("");
    return w != null ? w.meaning : "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    var listKeys = List.generate(widget.enArray.length, (index) => GlobalKey());
//    initSentence(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
          alignment: AlignmentDirectional(-1.0, 1.0),
          child: Text(
            widget.command,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F)),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 29, right: 29, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xffBEF7FF),
              borderRadius: BorderRadius.all(Radius.circular(37)),
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: SizeConfig.screenWidth - 40,
                    child: Text(
                      widget.vnContent,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: TextSize.fontSize18,
                        fontFamily: TextSize.fontFamily,
                        color: Color(0xff43669F),
                      ),
                    )),
                Container(
                  width: SizeConfig.screenWidth - 40,
                  child: widget.hiddenWord == -1
                      ? Container()
                      : Wrap(
                          spacing: SizeConfig.safeBlockHorizontal * 2,
                          runSpacing: SizeConfig.safeBlockHorizontal * 2,
                          alignment: WrapAlignment.start,
                          children: [
                            ...List.generate(
                                widget.enArray.length,
                                (index) => (index == widget.hiddenWord && widget.isHiddenWord)
                                    ? Container(
                                        child: Text(createHiddenWord(index),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: TextSize.fontFamily,
                                              color: Color(0xff43669F),
                                            )),
                                      )
                                    : Container(
                                        child: findWordInLib(widget.enArray[index].wordId).length > 0
                                            ? GestureDetector(
                                                key: listKeys[index],
                                                child: Text(widget.enArray[index].text,
                                                    style: TextStyle(
                                                      fontSize: TextSize.fontSize18,
                                                      fontFamily: TextSize.fontFamily,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xff43669F),
                                                      decoration: TextDecoration.underline,
                                                    )),
                                                onTap: () {
                                                  emit = StreamController();
                                                  String vn = findWordInLib(widget.enArray[index].wordId);
                                                  aPopup = ShowMoreExplainItem().createToolTipForText(vn, context);
                                                  emit.stream.listen((a) => {
                                                        aPopup.dismiss(),
                                                        emit.close(),
                                                      });
                                                  ShowMoreExplainItem().showToolTips(aPopup, listKeys[index]);
                                                },
                                              )
                                            : Text(widget.enArray[index].text,
                                                style: TextStyle(
                                                  fontSize: TextSize.fontSize18,
                                                  fontFamily: TextSize.fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff43669F),
                                                ))))
                          ],
                        ),
                )
              ],
            ))
      ],
    );
  }
}
