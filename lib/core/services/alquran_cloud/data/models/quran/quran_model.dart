import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/quran_entity.dart';
import '../edition/edition_model.dart';
import '../surah/surah_model.dart';
import '../ayah/ayah_model.dart';

part 'quran_model.g.dart';

/// Data transfer object for complete Quran.
@JsonSerializable()
class QuranModel extends Equatable {
  final EditionModel edition;
  final List<SurahModel>? surahs;
  final List<AyahModel>? ayahs;

  const QuranModel({
    required this.edition,
    this.surahs,
    this.ayahs,
  });

  factory QuranModel.fromJson(Map<String, dynamic> json) =>
      _$QuranModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuranModelToJson(this);

  /// Converts this model to a domain entity.
  QuranEntity toEntity() {
    return QuranEntity(
      edition: edition.toEntity(),
      surahs: surahs?.map((s) => s.toEntity()).toList() ?? [],
      ayahs: ayahs?.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [edition, surahs, ayahs];
}
