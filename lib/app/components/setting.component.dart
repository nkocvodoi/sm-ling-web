import 'package:SMLingg/config/config_screen.dart';
import 'package:SMLingg/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:SMLingg/resources/i18n.dart';

class SettingButton extends StatefulWidget {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final String image;
  final String text;
  final int index;
  final Function onTap;

  const SettingButton({
    Key key,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    @required this.image,
    @required this.text,
    this.index,
    this.onTap,
  }) : super(key: key);

  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton> {
  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColor.mainThemes,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topLeft ?? 0),
            topRight: Radius.circular(widget.topRight ?? 0),
            bottomRight: Radius.circular(widget.bottomRight ?? 0),
            bottomLeft: Radius.circular(widget.bottomLeft ?? 0)),
      ),
      height: SizeConfig.safeBlockHorizontal * 15,
      width: SizeConfig.screenWidth * 0.75,
      child: (widget.index == 0)
          ? InkWell(
              // ignore: unnecessary_statements
              onTap: () => widget.onTap,
              child: Row(children: [
                SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                SvgPicture.asset(widget.image, height: SizeConfig.safeBlockVertical * 3),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 10),
                Text(widget.text.i18n,
                    style: TextStyle(
                      color: Color(0xFF5877AA),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Quicksand",
                      fontSize: SizeConfig.safeBlockVertical * 2.5,
                    )),
                Expanded(child: SizedBox()),
                Text("${myLocale.countryCode}", style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.5)),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 1),
                Icon(Icons.keyboard_arrow_right_outlined, size: SizeConfig.safeBlockVertical * 2.5),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 2)
              ]),
            )
          : InkWell(
              // ignore: unnecessary_statements
              onTap: () => widget.onTap(),
              child: Row(
                children: [
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                  SvgPicture.asset(widget.image, height: SizeConfig.safeBlockVertical * 3),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 10),
                  Text(widget.text.i18n,
                      style: TextStyle(
                        color: Color(0xFF5877AA),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Quicksand",
                        fontSize: SizeConfig.safeBlockVertical * 2.5,
                      )),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
    );
  }
}
