import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'area.g.dart';

/// {@template area}
/// Modelo de datos para un área
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Area extends Equatable {
  /// {@macro area}
  const Area({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });

  /// Crea una instancia de [Area] a partir de un [Map] json
  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

  /// Id del área
  final int id;

  /// Nombre del área
  final String name;

  /// Código del área
  final String code;

  /// Bandera del área
  final String? flag;

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        flag,
      ];
}
