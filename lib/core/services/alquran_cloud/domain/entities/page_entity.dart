import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';
import 'edition_entity.dart';

/// Represents a page of the Quran.
/// The traditional printed Quran has 604 pages.
class PageEntity extends Equatable {
  /// Page number (1-604).
  final int number;

  /// The edition this page is from.
  final EditionEntity edition;

  /// Ayahs on this page.
  final List<AyahEntity> ayahs;

  const PageEntity({
    required this.number,
    required this.edition,
    required this.ayahs,
  });

  /// Total number of ayahs on this page.
  int get numberOfAyahs => ayahs.length;

  @override
  List<Object?> get props => [number, edition, ayahs];
}
