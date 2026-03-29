import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/manzil_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'manzil_model.g.dart';

/// Data transfer object for Manzil.
@JsonSerializable()
class ManzilModel extends Equatable {
  final int number;
  final EditionModel edition;
  final List<AyahModel> ayahs;

  const ManzilModel({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  factory ManzilModel.fromJson(Map<String, dynamic> json) =>
      _$ManzilModelFromJson(json);

  Map<String, dynamic> toJson() => _$ManzilModelToJson(this);

  /// Converts this model to a domain entity.
  ManzilEntity toEntity() {
    return ManzilEntity(
      number: number,
      edition: edition.toEntity(),
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, edition, ayahs];
}
