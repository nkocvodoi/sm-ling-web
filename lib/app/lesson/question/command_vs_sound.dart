import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandVsSound extends StatelessWidget {
  final String command;
  final String soundUrl;

  const CommandVsSound({@required this.command, @required this.soundUrl, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
          alignment: AlignmentDirectional(-1.0, 1.0),
          child: Text(
            command,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F)),
          ),
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(child: SizedBox()),
          Container(
              margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
              alignment: Alignment.center,
              width: SizeConfig.safeBlockHorizontal * 15 + 20,
              height: SizeConfig.safeBlockHorizontal * 15 + 20,
              decoration: BoxDecoration(
                color: Color(0xffBEF7FF),
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
//            child: SoundButton(),
              child: SoundButton(
                width: SizeConfig.safeBlockHorizontal * 15,
                height: SizeConfig.safeBlockHorizontal * 15,
                soundUrl: soundUrl,
                playBackRate: 1,
              )),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
          Container(
              margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
              alignment: Alignment.center,
              width: SizeConfig.safeBlockHorizontal * 15 + 20,
              height: SizeConfig.safeBlockHorizontal * 15 + 20,
              decoration: BoxDecoration(
                color: Color(0xffFFE6B6),
                borderRadius: BorderRadius.all(Radius.circular(90)),
              ),
              child: SoundButton(
                width: SizeConfig.safeBlockHorizontal * 15,
                height: SizeConfig.safeBlockHorizontal * 15,
                soundUrl: soundUrl,
                playBackRate: 0.6,
              )),
          Expanded(child: SizedBox())
        ]),
      ],
    );
  }
}
