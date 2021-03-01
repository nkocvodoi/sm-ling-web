import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/login/login.provider.dart';
import 'package:SMLingg/app/login/login.service.dart';
import 'package:SMLingg/app/setting/setting_provider.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/config/resouces.dart';
import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/models/user_profile/user.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:SMLingg/utils/api.dart';
import 'package:date_format/date_format.dart' hide Locale;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  double _height;
  double _width;
  String dateTime;
  String _setTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();
  String _hour, _minute, _time;
  List<FocusNode> listFocusNode = List.generate(SettingInfo.customTextField.length, (index) => FocusNode());

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour : $_minute';
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        Application.sharePreference.putString(
            "Time",
            formatDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, selectedTime.hour, selectedTime.minute),
                [hh, ':', nn, " ", am]).toString());
        print(Application.sharePreference.getString("Time"));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listFocusNode[0].addListener(_onFocusChange);
    listFocusNode[1].addListener(_onFocusChange);
    _timeController.text = formatDate(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _timeController.text = Application.sharePreference.getString("Time") ?? null;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.11),
        child: Container(
          color: AppColor.mainThemes,
          height: SizeConfig.screenHeight * 0.11,
          alignment: Alignment.center,
          child: SizedBox(width: SizeConfig.screenWidth,child: Row(
            children: [
              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_outlined, color: Color(0xFF8EA9D5)),
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
              Text(
                "Setting",
                style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 3, fontWeight: FontWeight.bold, color: Color(0xFF5877AA)),
              ),
            ],
          )),
        ),
      ),
      backgroundColor: AppColor.mainBackGround,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Colors.lightBlueAccent,
            child: Consumer<SettingStates>(
              builder: (_, settingStates, __) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.safeBlockHorizontal * 5,
                      horizontal: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(SettingInfo.customTextField.length, (index) => _customTextField(index)),
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Text("Overview",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical * 3,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Quicksand",
                                  color: Color(0xFF5877AA))),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 1),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F3FD),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Image.asset("assets/setting/earth.png"),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Text(
                                "Language",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFF5877AA)),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFADD6F3),
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                height: SizeConfig.screenHeight * 0.04,
                                width: SizeConfig.safeBlockHorizontal * 23,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: SizeConfig.screenHeight * 0.008,
                                        left: SizeConfig.safeBlockHorizontal * 3,
                                        child: Text("VN",
                                            style: TextStyle(
                                                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Quicksand",
                                                color: Color(0xFF71B0DE)))),
                                    Positioned(
                                        top: SizeConfig.screenHeight * 0.008,
                                        right: SizeConfig.safeBlockHorizontal * 3,
                                        child: Text("EN",
                                            style: TextStyle(
                                                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Quicksand",
                                                color: Color(0xFF71B0DE)))),
                                    AnimatedPositioned(
                                        left: settingStates.languageIndex == "vi_vn" ? 0 : SizeConfig.safeBlockHorizontal * 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // settingStates.setCurrentSegment();
                                            // Provider.of<ClassModel>(context, listen: false).setIndex(0);
                                            // (settingStates.languageIndex == 0)
                                            //     ? I18n.of(context).locale = await Locale("vi", "VN")
                                            //     : I18n.of(context).locale = await Locale('en', "US");
                                            // Application.sharePreference.putString('locale', I18n.localeStr);
                                            // Get.offAllNamed("/class");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius: BorderRadius.circular(180),
                                            ),
                                            height: SizeConfig.screenHeight * 0.04,
                                            width: SizeConfig.safeBlockHorizontal * 13,
                                            alignment: Alignment.center,
                                            child: Text(settingStates.languageIndex == "vi_vn" ? "VN" : "EN",
                                                style: TextStyle(
                                                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Quicksand",
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 400)),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F3FD),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Image.asset("assets/setting/bell.png"),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Text(
                                "Training reminder",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFF5877AA)),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                height: SizeConfig.screenHeight * 0.04,
                                width: SizeConfig.safeBlockHorizontal * 23,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        left: SizeConfig.blockSizeHorizontal * 8,
                                        top: SizeConfig.screenHeight * 0.006,
                                        child: Container(
                                          decoration: BoxDecoration(color: Color(0xFFADD6F3), borderRadius: BorderRadius.circular(180)),
                                          height: SizeConfig.screenHeight * 0.03,
                                          width: SizeConfig.safeBlockHorizontal * 23 / 2,
                                        )),
                                    AnimatedPositioned(
                                        left: settingStates.trainingIndicator
                                            ? SizeConfig.safeBlockHorizontal * 4
                                            : SizeConfig.safeBlockHorizontal * 12,
                                        child: GestureDetector(
                                          onTap: () async => settingStates.setTrainingIndicator(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 3),
                                                color: settingStates.trainingIndicator ? Color(0xFFADD6F3) : Color(0xFF4285F4),
                                                shape: BoxShape.circle),
                                            height: SizeConfig.screenHeight * 0.04,
                                            width: SizeConfig.safeBlockHorizontal * 13,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 400)),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F3FD),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                bottomRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Image.asset("assets/setting/clock.png"),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Text(
                                "Time reminder",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFF5877AA)),
                              ),
                              Expanded(child: SizedBox()),
                              GestureDetector(
                                onTap: () {
                                  _selectTime(context);
                                },
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Colors.transparent),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Quicksand",
                                        color: Color(0xFF5877AA)),
                                    textAlign: TextAlign.center,
                                    onSaved: (String val) {
                                      _setTime = val;
                                    },
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    controller: _timeController,
                                    decoration: InputDecoration(
                                        disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none), contentPadding: EdgeInsets.all(0)),
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        Container(
                          width: SizeConfig.screenWidth,
                          child: Text("Accessible ability",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical * 3,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Quicksand",
                                  color: Color(0xFF5877AA))),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 1),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F3FD),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Image.asset("assets/setting/speak.png"),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Text(
                                "Talk exercises",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFF5877AA)),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                height: SizeConfig.screenHeight * 0.04,
                                width: SizeConfig.safeBlockHorizontal * 23,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        left: SizeConfig.blockSizeHorizontal * 8,
                                        top: SizeConfig.screenHeight * 0.006,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFADD6F3),
                                            borderRadius: BorderRadius.circular(180),
                                          ),
                                          height: SizeConfig.screenHeight * 0.03,
                                          width: SizeConfig.safeBlockHorizontal * 23 / 2,
                                        )),
                                    AnimatedPositioned(
                                        left: settingStates.speakIndicator ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockHorizontal * 12,
                                        child: GestureDetector(
                                          onTap: () => settingStates.setSpeakIndicator(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 3),
                                                color: settingStates.speakIndicator ? Color(0xFFADD6F3) : Color(0xFF4285F4),
                                                shape: BoxShape.circle),
                                            height: SizeConfig.screenHeight * 0.04,
                                            width: SizeConfig.safeBlockHorizontal * 13,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 400)),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                            ],
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.08,
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F3FD),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                bottomRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Image.asset("assets/setting/hear.png"),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                              Text(
                                "Listening exercises",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFF5877AA)),
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                height: SizeConfig.screenHeight * 0.04,
                                width: SizeConfig.safeBlockHorizontal * 23,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        left: SizeConfig.blockSizeHorizontal * 8,
                                        top: SizeConfig.screenHeight * 0.006,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFADD6F3),
                                            borderRadius: BorderRadius.circular(180),
                                          ),
                                          height: SizeConfig.screenHeight * 0.03,
                                          width: SizeConfig.safeBlockHorizontal * 23 / 2,
                                        )),
                                    AnimatedPositioned(
                                        left: settingStates.hearIndicator ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockHorizontal * 12,
                                        child: GestureDetector(
                                          onTap: () => settingStates.setHearIndicator(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white, width: 3),
                                                color: settingStates.hearIndicator ? Color(0xFFADD6F3) : Color(0xFF4285F4),
                                                shape: BoxShape.circle),
                                            height: SizeConfig.screenHeight * 0.04,
                                            width: SizeConfig.safeBlockHorizontal * 13,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 400)),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5F3FD),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                  topRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                                Image.asset("assets/setting/star.png"),
                                SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Quicksand",
                                      color: Color(0xFF5877AA)),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5F3FD),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                                  bottomRight: Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                                Image.asset("assets/setting/help.png"),
                                SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                                Text(
                                  "Helping",
                                  style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Quicksand",
                                      color: Color(0xFF5877AA)),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 3),
                        GestureDetector(
                          onTap: () => _showAlert(context),
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight * 0.08,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF2485F4),
                              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.safeBlockHorizontal * 3.5)),
                            ),
                            child: Text("Logout",
                                style: TextStyle(
                                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Quicksand",
                                    color: Color(0xFFFFFFFF))),
                          ),
                        ),
                        SizedBox(height: SizeConfig.safeBlockVertical * 2),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Widget _customTextField(int index) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Container(
            width: SizeConfig.screenWidth,
            child: Text(SettingInfo.customTextField[index].title,
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockVertical * 3, fontWeight: FontWeight.w700, fontFamily: "Quicksand", color: Color(0xFF5877AA))),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Center(
            child: Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: Color(0xFFE5F3FD),
                borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3.5),
              ),
              child: TextFormField(
                initialValue: SettingInfo.customTextField[index].display,
                textAlign: TextAlign.left,
                focusNode: listFocusNode[index],
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockVertical * 2.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Quicksand",
                    color: (listFocusNode[index].hasFocus) ? Color(0xFF4285F4) : Color(0xFF5877AA)),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(SizeConfig.safeBlockHorizontal * 3.5),
                    borderSide: BorderSide(color: Color(0xFF4285F4), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          message: Text(
            "Are you sure to logout of this account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                "Logout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              isDestructiveAction: true,
              onPressed: () {
                Provider.of<ClassModel>(context, listen: false).setIndex(0);
                Application.sharePreference.clear();
                signOutGoogle();
                logout();
                Provider.of<UnitModel>(context, listen: false).clearSave();
                Provider.of<LoginModel>(context, listen: false).logInAbsorb(false);
                Application.api = API();
                Application.user = User();
                Application.bookList = BookList();
                Application.unitList = UnitList();
                Application.lessonInfo = LessonInfo();
                Get.offAllNamed("/login");
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/login', (route) => false);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
