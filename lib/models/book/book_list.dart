import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_list.g.dart';

@JsonSerializable(nullable: true)
class BookList {
  List<Book> books;

  BookList({this.books});

  factory BookList.fromJson(Map<String, dynamic> json) => _$BookListFromJson(json);

  Map<String, dynamic> toJson() => _$BookListToJson(this);
}

@JsonSerializable(nullable: true)
class Book {
  String id;
  String name;
  int grade;
  String cover;
  String description;
  int totalWords;
  int totalUnits;
  int totalLessons;
  int doneLessons;
  int totalQuestions;
  int doneQuestions;

  Book({this.id, this.name, this.grade, this.cover,this.description, this.totalWords, this.totalUnits, this.totalLessons, this.doneLessons,this.totalQuestions,this.doneQuestions});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
