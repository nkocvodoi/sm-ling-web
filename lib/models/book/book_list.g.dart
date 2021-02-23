// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookList _$BookListFromJson(Map<String, dynamic> json) {
  return BookList(
    books: (json['books'] as List)?.map((e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$BookListToJson(BookList instance) => <String, dynamic>{
      'books': instance.books,
    };

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book(
    id: json['_id'] as String,
    name: json['name'] as String,
    grade: json['grade'] as int,
    cover: json['cover'] as String,
    description: json['description'] as String,
    totalWords: json['totalWords'] as int,
    totalUnits: json['totalUnits'] as int,
    totalLessons: json['totalLessons'] as int,
    doneLessons: json['doneLessons'] as int,
    totalQuestions: json['totalQuestions'] as int,
    doneQuestions: json['doneQuestions'] as int,
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'grade': instance.grade,
      'cover': instance.cover,
      'description': instance.description,
      'totalWords': instance.totalWords,
      'totalUnits': instance.totalUnits,
      'totalLessons': instance.totalLessons,
      'doneLessons': instance.doneLessons,
      'totalQuestions': instance.totalQuestions,
      'doneQuestions': instance.doneQuestions,
    };
