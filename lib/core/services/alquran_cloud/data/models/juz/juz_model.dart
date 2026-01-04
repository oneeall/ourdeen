import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/juz_entity.dart';
import '../edition/edition_model.dart';
import '../ayah/ayah_model.dart';

part 'juz_model.g.dart';

/// Data transfer object for Juz.
@JsonSerializable()
class JuzModel extends Equatable {
  final int number;
  final EditionModel edition;
  final List<AyahModel> ayahs;

  const JuzModel({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) =>
      _$JuzModelFromJson(json);

  Map<String, dynamic> toJson() => _$JuzModelToJson(this);

  /// Converts this model to a domain entity.
  JuzEntity toEntity() {
    return JuzEntity(
      number: number,
      edition: edition.toEntity(),
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [number, edition, ayahs];
}
