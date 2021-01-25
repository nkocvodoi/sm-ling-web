import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommandVsEnArrayVsSound extends StatelessWidget {
  final String command;
  final String soundUrl;
  final List<String> enArray;
  List<TextSpan> sentences = [];

  CommandVsEnArrayVsSound({Key key, @required this.command, @required this.soundUrl, @required this.enArray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    for (var i = 0; i < enArray.length; i++) {
      String text = enArray[i];
      sentences.add(TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.bold,
          color: Color(0xff43669F),
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.dashed,
        ),
        recognizer: TapGestureRecognizer()..onTap = () => print("OKOKO"),
      ));
      sentences.add(TextSpan(
        text: i != enArray.length - 1 ? " " : "",
      ));
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          alignment: AlignmentDirectional(-1.0, 1.0),
          child: Text(
            command,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TextSize.fontSize18,
                fontFamily: TextSize.fontFamily,
                color: Color(0xff43669F)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          alignment: AlignmentDirectional(-1.0, 1.0),
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
                  soundUrl: soundUrl,
                ),
              ),
              Container(
                height: SizeConfig.safeBlockHorizontal * 15,
                width: SizeConfig.blockSizeHorizontal * 60,
                child: RichText(
                  overflow: TextOverflow.clip,
                  maxLines: 5,
                  softWrap: true,
                  text: TextSpan(
                    style: TextStyle(fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily),
                    children: sentences,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
