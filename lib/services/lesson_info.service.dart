import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/utils/network_exception.dart';

class LessonInfoService {
  // ignore: missing_return
  List<Questions> _functionCreateTestForTypeQuestion({List<Questions> questions, String type, List<int> questionTypes}) {
    List<Questions> newList = [];
    for (int i = 0; i < questions.length; i++) {
      if (type == questions[i].type && !questionTypes.contains(questions[i].questionType)) {
        newList.add(questions[i]);
      }
    }
    return newList;
  }

  // trả về true nếu phát hiện lỗi
  bool _detectError(Questions currentQuestion) {
    String type = currentQuestion.type;
    int questionType = currentQuestion.questionType;
    if (type == "word") {
      switch (questionType) {
        case 2:
          return currentQuestion.focusWord.isEmpty;
        default:
          return false;
      }
    } else {
      switch (questionType) {
        default:
          return false;
      }
    }
  }

  List<Questions> _filterQuestions({List<Questions> questions}) {
    List<Questions> newList = [];
    for (int i = 0; i < questions.length; i++) {
      if (!_detectError(questions[i])) {
        newList.add(questions[i]);
      }
    }
    return newList;
  }

// ignore: missing_return
  Future<LessonInfo> loadLessonInfo({String bookID, String unitID, int level, int lesson}) async {
    var response = await Application.api.get("/api/book/$bookID/$unitID/get?level=$level&lesson=$lesson");
    try {
      if (response.statusCode == 200) {
        Application.currentUnit = Application.unitList.units
            .elementAt(Application.unitList.units.indexWhere((element) => element.sId == unitID));
        var wordsJson = response.data['data']['words'] as List;
        Application.lessonInfo.words = wordsJson.map((word) => Words.fromJson(word)).toList();
        var sentencesJson = response.data['data']['sentences'] as List;
        Application.lessonInfo.sentences = sentencesJson.map((sentence) => Sentences.fromJson(sentence)).toList();
        Application.lessonInfo.lesson = Lesson.fromJson(response.data['data']['lesson'] as Map<String, dynamic>);
        // Todo: Lọc danh sách câu hỏi server trả về
        List<Questions> newList = _filterQuestions(questions: Application.lessonInfo.lesson.questions);
        Application.lessonInfo.lesson.questions = newList;
        Application.lessonInfo.lesson.totalQuestions = newList.length;
        // Todo: Lọc danh sách câu hỏi server trả về
        // Todo: tạo dữ liệu lấy những dạng câu hỏi cần test ra test cho nhanh
        List<Questions> questions = Application.lessonInfo.lesson.questions;
        List<Questions> newList2 = [];
        List<Questions> newList3 = [];
        List<int> questionTypes = [];
        newList2 = _functionCreateTestForTypeQuestion(questions: questions, type: "word", questionTypes: questionTypes);
        newList3 = _functionCreateTestForTypeQuestion(questions: questions, type: "sentence", questionTypes: questionTypes);
        newList2.addAll(newList3);
        if (Application.sharePreference.hasKey("speakIndicator")) {
          if (Application.sharePreference.getBool("speakIndicator")) {
            questionTypes = [12];
            newList2 =
                _functionCreateTestForTypeQuestion(questions: questions, type: "word", questionTypes: questionTypes);
            questionTypes = [4];
            newList3 = _functionCreateTestForTypeQuestion(
                questions: questions, type: "sentence", questionTypes: questionTypes);
            newList2.addAll(newList3);
          }
        }
        if (Application.sharePreference.hasKey("hearIndicator")) {
          if (Application.sharePreference.getBool("hearIndicator")) {
            questionTypes = [2, 3, 6, 7, 11, 12];
            newList2 =
                _functionCreateTestForTypeQuestion(questions: questions, type: "word", questionTypes: questionTypes);
            questionTypes = [1, 4, 7, 15, 16];
            newList3 = _functionCreateTestForTypeQuestion(
                questions: questions, type: "sentence", questionTypes: questionTypes);
            newList2.addAll(newList3);
          }
        }
        Application.lessonInfo.lesson.questions = newList2;
        Application.lessonInfo.lesson.totalQuestions = newList2.length;
        // Todo: tạo dữ liệu lấy những dạng câu hỏi cần test ra test cho nhanh
        return Application.lessonInfo;
      } else {
        print("Fetch grade Error");
      }
    } on NetworkException {
      print("ERROR!");
    }
  }
}
