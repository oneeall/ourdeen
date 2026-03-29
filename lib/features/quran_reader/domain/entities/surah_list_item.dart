import 'package:equatable/equatable.dart';

/// Represents a simplified surah item for list display.
class SurahListItem extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;

  const SurahListItem({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  /// Returns the revelation type in a more readable format.
  String get displayRevelationType {
    switch (revelationType.toLowerCase()) {
      case 'meccan':
        return 'Makkiyah';
      case 'medinan':
        return 'Madaniyah';
      default:
        return revelationType;
    }
  }

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        numberOfAyahs,
      ];
}