import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';

class Command extends StatelessWidget {
  final String command;

  const Command({Key key, @required this.command}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: AlignmentDirectional(-1.0, 1.0),
      margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2, bottom: SizeConfig.safeBlockVertical * 2),
      child: Text(command,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TextSize.fontSize18,
              fontFamily: TextSize.fontFamily,
              color: Color(0xff43669F))),
    );
  }
}
