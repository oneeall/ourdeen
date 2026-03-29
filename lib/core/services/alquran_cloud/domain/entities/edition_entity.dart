import 'package:equatable/equatable.dart';

/// Represents a Quran edition (text, translation, or audio).
class EditionEntity extends Equatable {
  /// Unique identifier for this edition (e.g., 'quran-uthmani', 'en.sahih').
  final String identifier;

  /// Language code (e.g., 'ar', 'en', 'fr').
  final String language;

  /// Name in the original language.
  final String name;

  /// Name in English.
  final String englishName;

  /// Format type ('audio' or 'text').
  final String format;

  /// Edition type ('quran', 'translation', 'tafsir', or 'audio').
  final String type;

  /// Text direction (only for Arabic text, typically 'rtl').
  final String? direction;

  const EditionEntity({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    this.direction,
  });

  /// Returns true if this is an Arabic edition.
  bool get isArabic => language == 'ar';

  /// Returns true if this is a translation edition.
  bool get isTranslation => type == 'translation';

  /// Returns true if this is a tafsir (exegesis) edition.
  bool get isTafsir => type == 'tafsir';

  /// Returns true if this is an audio edition.
  bool get isAudio => type == 'audio' || format == 'audio';

  @override
  List<Object?> get props => [
        identifier,
        language,
        name,
        englishName,
        format,
        type,
        direction,
      ];
}
