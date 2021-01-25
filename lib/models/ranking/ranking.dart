import 'package:json_annotation/json_annotation.dart';

part 'ranking.g.dart';

@JsonSerializable(nullable: true)
class Ranking {
  String group;
  String tier;
  int grade;
  int index;
  List<Champions> champions;

  Ranking({this.group, this.tier, this.grade, this.index, this.champions});

  factory Ranking.fromJson(Map<String, dynamic> json) => _$RankingFromJson(json);

  Map<String, dynamic> toJson() => _$RankingToJson(this);
}

@JsonSerializable(nullable: true)
class Champions {
  String image;
  String userId;
  int point;

  Champions({this.image, this.userId, this.point});

  factory Champions.fromJson(Map<String, dynamic> json) => _$ChampionsFromJson(json);

  Map<String, dynamic> toJson() => _$ChampionsToJson(this);
}
