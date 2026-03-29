import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents a Juz (section) of the Quran.
/// The Quran is divided into 30 Juzs of approximately equal length.
class JuzEntity extends Equatable {
  /// Juz number (1-30).
  final int number;

  /// The edition this Juz is from.
  final EditionEntity edition;

  /// Ayahs in this Juz.
  final List<AyahEntity> ayahs;

  const JuzEntity({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  /// Total number of ayahs in this Juz.
  int get numberOfAyahs => ayahs.length;

  @override
  List<Object?> get props => [number, edition, ayahs];
}
