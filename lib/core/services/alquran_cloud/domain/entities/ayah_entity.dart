import 'package:equatable/equatable.dart';
import 'edition_entity.dart';

/// Represents a single Ayah (verse) of the Quran.
class AyahEntity extends Equatable {
  /// Global ayah number (1-6236).
  final int number;

  /// The text content of the ayah.
  final String text;

  /// The edition this ayah is from.
  final EditionEntity edition;

  /// Surah number (1-114).
  final int? surahNumber;

  /// Ayah number within the surah.
  final int? numberInSurah;

  /// Juz number (1-30).
  final int? juz;

  /// Manzil number (1-7).
  final int? manzil;

  /// Page number (1-604).
  final int? page;

  /// Ruku number (1-556).
  final int? ruku;

  /// Hizb quarter number (1-240).
  final int? hizbQuarter;

  /// Whether this ayah requires prostration (sajda).
  final bool? sajda;

  const AyahEntity({
    required this.number,
    required this.text,
    required this.edition,
    this.surahNumber,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  /// Returns the surah:ayah reference (e.g., '2:255' for Ayat al-Kursi).
  String get surahAyahReference {
    if (surahNumber != null && numberInSurah != null) {
      return '$surahNumber:$numberInSurah';
    }
    return '$number';
  }

  /// Returns true if this ayah requires prostration.
  bool get isSajda => sajda == true;

  @override
  List<Object?> get props => [
        number,
        text,
        edition,
        surahNumber,
        numberInSurah,
        juz,
        manzil,
        page,
        ruku,
        hizbQuarter,
        sajda,
      ];
}
