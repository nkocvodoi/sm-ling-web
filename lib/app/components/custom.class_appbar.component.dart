import 'dart:async';

import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/components/show_tool_tip.component.dart';
import 'package:SMLingg/app/lesson/lesson.provider.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyCustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final bool showAvatar;
  final String title;
  final bool unitScreen;
  final bool saveLesson;
  final bool chooseBook;
  final int classIndex;

  const MyCustomAppbar(
      {Key key,
      this.height,
      this.width,
      this.showAvatar,
      this.title,
      this.unitScreen = false,
      this.saveLesson,
      this.chooseBook,
      this.classIndex})
      : super(key: key);

  @override
  _MyCustomAppbarState createState() => _MyCustomAppbarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _MyCustomAppbarState extends State<MyCustomAppbar> {
  StreamController emit;
  ShowMoreModel aPopup;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if ((widget.showAvatar && Application.sharePreference.getInt("count") == 1)) {
    //   Future.delayed(Duration(milliseconds: 100), () {
    //     Application.sharePreference.remove("count");
    //     createDialogShowMessageAndAction(
    //         context: context,
    //         top: SizeConfig.blockSizeVertical * 50,
    //         title: "Do you want to continue the last lesson?",
    //         titleLeftButton: "No",
    //         titleRightButton: "Yes",
    //         leftAction: () {
    //           Provider.of<UnitModel>(context, listen: false).clearSave();
    //           Navigator.pop(context);
    //         },
    //         rightAction: () {
    //           Navigator.pop(context);
    //           Get.to(LoadingScreen(continuePlay: true));
    //         });
    //   });
    // }
  }

  var listKeys = List.generate(2, (index) => GlobalKey());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (aPopup != null) aPopup.dismiss();
    if (emit != null) emit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassModel>(builder: (context, icon, child) {
      return Container(
          height: widget.height,
          width: double.infinity,
          color: AppColor.mainThemes,
          alignment: Alignment.center,
          child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Row(children: [
                SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                (widget.showAvatar)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(180),
                        child: 
                        // Application.user.avatar != null ? Image.network(Application.user.avatar,
                        //         height: widget.height / 3 * 2, fit: BoxFit.fill) : 
                            Image.asset('assets/class/picture.png', color: Colors.transparent,
                                height: widget.height / 3 * 2))
                    : IconButton(
                        onPressed: () {
                          Get.back();
                          if (widget.unitScreen) {
                            Provider.of<LessonModel>(context, listen: false).setOffset(0);
                            Application.currentUnit = Unit();
                            Application.unitList = UnitList();
                            Application.currentBook = Book();
                            //   // print("widget.classIndex: ${widget.classIndex}");
                            //   // Provider.of<BookModel>(context, listen: false).setGrade(widget.classIndex - 1);
                            //   // Get.off(ChooseBook(), transition: Transition.rightToLeftWithFade, preventDuplicates: true);
                          }
                          if (widget.chooseBook) {
                            //   // Get.off(ClassScreen(), transition: Transition.rightToLeftWithFade, preventDuplicates: true);
                            Application.bookList = BookList();
                          }
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: AppColor.backButton,
                      ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                (widget.showAvatar)
                    ? Container(width: SizeConfig.blockSizeHorizontal * 8)
                    : Container(
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 3,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5877AA))),
                      ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 33),
                Stack(
                  children: [
                    Row(children: [
                      SizedBox(width: SizeConfig.blockSizeVertical * 2),
                      Container(
                        height: SizeConfig.blockSizeVertical * 4,
                        width: SizeConfig.blockSizeVertical * 7,
                        decoration: BoxDecoration(
                            color: Color(0xFFC9E5F8),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      )
                    ]),
                    Row(children: [
                      GestureDetector(
                        key: listKeys[0],
                        child: InkWell(
                          onTap: () {
                            icon.setShowValue();
                            emit = StreamController();
                            aPopup = ShowMoreExplainItem().createToolTips(
                                'assets/class/bee.png',
                                "Level",
                                "Số level bạn đã hoàn thành là ${(!widget.unitScreen) ? "${Provider.of<ClassModel>(context, listen: false).diamond}" : Application.unitList.level.toString()}.",
                                context);
                            emit.stream.listen((a) => {
                                  aPopup.dismiss(),
                                  emit.close(),
                                });
                            ShowMoreExplainItem()
                                .showToolTips(aPopup, listKeys[0]);
                          },
                          child: Image.asset(
                            'assets/class/bee.png',
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                      Container(
                          child: Text(
                              (!widget.unitScreen)
                                  ? "${Provider.of<ClassModel>(context, listen: false).hive}"
                                  : Application.unitList.level.toString(),
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical * 3,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5877AA)))),
                    ])
                  ],
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                Stack(children: [
                  Row(children: [
                    SizedBox(width: SizeConfig.blockSizeVertical * 2),
                    Container(
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeVertical * 7,
                      decoration: BoxDecoration(
                          color: Color(0xFFC9E5F8),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    )
                  ]),
                  Row(children: [
                    GestureDetector(
                      key: listKeys[1],
                      child: InkWell(
                        onTap: () {
                          icon.setShowValue();
                          emit = StreamController();
                          aPopup = ShowMoreExplainItem().createToolTips(
                              'assets/class/droplets.png',
                              "Số điểm",
                              "Số điểm bạn đã đạt được là ${(!widget.unitScreen) ? "${icon.diamond}" : Application.unitList.score.toString()}.",
                              context);
                          emit.stream.listen((a) => {
                                aPopup.dismiss(),
                                emit.close(),
                              });
                          ShowMoreExplainItem()
                              .showToolTips(aPopup, listKeys[1]);
                        },
                        child: Image.asset(
                          'assets/class/droplets.png',
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                    Container(
                        child: Text(
                            (!widget.unitScreen)
                                ? "${icon.diamond}"
                                : Application.unitList.score.toString(),
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockVertical * 3,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5877AA))))
                  ])
                ]),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 5)
              ])));
    });
  }
}
