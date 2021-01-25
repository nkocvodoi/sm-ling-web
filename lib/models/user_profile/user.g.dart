// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    displayName: json['displayName'] as String,
    role: json['role'] as String,
    level: json['level'] as int,
    score: json['score'] as int,
    streak: json['streak'] as int,
    lastActive: json['lastActive'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'avatar': instance.avatar,
      'displayName': instance.displayName,
      'role': instance.role,
      'level': instance.level,
      'score': instance.score,
      'streak': instance.streak,
      'lastActive': instance.lastActive,
    };
