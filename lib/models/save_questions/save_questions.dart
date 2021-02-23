class SaveLessonParam {
  dynamic bookId;
  dynamic unitId;
  dynamic levelIndex;
  dynamic lessonIndex;
  List<dynamic> results;
  dynamic timeStart;
  dynamic timeEnd;
  dynamic doneQuestions;

  SaveLessonParam({this.bookId, this.unitId, this.levelIndex, this.lessonIndex, this.results, this.timeStart, this.timeEnd, this.doneQuestions});

  SaveLessonParam.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    unitId = json['unitId'];
    levelIndex = json['levelIndex'];
    lessonIndex = json['lessonIndex'];
    if (json['results'] != null) {
      results = <dynamic>[];
      json['results'].forEach((Map<String, dynamic> v) {
        results.add(ResultHasPrimitiveVariableAnswer.fromJson(v));
      });
    }
    timeStart = json['timeStart'];
    timeEnd = json['timeEnd'];
    doneQuestions = json['doneQuestions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookId'] = bookId;
    data['unitId'] = unitId;
    data['levelIndex'] = levelIndex;
    data['lessonIndex'] = lessonIndex;
    if (results != null) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    data['timeStart'] = timeStart;
    data['timeEnd'] = timeEnd;
    data['doneQuestions'] = doneQuestions;
    return data;
  }
}

class ResultHasPrimitiveVariableAnswer {
  dynamic sId;
  dynamic answer;

  ResultHasPrimitiveVariableAnswer({this.sId, this.answer});

  ResultHasPrimitiveVariableAnswer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['answer'] = answer;
    return data;
  }
}

class ResultHasListAnswer {
  String sId;
  List<dynamic> answers;

  ResultHasListAnswer({this.sId, this.answers});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['answers'] = answers;
    return data;
  }
}

class AnswerForMatchPairType {
  String first;
  String second;

  AnswerForMatchPairType({this.first, this.second});
}
