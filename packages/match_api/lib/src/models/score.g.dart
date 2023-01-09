// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return Score(
    winner: json['winner'] as String,
    duration: json['duration'] as String,
    fullTime: Time.fromJson(json['fullTime'] as Map<String, dynamic>),
    halfTime: Time.fromJson(json['halfTime'] as Map<String, dynamic>),
  );
}
