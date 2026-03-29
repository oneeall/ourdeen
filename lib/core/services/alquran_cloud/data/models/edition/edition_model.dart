import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';

part 'edition_model.g.dart';

/// Data transfer object for Edition.
@JsonSerializable()
class EditionModel extends Equatable {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String? direction;

  const EditionModel({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    this.direction,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) =>
      _$EditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditionModelToJson(this);

  /// Converts this model to a domain entity.
  EditionEntity toEntity() {
    return EditionEntity(
      identifier: identifier,
      language: language,
      name: name,
      englishName: englishName,
      format: format,
      type: type,
      direction: direction,
    );
  }

  @override
  List<Object?> get props => [
        identifier,
        language,
        name,
        englishName,
        format,
        type,
        direction,
      ];
}
