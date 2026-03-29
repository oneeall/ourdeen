import 'package:equatable/equatable.dart';
import 'surah_entity.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents the complete Quran.
class QuranEntity extends Equatable {
  /// The edition this Quran is from.
  final EditionEntity edition;

  /// All surahs in the Quran.
  final List<SurahEntity> surahs;

  /// All ayahs in the Quran (flattened list).
  final List<AyahEntity>? ayahs;

  const QuranEntity({
    required this.edition,
    required this.surahs,
    this.ayahs,
  });

  /// Total number of surahs (always 114).
  int get numberOfSurahs => surahs.length;

  /// Total number of ayahs (typically 6236 for standard Quran).
  int get numberOfAyahs => ayahs?.length ?? 0;

  @override
  List<Object?> get props => [edition, surahs, ayahs];
}
