import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:match_api/match_api.dart';

part 'league.g.dart';

/// {@template league}
/// Modelo de liga
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class League extends Equatable {
  /// {@macro address}
  const League({
    required this.id,
    required this.area,
    required this.name,
    required this.code,
    required this.type,
    required this.emblem,
    required this.plan,
    required this.currentSeason,
    required this.numberOfAvailableSeasons,
    required this.lastUpdated,
  });

  /// Crea una instancia de [League] a partir de un [Map] json
  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  /// Id de la liga
  final int id;

  /// Área de la liga
  final Area area;

  /// Nombre de la liga
  final String name;

  /// Código de la liga
  final String code;

  /// Tipo de liga
  final String type;

  /// Emblema de la liga
  final String emblem;

  /// Plan de la liga
  final String plan;

  /// Temporada actual de la liga
  final Season currentSeason;

  /// Temporadas disponibles de la liga
  final int numberOfAvailableSeasons;

  /// Última actualización de la liga
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
        id,
        area,
        name,
        code,
        type,
        emblem,
        plan,
        currentSeason,
        numberOfAvailableSeasons,
        lastUpdated,
      ];
}
