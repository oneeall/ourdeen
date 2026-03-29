import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents a Manzil (portion) of the Quran.
/// The Quran is divided into 7 Manzils for reading over one week.
class ManzilEntity extends Equatable {
  /// Manzil number (1-7).
  final int number;

  /// The edition this Manzil is from.
  final EditionEntity edition;

  /// Ayahs in this Manzil.
  final List<AyahEntity> ayahs;

  const ManzilEntity({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  /// Total number of ayahs in this Manzil.
  int get numberOfAyahs => ayahs.length;

  @override
  List<Object?> get props => [number, edition, ayahs];
}
