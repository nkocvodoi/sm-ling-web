// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonInfo _$LessonInfoFromJson(Map<String, dynamic> json) {
  return LessonInfo(
    lesson: json['lesson'] == null ? null : Lesson.fromJson(json['lesson'] as Map<String, dynamic>),
    words: (json['words'] as List)?.map((e) => e == null ? null : Words.fromJson(e as Map<String, dynamic>))?.toList(),
    sentences: (json['sentences'] as List)?.map((e) => e == null ? null : Sentences.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$LessonInfoToJson(LessonInfo instance) => <String, dynamic>{
      'lesson': instance.lesson,
      'words': instance.words,
      'sentences': instance.sentences,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
    questionIds: (json['questionIds'] as List)?.map((e) => e as String)?.toList(),
    questions: (json['questions'] as List)?.map((e) => e == null ? null : Questions.fromJson(e as Map<String, dynamic>))?.toList(),
    sId: json['_id'] as String,
    lessonIndex: json['lessonIndex'] as int,
    totalQuestions: json['totalQuestions'] as int,
  );
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'questionIds': instance.questionIds,
      'questions': instance.questions,
      '_id': instance.sId,
      'lessonIndex': instance.lessonIndex,
      'totalQuestions': instance.totalQuestions,
    };

Questions _$QuestionsFromJson(Map<String, dynamic> json) {
  return Questions(
    sId: json['_id'] as String,
    type: json['type'] as String,
    interaction: json['interaction'] as String,
    point: json['point'] as dynamic,
    content: json['content'] as String,
    questionType: json['questionType'] as int,
    focusSentence: json['focusSentence'] as String,
    checkSentence: json['checkSentence'] as String,
    wrongWords: (json['wrongWords'] as List)?.map((e) => e as String)?.toList(),
    hiddenWord: json['hiddenWord'] as int,
    sentences: (json['sentences'] as List)?.map((e) => e as String)?.toList(),
    focusWord: json['focusWord'] as String,
    words: (json['words'] as List)?.map((e) => e as String)?.toList(),
    bookId: json['bookId'] as String,
    unitId: json['unitId'] as String,
  );
}

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      '_id': instance.sId,
      'type': instance.type,
      'interaction': instance.interaction,
      'point': instance.point,
      'content': instance.content,
      'questionType': instance.questionType,
      'focusSentence': instance.focusSentence,
      'checkSentence': instance.checkSentence,
      'wrongWords': instance.wrongWords,
      'hiddenWord': instance.hiddenWord,
      'sentences': instance.sentences,
      'focusWord': instance.focusWord,
      'words': instance.words,
      'bookId': instance.bookId,
      'unitId': instance.unitId,
    };

Words _$WordsFromJson(Map<String, dynamic> json) {
  return Words(
    sId: json['_id'] as String,
    content: json['content'] as String,
    meaning: json['meaning'] as String,
    types: (json['types'] as List)?.map((e) => e as String)?.toList(),
    pronunciations: (json['pronunciations'] as List)?.map((e) => e as String)?.toList(),
    imageRoot: json['imageRoot'] as String,
  );
}

Map<String, dynamic> _$WordsToJson(Words instance) => <String, dynamic>{
      '_id': instance.sId,
      'content': instance.content,
      'meaning': instance.meaning,
      'types': instance.types,
      'pronunciations': instance.pronunciations,
      'imageRoot': instance.imageRoot,
    };

Sentences _$SentencesFromJson(Map<String, dynamic> json) {
  return Sentences(
    sId: json['_id'] as String,
    audio: json['audio'] as String,
    enText: json['enText'] as String,
    vnText: json['vnText'] as String,
    vn: (json['vn'] as List)?.map((e) => e == null ? null : TranslateWord.fromJson(e as Map<String, dynamic>))?.toList(),
    en: (json['en'] as List)?.map((e) => e == null ? null : TranslateWord.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$SentencesToJson(Sentences instance) => <String, dynamic>{
      '_id': instance.sId,
      'audio': instance.audio,
      'enText': instance.enText,
      'vnText': instance.vnText,
      'vn': instance.vn,
      'en': instance.en,
    };

TranslateWord _$TranslateWordFromJson(Map<String, dynamic> json) {
  return TranslateWord(
    sId: json['_id'] as String,
    wordId: json['wordId'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$TranslateWordToJson(TranslateWord instance) => <String, dynamic>{
      '_id': instance.sId,
      'wordId': instance.wordId,
      'text': instance.text,
    };
