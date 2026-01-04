import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/surah_entity.dart';
import '../ayah/ayah_model.dart';

part 'surah_with_ayahs_model.g.dart';

/// Data transfer object for Surah with ayahs.
/// Used when fetching a complete surah with its ayahs.
@JsonSerializable()
class SurahWithAyahsModel extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;

  // List of ayahs in this surah
  @JsonKey(name: 'ayahs')
  final List<AyahModel> ayahs;

  const SurahWithAyahsModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
  });

  factory SurahWithAyahsModel.fromJson(Map<String, dynamic> json) =>
      _$SurahWithAyahsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurahWithAyahsModelToJson(this);

  /// Converts this model to a domain entity.
  SurahEntity toEntity() {
    return SurahEntity(
      number: number,
      name: name,
      englishName: englishName,
      englishNameTranslation: englishNameTranslation,
      revelationType: revelationType,
      numberOfAyahs: numberOfAyahs,
      ayahs: ayahs.map((a) => a.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        numberOfAyahs,
        ayahs,
      ];
}
