import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/material.dart';

void createDialogShowMessageAndAction(
    {context,
    double top,
    String title,
    String message,
    String titleLeftButton,
    String titleRightButton,
    void Function() leftAction,
    void Function() rightAction}) {
  showDialog(
      context: context,
      builder: (_) =>  Dialog(
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.buttonText),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      (message != null) ? message : "",
                      style: TextStyle(color: AppColor.buttonText, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          leftAction();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            titleLeftButton,
                            style: TextStyle(fontSize: 20, color: AppColor.buttonText, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          rightAction();
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            titleRightButton,
                            style: TextStyle(fontSize: 20, color: AppColor.buttonText, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal)
                    ],
                  ),
                ],
              ),
            ),
          )));
}
