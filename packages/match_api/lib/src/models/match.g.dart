// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) {
  return Match(
    area: Area.fromJson(json['area'] as Map<String, dynamic>),
    competition:
        Competition.fromJson(json['competition'] as Map<String, dynamic>),
    season: Season.fromJson(json['season'] as Map<String, dynamic>),
    id: json['id'] as int,
    utcDate: DateTime.parse(json['utcDate'] as String).toLocal(),
    status: json['status'] as String,
    matchday: json['matchday'] as int? ?? 1,
    stage: json['stage'] as String,
    group: json['group'] as String? ?? '-',
    lastUpdated: DateTime.parse(json['lastUpdated'] as String)
        .toLocal()
        .subtract(const Duration(hours: 1)),
    homeTeam: Team.fromJson(json['homeTeam'] as Map<String, dynamic>),
    awayTeam: Team.fromJson(json['awayTeam'] as Map<String, dynamic>),
    score: Score.fromJson(json['score'] as Map<String, dynamic>),
    odds: Odds.fromJson(json['odds'] as Map<String, dynamic>),
    referees: (json['referees'] as List<dynamic>)
        .map((e) => Referee.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
