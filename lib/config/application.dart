// ignore: constant_identifier_names

import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/models/ranking/ranking.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/models/user_profile/user.dart';
import 'package:SMLingg/utils/api.dart';
import 'package:SMLingg/utils/shared_preferences.dart';

class Application {
  static SpUtil sharePreference;
  static API api;
  static User user;
  static BookList bookList;
  static UnitList unitList;
  static LessonInfo lessonInfo;
  static Ranking ranking;
  static Unit currentUnit;
  static Book currentBook;
}
