import 'package:SMLingg/app/components/custom_button.component.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Achievement extends StatefulWidget {
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Thành tích của tôi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Center(
            child: CustomButton(
              shadowHeight: SizeConfig.blockSizeVertical * 8,
              shadowWidth: SizeConfig.blockSizeHorizontal * 67,
              radius: 30,
              deactivate: true,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/nameRank.png',
                    width: SizeConfig.blockSizeHorizontal * 68,
                    height: SizeConfig.blockSizeVertical * 20,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      bottom: SizeConfig.blockSizeVertical * 2.5,
                      child: Text(
                        Application.user.displayName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeConfig.blockSizeVertical * 3),
                      ))
                ],
              ),
              height: SizeConfig.blockSizeVertical * 15,
              width: SizeConfig.blockSizeHorizontal * 70,
              shadowColor: Color(0xFFF2A216),
              backgroundColor: Colors.transparent,
              onPressed: () => {},
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 10,
          ),
          CustomButton(
            shadowHeight: SizeConfig.blockSizeVertical * 8,
            shadowWidth: SizeConfig.blockSizeHorizontal * 67,
            radius: 35,
            deactivate: true,
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: FittedBox(
                    child: Text(
                      'Điểm số',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  Application.user.score.toString(),
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                )
              ],
            ),
            height: SizeConfig.blockSizeVertical * 9,
            width: SizeConfig.blockSizeHorizontal * 67,
            shadowColor: Color(0xFFF2A216),
            backgroundColor: Colors.white,
            borderColor: Colors.orange,
            onPressed: () => {},
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          CustomButton(
            shadowHeight: SizeConfig.blockSizeVertical * 8,
            shadowWidth: SizeConfig.blockSizeHorizontal * 67,
            radius: 35,
            deactivate: true,
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 18,
                  child: FittedBox(
                    child: Text(
                      'Cấp độ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  Application.user.level.toString(),
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                )
              ],
            ),
            height: SizeConfig.blockSizeVertical * 9,
            width: SizeConfig.blockSizeHorizontal * 67,
            shadowColor: Color(0xFFF2A216),
            backgroundColor: Colors.white,
            borderColor: Colors.orange,
            onPressed: () => {},
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          CustomButton(
            shadowHeight: SizeConfig.blockSizeVertical * 8,
            shadowWidth: SizeConfig.blockSizeHorizontal * 67,
            radius: 35,
            deactivate: true,
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 55,
                  child: FittedBox(
                    child: Text(
                      'Số ngày học tập liên tiếp',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  Application.user.score.toString(),
                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 3, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                )
              ],
            ),
            height: SizeConfig.blockSizeVertical * 9,
            width: SizeConfig.blockSizeHorizontal * 67,
            shadowColor: Color(0xFFF2A216),
            backgroundColor: Colors.white,
            borderColor: Colors.orange,
            onPressed: () => {},
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
