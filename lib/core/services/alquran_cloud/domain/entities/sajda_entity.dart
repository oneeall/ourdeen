import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents verses requiring prostration (Sajda) in the Quran.
/// Depending on the madhab, there can be 14, 15 or 16 sajdas.
/// This API has 15.
class SajdaEntity extends Equatable {
  /// The edition this data is from.
  final EditionEntity edition;

  /// Recommended prostration ayahs.
  final List<AyahEntity> recommended;

  /// Obligatory prostration ayahs.
  final List<AyahEntity> obligatory;

  const SajdaEntity({
    required this.edition,
    required this.recommended,
    required this.obligatory,
  });

  /// All ayahs requiring prostration (both recommended and obligatory).
  List<AyahEntity> get all => [...recommended, ...obligatory];

  /// Total number of prostration ayahs.
  int get count => all.length;

  @override
  List<Object?> get props => [edition, recommended, obligatory];
}
