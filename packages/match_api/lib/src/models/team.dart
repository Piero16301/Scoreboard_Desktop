import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

/// {@template team}
/// Modelo de datos para un equipo
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Team extends Equatable {
  /// {@macro team}
  const Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
  });

  /// Crea una instancia de [Team] a partir de un [Map] json
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  /// Id del equipo
  final int id;

  /// Nombre del equipo
  final String name;

  /// Nombre corto del equipo
  final String shortName;

  /// Abreviatura del equipo
  final String tla;

  /// Escudo del equipo
  final String crest;

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
        tla,
        crest,
      ];
}
