import 'package:SMLingg/app/class_screen/class.view.dart';
import 'package:SMLingg/app/components/waittingdots_component.dart';
import 'package:SMLingg/app/login/login.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  final bool fetchData;

  LoadingScreen({this.fetchData});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
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
        Future.delayed(Duration(milliseconds: 2500), () => Get.offAll(LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
        body: Column( children: [
          Expanded(child: SizedBox(),flex: 2),
      Center(
        child: Container(
          child: Lottie.asset('assets/lottie/bee.json',
              height: SizeConfig.screenHeight * 0.3),
        ),
      ),
      Container(
        child: LoadingDots(numberDots: 5),),
        //  Lottie.asset('assets/lottie/loading.json', width: SizeConfig.safeBlockHorizontal * 50),
          Expanded(child: SizedBox(),flex: 3),
    ]));
  }
}