import 'package:SMLingg/app/lesson/sentences/question_type10_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type12_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type13_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type14_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type15_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type16_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type17_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type18_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type1_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type2_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type4_sent.dart';
import 'package:SMLingg/app/lesson/sentences/question_type7_sent.dart';
import 'package:SMLingg/app/lesson/words/question_type11_word.dart';
import 'package:SMLingg/app/lesson/words/question_type12_word.dart';
import 'package:SMLingg/app/lesson/words/question_type13_word.dart';
import 'package:SMLingg/app/lesson/words/question_type14_word.dart';
import 'package:SMLingg/app/lesson/words/question_type1_word.dart';
import 'package:SMLingg/app/lesson/words/question_type2_word.dart';
import 'package:SMLingg/app/lesson/words/question_type3_word.dart';
import 'package:SMLingg/app/lesson/words/question_type4_word.dart';
import 'package:SMLingg/app/lesson/words/question_type6_word.dart';
import 'package:SMLingg/app/lesson/words/question_type7_word.dart';
import 'package:SMLingg/app/lesson/words/question_type8_word.dart';
import 'package:SMLingg/app/lesson/words/question_type9_word.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:flutter/material.dart';

class QuestionCommon extends StatelessWidget {
  final Questions question;

  QuestionCommon({this.question});

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    print("${question.type}// ${question.questionType}");
    if (question.type == "word") {
      switch (question.questionType) {
        case 1:
          return QuestionType1Word(question);
        case 2:
          return QuestionType2Word(question);
        case 3:
          return QuestionType3Word(question);
        case 4:
          return QuestionType4Word(question);
        case 6:
          return QuestionType6Word();
        case 7:
          return QuestionType7Word();
        case 8:
          return QuestionType8Word();
        case 9:
          return QuestionType9Word();
        case 11:
          return QuestionType11Word();
        case 12:
          return QuestionType12Word();
        case 13:
          return QuestionType13Word(question);
        case 14:
          return QuestionType14Word();
        default:
          return Center(
            child: Text("Question Type: ${question.questionType}"),
          );
      }
    } else {
      switch (question.questionType) {
        case 1:
          return QuestionType1Sent();
        case 2:
          return QuestionType2Sent();
        case 4:
          return QuestionType4Sent();
        case 7:
          return QuestionType7Sent(question);
        case 10:
          return QuestionType10Sent(question);
        case 12:
          return QuestionType12Sent();
        case 13:
          return QuestionType13Sent();
        case 14:
          return QuestionType14Sent();
        case 15:
          return QuestionType15Sent();
        case 16:
          return QuestionType16Sent();
        case 17:
          return QuestionType17Sent();
        case 18:
          return QuestionType18Sent();
        default:
          return Center(
            child: Text("Question Type: ${question.questionType}"),
          );
      }
    }
  }
}
