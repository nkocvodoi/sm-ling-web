import 'dart:developer';

import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/user_profile/user.dart';
import 'package:SMLingg/utils/network_exception.dart';

class UserServiceGoogle {
  Future<void> loadUserProfile(String accessToken) async {
    Map<String, dynamic> paramsUser = {"access_token": accessToken};
    print("11111");
    var response = await Application.api.post("/api/login/google", paramsUser);
    print("22222");
    try {
      if (response.statusCode == 200) {
        Application.user = User.fromJson(
            response.data["data"]["user"] as Map<String, dynamic>);
        Application.sharePreference
            .putString("token", response.data["data"]["token"] as String);
        Application.sharePreference.putString(
            "refreshToken", response.data["data"]["refreshToken"] as String);
      } else {
        print('Fetch User Google Login Error!');
      }
    } on NetworkException {
      print('Network Error!');
    }
  }
}

class UserServiceFacebook {
  Future<bool> loadUserProfile(String accessToken) async {
    Map<String, dynamic> paramsUser = {
      "access_token": accessToken,
      "app_id": 851737475629924
    };
    var response =
        await Application.api.post("/api/login/facebook", paramsUser);
    try {
      if (response.statusCode == 200) {
        Application.user = User.fromJson(
            response.data["data"]["user"] as Map<String, dynamic>);
        Application.sharePreference
            .putString("token", response.data["data"]["token"] as String);
        Application.sharePreference.putString(
            "refreshToken", response.data["data"]["refreshToken"] as String);
        return true;
      } else {
        print('Fetch User Facebook Login Error!');
        return false;
      }
    } on NetworkException {
      print('Network Error!');
      return false;
    }
  }
}

class UserProfile {
  Future<void> loadUserProfile() async {
    var response = await Application.api.get("/api/user/profile");
    try {
      if (response.statusCode == 200) {
        Application.user =
            User.fromJson(response.data["data"] as Map<String, dynamic>);
        log("Application.user: ${Application.user.toJson().toString()}");
      }
    } on NetworkException {
      print('Network Error!');
    }
  }
}
