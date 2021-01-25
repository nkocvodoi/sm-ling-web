import 'dart:async';

import 'package:SMLingg/app/loading_screen/loading.view.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(milliseconds: 2500),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoadingScreen(fetchData: true))));
  }

  void showError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xFF4285F4),
        body: SafeArea(
            child: SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Column(children: [
                  Expanded(child: SizedBox()),
                  Container(
                          child: Image.asset('assets/lingo.png',
                              fit: BoxFit.fitHeight),
                          width: SizeConfig.screenWidth * 0.3),
                  Expanded(child: SizedBox()),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockSizeVertical * 15,
                    child: Image.asset("assets/splash/logo.png",
                        height: SizeConfig.blockSizeVertical * 15)
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 10),
                ]))));
  }
}
