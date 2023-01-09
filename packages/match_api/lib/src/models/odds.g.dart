// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Odds _$OddsFromJson(Map<String, dynamic> json) {
  return Odds(
    homeWin:
        json['homeWin'] != null ? (json['homeWin'] as num).toDouble() : null,
    draw: json['draw'] != null ? (json['draw'] as num).toDouble() : null,
    awayWin:
        json['awayWin'] != null ? (json['awayWin'] as num).toDouble() : null,
  );
}
