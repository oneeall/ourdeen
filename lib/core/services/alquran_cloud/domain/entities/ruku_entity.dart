import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents a Ruku (section) of the Quran.
/// The Quran is divided into 556 Rukus.
/// A Ruku is a group of ayahs dealing with one topic.
class RukuEntity extends Equatable {
  /// Ruku number (1-556).
  final int number;

  /// The edition this Ruku is from.
  final EditionEntity edition;

  /// Ayahs in this Ruku.
  final List<AyahEntity> ayahs;

  const RukuEntity({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  /// Total number of ayahs in this Ruku.
  int get numberOfAyahs => ayahs.length;

  @override
  List<Object?> get props => [number, edition, ayahs];
}
