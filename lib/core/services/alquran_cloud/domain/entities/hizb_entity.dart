import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents a Hizb (portion) of the Quran.
/// The Quran is divided into 240 Hizb Quarters.
/// One Hizb = half a Juz.
class HizbEntity extends Equatable {
  /// Hizb quarter number (1-240).
  final int number;

  /// The edition this Hizb is from.
  final EditionEntity edition;

  /// Ayahs in this Hizb quarter.
  final List<AyahEntity> ayahs;

  const HizbEntity({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  /// Total number of ayahs in this Hizb quarter.
  int get numberOfAyahs => ayahs.length;

  @override
  List<Object?> get props => [number, edition, ayahs];
}
