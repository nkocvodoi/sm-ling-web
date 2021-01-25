import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: true)
class User {
  String email;
  String avatar;
  String displayName;
  String role;
  int level;
  int score;
  int streak;
  String lastActive;

  User({this.email, this.avatar, this.displayName, this.role, this.level, this.score, this.streak, this.lastActive});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
