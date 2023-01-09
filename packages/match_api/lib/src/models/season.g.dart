// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return Season(
    id: json['id'] as int,
    startDate: DateTime.parse(json['startDate'] as String).toLocal(),
    endDate: DateTime.parse(json['endDate'] as String).toLocal(),
    currentMatchday: json['currentMatchday'] as int,
    winner: json['winner'] != null
        ? Team.fromJson(json['winner'] as Map<String, dynamic>)
        : null,
  );
}
