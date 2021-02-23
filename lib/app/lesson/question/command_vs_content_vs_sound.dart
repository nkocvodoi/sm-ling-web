import 'package:SMLingg/app/components/sound_button.component.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class CommandVsContentVsSound extends StatelessWidget {
  final String command;
  final String content;
  final String soundUrl;
  final String type;
  final bool blank;
  final List<TextSpan> sentences = [];

  // ignore: always_put_required_named_parameters_first
  CommandVsContentVsSound({Key key, @required this.command, @required this.soundUrl, @required this.content, this.blank, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<LessonModel>(
        builder: (_, lessonModel, __) => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: Text(
                    command,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F)),
                  ),
                ),
                type == "word"
                    ? Container(
                        width: SizeConfig.safeBlockHorizontal * 90,
                        margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                                child: Container(
                                    alignment: Alignment.center,
                                    height: SizeConfig.safeBlockHorizontal * 15,
                                    padding: EdgeInsets.fromLTRB(SizeConfig.safeBlockHorizontal * 12, 10, SizeConfig.safeBlockHorizontal * 10, 10),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                          style:
                                              TextStyle(fontWeight: FontWeight.w700, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily),
                                          children: [
                                            ...List.generate(
                                                content.split(" ").length,
                                                (index) => TextSpan(
                                                    text: "${content.split(" ")[index]} ",
                                                    style: TextStyle(
                                                        color: lessonModel.inputValue.isNotEmpty
                                                            ? (content.contains(lessonModel.inputValue.split(" ")[index]))
                                                                ? AppColor.correctButtonBackground
                                                                : AppColor.wrongButtonBackground
                                                            : Color(0xff43669F))))
                                          ]),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                                        color: Color(0xffBEF7FF))),
                                left: SizeConfig.blockSizeHorizontal * 10),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: SoundButton(
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  height: SizeConfig.safeBlockHorizontal * 15,
                                  soundUrl: soundUrl,
                                ),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(180), color: Color(0xffBEF7FF)))
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
//                height: SizeConfig.safeBlockVertical * 18,
                        width: SizeConfig.screenWidth * 0.95,
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
                              padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                              width: SizeConfig.screenWidth * 0.95 - SizeConfig.blockSizeHorizontal * 15 - 60,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily),
                                    children: (blank == true)
                                        ? [TextSpan(text: content, style: TextStyle(color: Color(0xff43669F)))]
                                        : List.generate(
                                            content.split(" ").length,
                                            (index) => TextSpan(
                                                text: "${content.split(" ")[index]} ",
                                                style: TextStyle(
                                                    color: lessonModel.inputValue.isNotEmpty
                                                        ? (content.contains(lessonModel.inputValue))
                                                            ? AppColor.correctButtonBackground
                                                            : AppColor.wrongButtonBackground
                                                        : Color(0xff43669F))))),
                              ),
                            )
                          ],
                        ),
                      )
              ],
            ));
  }
}
