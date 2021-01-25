import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../lesson.provider.dart';

class FillTextField extends StatefulWidget {
  final String type, hintText;

  FillTextField({this.type, this.hintText});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FillTextFieldState();
  }
}

class _FillTextFieldState extends State<FillTextField> {
  TextEditingController _controller = TextEditingController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print(Provider.of<LessonModel>(context, listen: false).focusWordIndex);
    if (Provider.of<LessonModel>(context, listen: false).focusWordIndex != currentIndex) {
      _controller.clear();
      currentIndex = Provider.of<LessonModel>(context, listen: false).focusWordIndex;
    }
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.mainThemesFocus,
      ),
      width: SizeConfig.safeBlockHorizontal * 90,
      height: SizeConfig.blockSizeVertical * 35,
      child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 5),
          child: TextFormField(
              enabled: Provider.of<LessonModel>(context, listen: false).hasCheckedAnswer == 0,
              textAlign: TextAlign.start,
              onChanged: (value) {
                Provider.of<LessonModel>(context, listen: false).setInputValue(value);
              },
              // ignore: deprecated_member_use
              inputFormatters: [BlacklistingTextInputFormatter(RegExp(r"^\s+"))],
              controller: _controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 11,
              style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.buttonText, fontSize: TextSize.fontSize18),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  hintText: widget.hintText ?? "Điền từ ${widget.type == "vi" ? "Tiếng Việt" : "Tiếng Anh"} tương ứng",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColor.mainThemesFocus,
                      fontSize: SizeConfig.safeBlockVertical * 2.3),
                  border: InputBorder.none))),
    );
  }
}
