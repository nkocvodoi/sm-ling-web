import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/utils/network_exception.dart';

class SaveResultService {
  // ignore: missing_return
  Future<bool> saveResult(
      {String bookId,
      String unitId,
      int levelIndex,
      int lessonIndex,
      List<dynamic> results,
      int timeStart,
      int timeEnd,
      int doneQuestion}) async {
    Map<String, dynamic> params = {
      "bookId": bookId ?? "",
      "unitId": unitId ?? "",
      "levelIndex": levelIndex ?? 0,
      "lessonIndex": lessonIndex ?? 0,
      "results": results ?? [{}],
      "timeStart": timeStart ?? 0,
      "timeEnd": timeEnd ?? 0,
      "doneQuestions": doneQuestion ?? 0
    };
    var response = await Application.api.put("/api/user/saveLesson", params);
    print(params.toString());
    try {
      print(response);
      if (response.statusCode == 200) {
        print("SAVE USER LESSON");
        return response.data["code"] == 1;
      } else {
        print("Put SaveResultService Error");
        return false;
      }
    } on NetworkException {
      print("ERROR!");
    }
  }
}
