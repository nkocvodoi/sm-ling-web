
import 'package:SMLingg/config/application.dart';
import 'package:SMLingg/models/ranking/ranking.dart';
import 'package:SMLingg/utils/network_exception.dart';

class RankingService {
  // ignore: missing_return
  Future<Ranking> loadRanking(String id) async {
    var response = await Application.api.get("/api/leaderboard");
    try {
      if (response.statusCode == 200) {
        Application.ranking = Ranking.fromJson(response.data as Map<String, dynamic>);
        return Application.ranking;
      } else {
        print("Fetch BookListService Error");
      }
    } on NetworkException {
      print("ERROR!");
    }
  }
}
