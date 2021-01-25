import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordInQuestion extends StatefulWidget {
  final String text;

  const WordInQuestion({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WordInQuestionState();
  }
}

class _WordInQuestionState extends State<WordInQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: GestureDetector(
        key: widget.key,
        child: Text(widget.text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff43669F),
              decoration: TextDecoration.underline,
            )),
      ),
    );
  }
}
