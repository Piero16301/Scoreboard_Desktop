import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'referee.g.dart';

/// {@template referee}
/// Modelo de datos para un árbitro
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Referee extends Equatable {
  /// {@macro referee}
  const Referee({
    required this.id,
    required this.name,
    required this.type,
    required this.nationality,
  });

  /// Crea una instancia de [Referee] a partir de un [Map] json
  factory Referee.fromJson(Map<String, dynamic> json) =>
      _$RefereeFromJson(json);

  /// Id del árbitro
  final int id;

  /// Nombre del árbitro
  final String name;

  /// Tipo de árbitro
  final String type;

  /// Nacionalidad del árbitro
  final String nationality;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        nationality,
      ];
}
