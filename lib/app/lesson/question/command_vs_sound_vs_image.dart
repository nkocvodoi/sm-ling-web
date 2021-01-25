import 'dart:ui';

import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandVsSoundVsImage extends StatelessWidget {
  final String command;
  final String soundUrl;
  final String imageUrl;

  const CommandVsSoundVsImage({Key key, this.command, this.soundUrl, this.imageUrl}) : super(key: key);

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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: TextSize.fontSize18,
                fontFamily: TextSize.fontFamily,
                color: Color(0xff43669F)),
          ),
        ),
        Container(
          height: SizeConfig.safeBlockVertical * 18,
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
          decoration: BoxDecoration(
            color: Color(0xffBEF7FF),
            borderRadius: BorderRadius.all(Radius.circular(43)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: SoundButton(
                  width: SizeConfig.safeBlockHorizontal * 15,
                  height: SizeConfig.safeBlockHorizontal * 15,
                  soundUrl: soundUrl,
                ),
              ),
              Positioned(
                  top: 10,
                  bottom: 10,
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 18,
                    width: SizeConfig.screenWidth - 40,
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 30,
                          height: SizeConfig.safeBlockVertical * 18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          child: imageUrl != null ? Image.network(
                            imageUrl,
                            width: SizeConfig.safeBlockHorizontal * 30,
                            height: SizeConfig.safeBlockVertical * 18,
                          ) : Image.asset("assets/error_image.png"),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
