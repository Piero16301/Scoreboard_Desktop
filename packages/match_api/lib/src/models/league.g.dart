// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

League _$LeagueFromJson(Map<String, dynamic> json) {
  return League(
    id: json['id'] as int,
    area: Area.fromJson(json['area'] as Map<String, dynamic>),
    name: json['name'] as String,
    code: json['code'] as String,
    type: json['type'] as String,
    emblem: json['emblem'] as String,
    plan: json['plan'] as String,
    currentSeason:
        Season.fromJson(json['currentSeason'] as Map<String, dynamic>),
    numberOfAvailableSeasons: json['numberOfAvailableSeasons'] as int,
    lastUpdated: DateTime.parse(json['lastUpdated'] as String).toLocal(),
  );
}
