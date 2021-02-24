import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/user_profile/user.view.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'class.dart';

class ClassScreen extends StatefulWidget {
  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SizeConfig().init(context);
    return Consumer<ClassModel>(
      builder: (context, icon, child) {
        return WillPopScope(
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Builder(builder: (BuildContext context) {
                _tabController = DefaultTabController.of(context);
                _tabController.addListener(() async {
                  icon.setIndex(_tabController.index);
                });
                return SafeArea(
                  child: Scaffold(
                    body: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TabBarView(
                            controller: _tabController,
                            physics: BouncingScrollPhysics(),
                            children: [
                              classScreen(context, icon),
                              userProfile(context, icon)
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.safeBlockVertical * 8,
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Color(0xFFFFFFF),
                            onTap: (index) => icon.setIndex(index),
                            labelColor: Colors.white,
                            indicatorWeight: 2,
                            indicatorColor: Color(0xFFADD6F3),
                            tabs: <Widget>[
                              Container(
                                margin: EdgeInsets.all(
                                    SizeConfig.safeBlockHorizontal * 3),
                                width: SizeConfig.safeBlockHorizontal * 50,
                                child: Image.asset(
                                    "assets/class/${icon.getDot()}.jpg"),
                              ),
                              Container(
                                margin: EdgeInsets.all(
                                    SizeConfig.safeBlockHorizontal * 3),
                                width: SizeConfig.safeBlockHorizontal * 50,
                                child: Image.asset(
                                  "assets/class/${icon.getFace()}.jpg",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            onWillPop: () async {
              return false;
            });
      },
    );
  }
}