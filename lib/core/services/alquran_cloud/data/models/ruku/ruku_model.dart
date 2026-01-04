import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/ruku_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'ruku_model.g.dart';

/// Data transfer object for Ruku.
@JsonSerializable()
class RukuModel extends Equatable {
  final int number;
  final EditionModel edition;
  final List<AyahModel> ayahs;

  const RukuModel({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  factory RukuModel.fromJson(Map<String, dynamic> json) =>
      _$RukuModelFromJson(json);

  Map<String, dynamic> toJson() => _$RukuModelToJson(this);

  /// Converts this model to a domain entity.
  RukuEntity toEntity() {
    return RukuEntity(
      number: number,
      edition: edition.toEntity(),
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, edition, ayahs];
}
