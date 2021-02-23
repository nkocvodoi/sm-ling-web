import 'package:SMLingg/app/report/report.provider.dart';
import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/services/report.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

void reportDialog(context, TextEditingController errorController, String bookID, String unitID, int level, int lesson, Questions question,
    String questionContent, String questionDescription, String userAnswer, String date) {
  Provider.of<ReportModel>(context as BuildContext, listen: false).initError();
  showDialog(
      context: context as BuildContext,
      builder: (_) => Consumer<ReportModel>(
          builder: (_, model, __) => Center(
                child: Container(
                    width: SizeConfig.blockSizeHorizontal * 90,
                    child: Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Báo lỗi',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColor.buttonText),
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                ...List.generate(
                                  model.errorText.length,
                                  (index) => CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    value: model.isChecked[index],
                                    checkColor: AppColor.tickCheckBox,
                                    activeColor: AppColor.checkBoxColor,
                                    onChanged: (value) {
                                      model.setChecked(index);
                                    },
                                    title: Text(
                                      model.errorText[index],
                                      style: TextStyle(fontWeight: FontWeight.w500, color: AppColor.buttonText, fontSize: 18),
                                    ),
                                  ),
                                )
                              ]),
                              TextFormField(
                                controller: errorController,
                                onChanged: (value) {
                                  model.saveComment(value);
                                },
                                style: TextStyle(color: AppColor.buttonText, fontWeight: FontWeight.w400, fontSize: 18),
                                decoration: InputDecoration(
                                    hintText: 'Lỗi khác',
                                    hintStyle: TextStyle(color: AppColor.mainThemesFocus, fontSize: 18, fontWeight: FontWeight.w400)),
                              ),
                              Row(
                                children: [
                                  Expanded(child: SizedBox()),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context as BuildContext);
                                      errorController.clear();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Hủy',
                                        style: TextStyle(fontSize: 20, color: AppColor.buttonText, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      for (int i = 0; i < model.errorText.length - 1; i++) {
                                        if (model.isChecked[i]) {
                                          model.addError(model.errorText[i]);
                                        }
                                      }
                                      if (model.errors.length != 0 || model.comment != null) {
                                        Fluttertoast.showToast(
                                            msg: "Cảm ơn bạn đã đóng góp ý kiến",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: AppColor.mainThemesFocus,
                                            textColor: Colors.white,
                                            fontSize: 18);
                                        Report()
                                            .report(
                                                error: model.errors,
                                                comment: model.comment,
                                                unitID: unitID,
                                                level: level,
                                                lesson: lesson,
                                                bookID: bookID,
                                                questionContent: questionContent,
                                                questionId: question.sId,
                                                questionDescription: questionDescription,
                                                date: date,
                                                userAnswer: userAnswer)
                                            .then((value) {
                                          Navigator.pop(context as BuildContext);
                                          errorController.clear();
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'Gửi',
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
                      ),
                    )),
              )));
}
