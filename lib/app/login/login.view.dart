import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/app/login/login.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/resources/i18n.dart';
import 'package:SMLingg/services/user.service.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'login.service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColor.mainBackGround,
      body: Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 20),
          Image.asset(
            "assets/login/Lingo.png",
            width: SizeConfig.safeBlockHorizontal * 60,
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2.5),
          Text(
            "Learning English Textbook better\nEnglish 1 - 12".i18n,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: SizeConfig.safeBlockVertical * 2.5, color: Color(0xFF8EA9D5)),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 15),
          Text(
            "LOGIN".i18n,
            style: TextStyle(
                fontFamily: "Quicksand", fontWeight: FontWeight.w500, fontSize: SizeConfig.safeBlockVertical * 2.5, color: Color(0xFF8EA9D5)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
              _signInButton(title: "Facebook", method: 2),
              _signInButton(title: " Google ", method: 1),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
            ],
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _signInButton({String title, String iconImage, int method}) {
    return Consumer<LoginModel>(
        builder: (_, loginModel, __) => CustomButton(
            deactivate: loginModel.logInButtonAbsorb as bool,
            backgroundColor: Color(0xFFE5F3FD),
            onPressed: () {
              Application.sharePreference.putInt("login_platform", method);
              loginModel.logInAbsorb(true);
              (method == 1)
                  ? signInWithGoogle(context).then((result) {
                      if (result != null) {
                        if (Application.sharePreference.getString("access_token") == null) {
                          loginModel.logInAbsorb(false);
                        }
                        Navigator.of(context).pushNamed('/loading');
                        UserServiceGoogle().loadUserProfile(Application.sharePreference.getString("access_token")).then((value) {
                          if (Application.user.avatar != null) {
                            Get.offAllNamed("/class");
                            loginModel.logInAbsorb(false);
                          } else {
                            Navigator.pop(context);
                            loginModel.logInAbsorb(false);
                            showError("Failed Connect To Server !");
                          }
                        });
                      }
                    })
                  : loginWithFacebook(context).then((result) {
                      if (Application.sharePreference.getString("access_token") == null) {
                        loginModel.logInAbsorb(false);
                      }
                      UserServiceFacebook().loadUserProfile(Application.sharePreference.getString("access_token")).then((value) {
                        Get.offAllNamed("/loading");
                        if (Application.user.avatar != null) {
                          Get.offAllNamed("/class");
                          loginModel.logInAbsorb(false);
                        } else {
                          Navigator.pop(context);
                          loginModel.logInAbsorb(false);
                          showError("Failed Connect To Server !");
                        }
                      });
                    });
            },
            elevation: 5,
            radius: 30,
            width: SizeConfig.screenWidth * 0.37,
            height: SizeConfig.screenHeight * 0.07,
            shadowColor: Color(0xFFADD6F3),
            child: Row(children: [
              Expanded(child: SizedBox()),
              (method == 1)
                  ? SvgPicture.asset("assets/login/Google.svg", height: SizeConfig.safeBlockHorizontal * 5)
                  : SvgPicture.asset("assets/login/facebook.svg", height: SizeConfig.safeBlockHorizontal * 5),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
              Text((method == 1) ? "Google" : "Facebook",
                  style: TextStyle(
                    color: Color(0xFF6CA9D3),
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                  )),
              Expanded(child: SizedBox()),
            ])));
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
}
