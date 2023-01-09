import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time.g.dart';

/// {@template time}
/// Modelo de datos para un tiempo
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Time extends Equatable {
  /// {@macro time}
  const Time({
    required this.home,
    required this.away,
  });

  /// Crea una instancia de [Time] a partir de un [Map] json
  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  /// Goles del equipo local
  final int home;

  /// Goles del equipo visitante
  final int away;

  @override
  List<Object?> get props => [
        home,
        away,
      ];
}
