// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ranking _$RankingFromJson(Map<String, dynamic> json) {
  return Ranking(
    group: json['group'] as String,
    tier: json['tier'] as String,
    grade: json['grade'] as int,
    index: json['index'] as int,
    champions: (json['champions'] as List)?.map((e) => e == null ? null : Champions.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'group': instance.group,
      'tier': instance.tier,
      'grade': instance.grade,
      'index': instance.index,
      'champions': instance.champions,
    };

Champions _$ChampionsFromJson(Map<String, dynamic> json) {
  return Champions(
    image: json['image'] as String,
    userId: json['userId'] as String,
    point: json['point'] as int,
  );
}

Map<String, dynamic> _$ChampionsToJson(Champions instance) => <String, dynamic>{
      'image': instance.image,
      'userId': instance.userId,
      'point': instance.point,
    };
