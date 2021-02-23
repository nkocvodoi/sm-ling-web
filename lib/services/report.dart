import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/utils/network_exception.dart';

class Report {
  Future<void> report(
      {String bookID,
      String unitID,
      int level,
      int lesson,
      String questionContent,
      String questionDescription,
      String questionId,
      List<String> error,
      String comment,
      String userAnswer,
      String date}) async {
    Map<String, dynamic> params = {
      "bookId": bookID ?? "",
      "unitId": unitID ?? "",
      "level": level ?? 0,
      "lesson": lesson ?? 0,
      "questionContent": questionContent ?? "",
      "questionDescription": questionDescription ?? "",
      "questionId": questionId ?? {},
      "error": error ?? [],
      "comment": comment ?? "",
      "userAnswer": userAnswer ?? "",
      "date": date ?? ""
    };
    var response = await Application.api.put("/api/system/report/question", params);
    try {
      if (response.statusCode == 200) {
      } else {
        print('Report Error!');
      }
    } on NetworkException {
      print('Network Error!');
    }
  }
}
