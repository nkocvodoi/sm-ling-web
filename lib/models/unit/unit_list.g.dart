// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitList _$UnitListFromJson(Map<String, dynamic> json) {
  return UnitList(
    bookId: json['bookId'] as String,
    totalUnits: json['totalUnits'] as int,
    units: (json['units'] as List)?.map((e) => e == null ? null : Unit.fromJson(e as Map<String, dynamic>))?.toList(),
    level: json['level'] as int,
    score: json['score'] as int,
    doneQuestions: json['doneQuestions'] as int,
    totalQuestions: json['totalQuestions'] as int,
  );
}

Map<String, dynamic> _$UnitListToJson(UnitList instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'totalUnits': instance.totalUnits,
      'units': instance.units,
      "level": instance.level,
      "score": instance.score,
      "doneQuestions": instance.doneQuestions,
      "totalQuestions": instance.totalQuestions,
    };

Unit _$UnitFromJson(Map<String, dynamic> json) {
  return Unit(
      sId: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      totalLevels: json['totalLevels'] as int,
      totalLessonsOfLevel: json['totalLessonsOfLevel'] as int,
      userLevel: json['userLevel'] as int,
      userLesson: json['userLesson'] as int,
      grammar: json['grammar'] as String,
      tips: json['tips'] as String,
      totalLessons: json['totalLessons'] as int,
      doneLessons: json['doneLessons'] as int);
}

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'description': instance.description,
      'totalLevels': instance.totalLevels,
      'totalLessonsOfLevel': instance.totalLessonsOfLevel,
      'userLevel': instance.userLevel,
      'userLesson': instance.userLesson,
      'grammar': instance.grammar,
      'tips': instance.tips,
      'totalLessons': instance.totalLessons,
      'doneLesson': instance.doneLessons
    };
