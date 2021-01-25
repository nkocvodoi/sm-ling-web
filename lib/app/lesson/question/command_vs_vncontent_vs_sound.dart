import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommandVsVnContentVsSound extends StatefulWidget {
  final String command, soundUrl;
  final List<TranslateWord> enArray;
  final bool isHiddenWord;
  final int hiddenWord;

  CommandVsVnContentVsSound(
      {@required this.command, @required this.enArray, Key key, this.isHiddenWord, this.hiddenWord, this.soundUrl})
      : super(key: key);

  @override
  _CommandVsVnContentVsSoundState createState() => _CommandVsVnContentVsSoundState();
}

class _CommandVsVnContentVsSoundState extends State<CommandVsVnContentVsSound> {
  List<String> translateWord = [];
  List<String> content = [];
  List<TextSpan> sentences = [];

  void initSentence(BuildContext context) {
    if (widget.isHiddenWord) {
      for (var i = 0; i < widget.enArray.length; i++) {
        String text = widget.enArray[i].text;
        String space = i != widget.enArray.length - 1 ? " " : "";
        if (i == widget.hiddenWord) {
          String under = "";
          for (int j = 0; j < text.length; j++) {
            under = (j < text.length - 1) ? '${under}_ ' : '${under}_';
          }
          sentences.add(TextSpan(
              text: under,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff43669F),
              )));
        } else {
          sentences.add(
            TextSpan(
              text: text,
              style: TextStyle(
                fontSize: TextSize.fontSize18,
                fontWeight: FontWeight.bold,
                color: Color(0xff43669F),
//                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
          );
        }
        sentences.add(TextSpan(text: space));
      }
    } else {
      for (var i = 0; i < widget.enArray.length; i++) {
        String text = widget.enArray[i].text;
        String space = i != widget.enArray.length - 1 ? " " : "";
        sentences.add(
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: TextSize.fontFamily,
              color: Color(0xff43669F),
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        );
        sentences.add(TextSpan(text: space));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    initSentence(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
          alignment: AlignmentDirectional(-1.0, 1.0),
          child: Text(
            widget.command,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TextSize.fontSize18,
                fontFamily: TextSize.fontFamily,
                color: Color(0xff43669F)),
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
            alignment: Alignment.center,
            width: SizeConfig.screenWidth - 40,
            decoration: BoxDecoration(
              color: Color(0xffBEF7FF),
              borderRadius: BorderRadius.all(Radius.circular(58)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: SoundButton(
                    width: SizeConfig.blockSizeHorizontal * 15,
                    height: SizeConfig.safeBlockHorizontal * 15,
                    soundUrl: widget.soundUrl,
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth - 40 - SizeConfig.blockSizeHorizontal * 15 - 50,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: RichText(
                    overflow: TextOverflow.clip,
                    maxLines: 5,
                    softWrap: true,
                    text: TextSpan(
                      children: sentences,
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
