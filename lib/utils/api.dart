import 'dart:async';
import 'dart:io';

import 'package:SMLingg/app/loading_screen/loading.view.dart';
import 'package:SMLingg/app/login/login.service.dart';
import 'package:SMLingg/config/application.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioResponse;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class API {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 30000,
      sendTimeout: 60000,
      receiveTimeout: 30000,
      contentType: 'application/json; charset=utf-8',
      baseUrl: "https://quizbot-api.sachmem.vn",
    ),
  );

  API() {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
//    dio.interceptors
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      Application.sharePreference.hasKey("token")
          ? options.headers["Authorization"] = "Bearer ${Application.sharePreference.getString("token")}"
          // ignore: unnecessary_statements
          : {};
      print(options.uri);
      print("options.headers[Authorization]: ${options.headers["Authorization"]}");
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (dioResponse.Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      handleTimeOutException(e.type);
      // Refresh Token
      if (e.response?.statusCode == 401) {
        print("ERROR: 401");
        Map<String, dynamic> data = <String, dynamic>{
          "refreshToken": Application.sharePreference.getString("refreshToken"),
        };
        var response = await dio.post("/api/login/TokenAuth/RefreshToken", data: data);
        if (response.statusCode == 200) {
          Application.sharePreference.putString("token", response.data["data"]["token"] as String);
          Application.sharePreference.putString("refreshToken", response.data["data"]["refreshToken"] as String);
          // return dio.request(e.request.baseUrl + e.request.path, options: e.request);
          Get.offAll(LoadingScreen(fetchData: true));
        }
      }
      return e.response; //continue
    }));
  }

  void signOut() {
    Application.sharePreference.clear();
    signOutGoogle();
    // logout();
  }

  void handleTimeOutException(DioErrorType type) {
    switch (type) {
      case DioErrorType.DEFAULT:
        print("DEFAULT");
        Fluttertoast.showToast(
          msg: "Failed connect to server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        print("CONNECT_TIMEOUT");
        // signOut(); // sm ling
        // Get.toNamed("/login");
        Fluttertoast.showToast(
          msg: "Failed connect to server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case DioErrorType.SEND_TIMEOUT:
        print("SEND_TIMEOUT");
        signOut(); // sm ling
        Get.toNamed("/login");
        Fluttertoast.showToast(
          msg: "Failed sending data to server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        print("RECEIVE_TIMEOUT");
        signOut(); // sm ling
        Get.toNamed("/login");
        Fluttertoast.showToast(
          msg: "Failed receiving data from server",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        break;
      default:
        break;
    }
  }

  Future get(String url, [Map<String, dynamic> params]) async {
    print("params: $params");
    return dio.get(url, queryParameters: params);
  }

  Future post(String url, [Map<String, dynamic> params]) async {
    return dio.post(url, data: params);
  }

  Future put(String url, [Map<String, dynamic> params]) async {
    return dio.put(url, data: params);
  }

  Future delete(String url, [Map<String, dynamic> params]) async {
    return dio.delete(url, queryParameters: params);
  }

  Future patch(String url, [Map<String, dynamic> params]) async {
    return dio.patch(url, data: params);
  }
}
