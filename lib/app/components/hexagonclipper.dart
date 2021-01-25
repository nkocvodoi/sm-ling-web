import 'dart:ui';

import 'package:flutter/cupertino.dart';

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.3, size.height * 0.2);
    path.lineTo(size.width * 0.7, size.height * 0.2);
    path.lineTo(size.width * 0.9, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.1, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
