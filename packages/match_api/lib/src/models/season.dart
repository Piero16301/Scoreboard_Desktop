import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:match_api/match_api.dart';

part 'season.g.dart';

/// {@template season}
/// Modelo de datos para una temporada
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Season extends Equatable {
  /// {@macro season}
  const Season({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.currentMatchday,
    required this.winner,
  });

  /// Crea una instancia de [Season] a partir de un [Map] json
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  /// Id de la temporada
  final int id;

  /// Inicio de la temporada
  final DateTime startDate;

  /// Fin de la temporada
  final DateTime endDate;

  /// Fecha actual de la temporada
  final int currentMatchday;

  /// Ganador de la temporada
  final Team? winner;

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        currentMatchday,
        winner,
      ];
}
