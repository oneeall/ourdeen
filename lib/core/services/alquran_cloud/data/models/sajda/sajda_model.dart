import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/sajda_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'sajda_model.g.dart';

/// Data transfer object for Sajda.
@JsonSerializable()
class SajdaModel extends Equatable {
  final EditionModel edition;
  final List<AyahModel> recommended;
  final List<AyahModel> obligatory;

  const SajdaModel({
    required this.edition,
    required this.recommended,
    required this.obligatory,
  });

  factory SajdaModel.fromJson(Map<String, dynamic> json) =>
      _$SajdaModelFromJson(json);

  Map<String, dynamic> toJson() => _$SajdaModelToJson(this);

  /// Converts this model to a domain entity.
  SajdaEntity toEntity() {
    return SajdaEntity(
      edition: edition.toEntity(),
      recommended: recommended.map((a) => a.toEntity()).toList(),
      obligatory: obligatory.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [edition, recommended, obligatory];
}
