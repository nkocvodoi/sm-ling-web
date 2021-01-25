import 'package:json_annotation/json_annotation.dart';

part 'unit_list.g.dart';

@JsonSerializable(nullable: true)
class UnitList {
  String bookId;
  int totalUnits;
  List<Unit> units;
  int level;
  int score;
  int doneQuestions;
  int totalQuestions;

  UnitList({this.bookId, this.totalUnits, this.units, this.level, this.score, this.doneQuestions, this.totalQuestions});

  factory UnitList.fromJson(Map<String, dynamic> json) => _$UnitListFromJson(json);

  Map<String, dynamic> toJson() => _$UnitListToJson(this);
}

@JsonSerializable(nullable: true)
class Unit {
  String sId;
  String name;
  String description;
  int totalLevels;
  int totalLessonsOfLevel;
  int userLevel;
  int userLesson;
  String grammar;
  String tips;
  int doneLessons;
  int totalLessons;

  Unit(
      {this.sId,
      this.name,
      this.description,
      this.totalLevels,
      this.totalLessonsOfLevel,
      this.userLevel,
      this.userLesson,
      this.grammar,
      this.tips,
      this.doneLessons,
      this.totalLessons});

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}
