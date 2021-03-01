import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class CommandVsVnContentVsSound extends StatefulWidget {
  final String command, soundUrl;
  final List<TranslateWord> enArray;
  final bool isHiddenWord;
  final int hiddenWord;

  CommandVsVnContentVsSound({@required this.command, @required this.enArray, Key key, this.isHiddenWord, this.hiddenWord, this.soundUrl})
      : super(key: key);

  @override
  _CommandVsVnContentVsSoundState createState() => _CommandVsVnContentVsSoundState();
}

class _CommandVsVnContentVsSoundState extends State<CommandVsVnContentVsSound> {
  List<String> translateWord = [];
  List<TextSpan> sentences = [];
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    initSentence(context);
  }

  void initSentence(BuildContext context) {
    sentences = [];
//     if (widget.isHiddenWord) {
//       for (var i = 0; i < widget.enArray.length; i++) {
//         String text = widget.enArray[i].text;
//         String space = i != widget.enArray.length - 1 ? " " : "";
//         if (i == widget.hiddenWord) {
//           String under = "";
//           for (int j = 0; j < text.length; j++) {
//             under = (j < text.length - 1) ? '${under}_ ' : '${under}_';
//           }
//           sentences.add(TextSpan(
//               text: under,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff43669F),
//               )));
//         } else {
//           sentences.add(
//             TextSpan(
//               text: text,
//               style: TextStyle(
//                 fontSize: TextSize.fontSize18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff43669F),
// //                decoration: TextDecoration.underline,
//                 decorationStyle: TextDecorationStyle.dashed,
//               ),
//             ),
//           );
//         }
//         sentences.add(TextSpan(text: space));
//       }
//     } else {
//       for (var i = 0; i < widget.enArray.length; i++) {
//         String text = widget.enArray[i].text;
//         String space = i != widget.enArray.length - 1 ? " " : "";
//         sentences.add(
//           TextSpan(
//             text: text,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               fontFamily: TextSize.fontFamily,
//               color: Color(0xff43669F),
//               decoration: TextDecoration.underline,
//               decorationStyle: TextDecorationStyle.dashed,
//             ),
//             recognizer: TapGestureRecognizer()..onTap = () {},
//           ),
//         );
//         sentences.add(TextSpan(text: space));
//       }
//     }
    print("hiddenWord: ${widget.hiddenWord}");
    for (var m = 0; m < widget.enArray.length; m++) {
      print("widget.enArray.length: ${widget.enArray[m].text}");
      if (m == widget.hiddenWord) {
        for (var i = 0; i < widget.enArray[m].text.length; i++) {
          for(var m=0;m<2;m++){
            sentences.add(TextSpan(
              text: "_",
              style: TextStyle(
                fontSize:  m==1 ? SizeConfig.safeBlockHorizontal *4 : SizeConfig.safeBlockHorizontal *1.5,
                fontWeight: FontWeight.bold,
                fontFamily: TextSize.fontFamily,
                color: m==1 ?  Color(0xff43669F) :  Color(0xffBEF7FF),
                // decoration: TextDecoration.underline,
                // decorationStyle: TextDecorationStyle.dashed,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ));
          }
        }
      } else {
        sentences.add(TextSpan(
          text: widget.enArray[m].text,
          style: TextStyle(
            fontSize: TextSize.fontSize16,
            fontWeight: FontWeight.bold,
            fontFamily: TextSize.fontFamily,
            color: Color(0xff43669F),
            // decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ));
      }
      sentences.add(TextSpan(text: " "));
    }
    print(sentences);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (currentIndex < Provider.of<LessonModel>(context, listen: false).focusWordIndex) {
      initSentence(context);
      currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    }
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
                    playBackRate: 1,
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth - 40 - SizeConfig.blockSizeHorizontal * 15 - 55,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: RichText(
                    overflow: TextOverflow.clip,
                    maxLines: 5,
                    softWrap: true,
                    text: TextSpan(children: sentences, style: TextStyle(fontFamily: TextSize.fontFamily)),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
