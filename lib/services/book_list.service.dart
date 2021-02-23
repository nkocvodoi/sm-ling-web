import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/utils/network_exception.dart';

class BookListService {
  // ignore: missing_return
  Future<List<Book>> loadBookList(int grade) async {
    var response = await Application.api.get("/api/books/grade/${grade + 1}");
    Application.sharePreference.putString("chooseBook", "/api/books/grade/${grade + 1}");
    try {
      print(response.data["data"]);
      if (response.statusCode == 200) {
        var bookJson = response.data['data'] as List;
        Application.bookList.books = bookJson.map((book) => Book.fromJson(book)).toList();
        return Application.bookList.books;
      } else {
        print("Fetch UnitListService Error");
      }
    } on NetworkException {
      print("ERROR!");
    }
  }
}
