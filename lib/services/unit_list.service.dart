import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/utils/network_exception.dart';

class UnitListService {
  // ignore: missing_return
  Future<UnitList> loadUnitList(String id) async {
    var response = await Application.api.get("/api/book/$id/units");
    try {
      if (response.statusCode == 200) {
        Application.currentBook =
            Application.bookList.books.elementAt(Application.bookList.books.indexWhere((element) => element.id == id));
        Application.unitList = UnitList.fromJson(response.data["data"] as Map<String, dynamic>);
        return Application.unitList;
      } else {
        print("Fetch BookListService Error");
      }
    } on NetworkException {
      print("ERROR!");
    }
  }
}
