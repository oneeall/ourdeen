import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/hizb_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'hizb_model.g.dart';

/// Data transfer object for Hizb.
@JsonSerializable()
class HizbModel extends Equatable {
  final int number;
  final EditionModel edition;
  final List<AyahModel> ayahs;

  const HizbModel({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  factory HizbModel.fromJson(Map<String, dynamic> json) =>
      _$HizbModelFromJson(json);

  Map<String, dynamic> toJson() => _$HizbModelToJson(this);

  /// Converts this model to a domain entity.
  HizbEntity toEntity() {
    return HizbEntity(
      number: number,
      edition: edition.toEntity(),
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, edition, ayahs];
}
