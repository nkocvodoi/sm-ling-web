import 'package:SMLingg/app/class_screen/class.view.dart';
import 'package:SMLingg/app/components/waittingdots_component.dart';
import 'package:SMLingg/app/lesson/lesson.view.dart';
import 'package:SMLingg/app/login/login.view.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  final bool fetchData;
  final bool continuePlay;

  LoadingScreen({this.fetchData, this.continuePlay});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> fetchContinue() async {
    await Application.api
        .get(Application.sharePreference.getString("chooseBook"))
        .then((value) => Application.api
            .get(Application.sharePreference.getString("loadUnitList")));
    Get.off(LessonScreen(
        userLevel: Application.sharePreference.getInt("saveUserLevel"),
        userLesson: Application.sharePreference.getInt("saveUserLesson"),
        id: Application.sharePreference.getString("saveId")));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.fetchData == true) {
      if (Application.sharePreference.getString("token") != null) {
        UserProfile().loadUserProfile().then((value) => {
              if (Application.user.avatar != null)
                Get.offAll(ClassScreen())
              else
                {
                  Fluttertoast.showToast(
                    msg: 'Fail connect to server!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  ),
                  Get.offAll(LoginPage())
                }
            });
      } else {
        Future.delayed(
            Duration(milliseconds: 2500), () => Get.offAll(LoginPage()));
      }
    }
    if (widget.continuePlay == true) {
      fetchContinue();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    if (widget.continuePlay == true) {
      Provider.of<UnitModel>(context).setCheckContinue(true);
    }
    return Scaffold(
        body: Center(child:Container(
            alignment: Alignment.center,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Container(
                width: SizeConfig.screenHeight * 2 / 3,
                child: Column(children: [
                  Expanded(child: SizedBox(), flex: 2),
                  Center(
                    child: Container(
                      child: Lottie.asset('assets/lottie/bee.json',
                          width: SizeConfig.screenWidth * 0.45),
                    ),
                  ),
                  Container(
                    child: LoadingDots(numberDots: 5),
                  ),
                  //  Lottie.asset('assets/lottie/loading.json', width: SizeConfig.safeBlockHorizontal * 50),
                  Expanded(child: SizedBox(), flex: 3),
                ])))));
  }
}
