import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/ayah_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import '../edition/edition_model.dart';

part 'ayah_model.g.dart';

/// Data transfer object for Ayah.
@JsonSerializable()
class AyahModel extends Equatable {
  final int number;
  final String text;
  final EditionModel? edition;

  // Surah information
  final int? surah;
  final int? numberInSurah;

  // Positional information
  final int? juz;
  final int? manzil;
  final int? page;
  final int? ruku;
  final int? hizbQuarter;

  // Sajda information
  final bool? sajda;

  const AyahModel({
    required this.number,
    required this.text,
    this.edition,
    this.surah,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) =>
      _$AyahModelFromJson(json);

  Map<String, dynamic> toJson() => _$AyahModelToJson(this);

  /// Converts this model to a domain entity.
  AyahEntity toEntity() {
    return AyahEntity(
      number: number,
      text: text,
      edition: edition?.toEntity() ?? EditionEntity(
        identifier: 'quran-uthmani',
        language: 'ar',
        name: 'Quran Uthmani',
        englishName: 'Quran Uthmani',
        format: 'text',
        type: 'quran',
        direction: 'rtl',
      ),
      surahNumber: surah,
      numberInSurah: numberInSurah,
      juz: juz,
      manzil: manzil,
      page: page,
      ruku: ruku,
      hizbQuarter: hizbQuarter,
      sajda: sajda,
    );
  }

  @override
  List<Object?> get props => [
        number,
        text,
        edition,
        surah,
        numberInSurah,
        juz,
        manzil,
        page,
        ruku,
        hizbQuarter,
        sajda,
      ];
}
