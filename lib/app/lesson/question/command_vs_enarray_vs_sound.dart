import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CommandVsEnArrayVsSound extends StatefulWidget {
  final String command;
  final String soundUrl;
  final List<String> enArray;

  CommandVsEnArrayVsSound({Key key, @required this.command, @required this.soundUrl, @required this.enArray}) : super(key: key);

  @override
  _CommandVsEnArrayVsSoundState createState() => _CommandVsEnArrayVsSoundState();
}

class _CommandVsEnArrayVsSoundState extends State<CommandVsEnArrayVsSound> {
  List<TextSpan> sentences = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    for (var i = 0; i < widget.enArray.length; i++) {
      String text = widget.enArray[i];
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
        text: i != widget.enArray.length - 1 ? " " : "",
      ));
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          alignment: AlignmentDirectional(-1.0, 1.0),
          child: Text(
            widget.command,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F)),
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
                  soundUrl: widget.soundUrl,
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
