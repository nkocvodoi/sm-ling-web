import 'package:SMLingg/config/config_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<TimeOfDay> customTimePicker(BuildContext context) {
  DateTime _time = DateTime.now();
  return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
      builder: (context, _) => AlertDialog(
        title: Text("SELECT TIME"),
        content: IntrinsicHeight(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 25,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (dateTime) => _time = dateTime,
                ),
              ),
            ],
          ),
        ),
      )).then((value) => TimeOfDay.fromDateTime(_time));
}