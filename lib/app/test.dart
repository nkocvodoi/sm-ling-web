import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onLongPress: () => print("tapped"),
      onLongPressStart: (LongPressStartDetails details) => _onTapDown(details),
      onLongPressEnd: (LongPressEndDetails details) => _onTapUp(details),
    );
  }

  // ignore: always_declare_return_types
  _onTapDown(LongPressStartDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    print("tap down $x, $y");
  }

  // ignore: always_declare_return_types
  _onTapUp(LongPressEndDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    print("tap up $x, $y");
  }
}