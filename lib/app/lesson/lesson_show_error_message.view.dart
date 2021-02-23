import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonShowLoadQuestionError extends StatefulWidget {
  final String message;

  const LessonShowLoadQuestionError({Key key, this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LessonShowLoadQuestionErrorState();
  }
}

class _LessonShowLoadQuestionErrorState extends State<LessonShowLoadQuestionError> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColor.mainBackGround,
        body: Stack(alignment: Alignment.center, children: [
          SizedBox(
              height: SizeConfig.screenHeight,
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.safeBlockVertical * 10,
                    width: SizeConfig.screenWidth,
                    color: AppColor.mainThemes,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            left: SizeConfig.safeBlockHorizontal * 0.5,
                            child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: AppColor.mainThemesFocus,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                        Positioned(
                            left: SizeConfig.safeBlockHorizontal * 12,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Container(
                                    height: SizeConfig.safeBlockHorizontal * 4.8,
                                    width: SizeConfig.safeBlockHorizontal * 80,
                                    child: Stack(alignment: Alignment.center, children: [
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal * 80,
                                        color: Colors.white,
                                      ),
                                      AnimatedPositioned(
                                        left: (-SizeConfig.blockSizeHorizontal * 80 + 0 * SizeConfig.blockSizeHorizontal * 80 / 100),
                                        duration: Duration(milliseconds: 500),
                                        child: Container(
                                          height: SizeConfig.safeBlockHorizontal * 6,
                                          width: SizeConfig.safeBlockHorizontal * 80,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFDDD45),
                                              border: Border.all(color: Colors.white),
                                              borderRadius: BorderRadius.circular(90)),
                                        ),
                                      ),
                                      Container(
                                        height: SizeConfig.safeBlockHorizontal * 4.8,
                                        width: SizeConfig.safeBlockHorizontal * 80,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(color: Colors.white, width: 2),
                                            borderRadius: BorderRadius.circular(90)),
                                      )
                                    ])))),
                        Positioned(
                          right: SizeConfig.safeBlockHorizontal * 4.5,
                          child: Image.asset(
                            "assets/class/droplets.png",
                            height: SizeConfig.safeBlockVertical * 4.3,
                          ),
                        )
                      ],
                    ),
                  ),
                  //Todo: Phân loại questionType
                  Expanded(
                    child: Center(
                      child: Text(widget.message,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: TextSize.fontSize18, fontFamily: TextSize.fontFamily, color: Color(0xff43669F))),
                    ),
                  )
                ],
              )),
        ]));
  }
}
