import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/utils/network_exception.dart';

class BodyParams {
  List<String> answers;
  bool isTracking;
  String language;
  String option;
  String question;
  String scope;
  String userAnswer;

  BodyParams({this.answers, this.isTracking, this.language, this.option, this.question, this.scope, this.userAnswer});

  BodyParams.fromJson(Map<String, dynamic> json) {
    answers = json['answers'].cast<String>();
    isTracking = json['is_tracking'];
    language = json['language'];
    option = json['option'];
    question = json['question'];
    scope = json['scope'];
    userAnswer = json['user_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answers'] = this.answers;
    data['is_tracking'] = this.isTracking;
    data['language'] = this.language;
    data['option'] = this.option;
    data['question'] = this.question;
    data['scope'] = this.scope;
    data['user_answer'] = this.userAnswer;
    return data;
  }
}

class RecheckQuestionService {
  // ignore: missing_return

  Future<double> callApiCompareInputValueVsResultText({String inputValue, String text, String language}) async {
    if (language == "vi" || language == "en") {
      List<String> answers = [];
      answers.add(text);
      BodyParams params = BodyParams(
          answers: answers, isTracking: false, language: language, option: "ALL", question: "{}", scope: "score grammar sim", userAnswer: inputValue);
      try {
        var response = await Application.api.post("https://nlp.sachmem.vn/grader_api/v4/grader/get_similarity", params.toJson());
        if (response.statusCode == 200 && response.data["status"] == "success") {
          return response.data["score"];
        } else {
          return 0;
        }
      } on NetworkException {
        return 0;
      }
    } else {
      return 0;
    }
  }
}
