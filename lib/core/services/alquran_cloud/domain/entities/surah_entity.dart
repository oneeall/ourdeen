import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';

/// Represents a Surah (chapter) of the Quran.
class SurahEntity extends Equatable {
  /// Surah number (1-114).
  final int number;

  /// Surah name in Arabic.
  final String name;

  /// Surah name in English (transliterated).
  final String englishName;

  /// English translation of the surah name.
  final String englishNameTranslation;

  /// Revelation type ('Meccan' or 'Medinan').
  final String revelationType;

  /// Total number of ayahs in this surah.
  final int numberOfAyahs;

  /// List of ayahs in this surah (optional, populated when fetching full surah).
  final List<AyahEntity>? ayahs;

  const SurahEntity({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    this.ayahs,
  });

  /// Returns true if this is a Meccan surah.
  bool get isMeccan => revelationType.toLowerCase() == 'meccan';

  /// Returns true if this is a Medinan surah.
  bool get isMedinan => revelationType.toLowerCase() == 'medinan';

  /// Display name - English transliteration.
  String get displayName => englishName;

  /// Arabic name.
  String get arabicName => name;

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
