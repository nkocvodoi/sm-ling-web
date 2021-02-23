import 'package:json_annotation/json_annotation.dart';

part 'lesson_info.g.dart';

@JsonSerializable(nullable: true)
class LessonInfo {
  Lesson lesson;
  List<Words> words;
  List<Sentences> sentences;

  LessonInfo({this.lesson, this.words, this.sentences});

  factory LessonInfo.fromJson(Map<String, dynamic> json) => _$LessonInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LessonInfoToJson(this);

  Words findWord(String idAnswer) {
//    print(words);
//    print(idAnswer);
//    print(words.indexWhere((element) => element.sId == idAnswer));
//    return words[words.indexWhere((element) => element.sId == idAnswer)];
    if (words != null) {
      int index = words.indexWhere((element) => element.sId == idAnswer);
      return index != -1 ? words[index] : null;
    } else {
      return null;
    }
  }

  Words findWord2(String wordID) {
    if (words != null) {
      int index = words.indexWhere((element) => element.sId == wordID);
      return index != -1 ? words[index] : null;
    } else {
      return null;
    }
  }

  Sentences findSentence(String idAnswer) {
    if (idAnswer != null) {
      return sentences[sentences.indexWhere((element) => element.sId == idAnswer)];
    }
  }

  String createContentHasHiddenWord(List<TranslateWord> words, int hiddenWord) {
    String content = "";
    for (var i = 0; i < words.length; i++) {
      String space = i < words.length - 1 ? " " : "";
      if (i != hiddenWord) {
        content = content + words[i].text + space;
      } else {
        String hidden = "";
        for (int j = 0; j < words[i].text.length; j++) {
          hidden = "${hidden}_";
        }
        hidden = hidden + space;
        content = content + hidden;
      }
    }
    return content;
  }
}

@JsonSerializable(nullable: true)
class Lesson {
  List<String> questionIds;
  List<Questions> questions;
  String sId;
  int lessonIndex;
  int totalQuestions;

  Lesson({this.questionIds, this.questions, this.sId, this.lessonIndex, this.totalQuestions});

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable(nullable: true)
class Questions {
  String sId;
  String type;
  String interaction;
  dynamic point;
  String content;
  int questionType;
  String focusSentence;
  String checkSentence;
  List<String> wrongWords;
  int hiddenWord;
  List<String> sentences;
  String focusWord;
  List<String> words;
  String bookId;
  String unitId;

  Questions(
      {this.sId,
      this.type,
      this.interaction,
      this.point,
      this.questionType,
      this.focusSentence,
      this.checkSentence,
      this.content,
      this.wrongWords,
      this.hiddenWord,
      this.sentences,
      this.focusWord,
      this.words,
      this.bookId,
      this.unitId});

  factory Questions.fromJson(Map<String, dynamic> json) => _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}

@JsonSerializable(nullable: true)
class Words {
  String sId;
  String content;
  String meaning;
  List<String> types;
  List<String> pronunciations;
  String imageRoot;

  Words({this.sId, this.content, this.meaning, this.types, this.pronunciations, this.imageRoot});

  factory Words.fromJson(Map<String, dynamic> json) => _$WordsFromJson(json);

  Map<String, dynamic> toJson() => _$WordsToJson(this);
}

@JsonSerializable(nullable: true)
class Sentences {
  String sId;
  String audio;
  String enText;
  String vnText;
  List<TranslateWord> vn;
  List<TranslateWord> en;

  Sentences({this.sId, this.audio, this.enText, this.vnText, this.vn, this.en});

  factory Sentences.fromJson(Map<String, dynamic> json) => _$SentencesFromJson(json);

  Map<String, dynamic> toJson() => _$SentencesToJson(this);
}

@JsonSerializable(nullable: true)
class TranslateWord {
  String sId;
  String wordId;
  String text;

  TranslateWord({this.sId, this.wordId, this.text});

  factory TranslateWord.fromJson(Map<String, dynamic> json) => _$TranslateWordFromJson(json);

  Map<String, dynamic> toJson() => _$TranslateWordToJson(this);
}
