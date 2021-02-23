import 'dart:ui';

import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommandVsContent extends StatelessWidget {
  final String command;
  final String content;

  const CommandVsContent({Key key, @required this.command, @required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: AlignmentDirectional(-1.0, 1.0),
          margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
          child: Text(command,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F))),
        ),
        Container(
            width: SizeConfig.screenWidth,
            child: Row(children: [
              Expanded(child: SizedBox()),
              content.length < 20
                  ? Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 10, 10, SizeConfig.safeBlockHorizontal * 10, 10),
                      decoration: BoxDecoration(
                        color: Color(0xffBEF7FF),
                        borderRadius: BorderRadius.all(Radius.circular(37)),
                      ),
                      child: Text(content,
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: TextSize.fontFamily,
                            fontSize: TextSize.fontSize18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff43669F),
                          )))
                  : Container(
                      margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                      alignment: Alignment.center,
                      width: SizeConfig.safeBlockHorizontal * 90,
                      padding: EdgeInsets.fromLTRB(27, 10, 27, 10),
                      decoration: BoxDecoration(
                        color: Color(0xffBEF7FF),
                        borderRadius: BorderRadius.all(Radius.circular(27)),
                      ),
                      child: Text(content,
                          overflow: TextOverflow.clip,
                          maxLines: 5,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: TextSize.fontFamily,
                            fontSize: TextSize.fontSize18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff43669F),
                          ))),
              Expanded(child: SizedBox()),
            ]))
      ],
    );
  }
}
