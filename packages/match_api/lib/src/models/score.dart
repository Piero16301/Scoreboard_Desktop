import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:match_api/match_api.dart';

part 'score.g.dart';

/// {@template score}
/// Modelo de datos para un marcador
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Score extends Equatable {
  /// {@macro score}
  const Score({
    required this.winner,
    required this.duration,
    required this.fullTime,
    required this.halfTime,
  });

  /// Crea una instancia de [Score] a partir de un [Map] json
  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  /// Ganador del partido
  final String? winner;

  /// Duración del partido
  final String duration;

  /// Marcador final del partido
  final Time fullTime;

  /// Marcador del primer tiempo
  final Time halfTime;

  @override
  List<Object?> get props => [
        winner,
        duration,
        fullTime,
        halfTime,
      ];
}
