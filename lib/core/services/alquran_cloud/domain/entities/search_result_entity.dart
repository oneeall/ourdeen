import 'package:equatable/equatable.dart';
import 'ayah_entity.dart';

/// Represents search results from the Quran.
class SearchResultEntity extends Equatable {
  /// The search query that was used.
  final String query;

  /// Total count of matching ayahs.
  final int count;

  /// The matching ayahs.
  final List<AyahEntity> matches;

  const SearchResultEntity({
    required this.query,
    required this.count,
    required this.matches,
  });

  /// Returns true if no results were found.
  bool get isEmpty => matches.isEmpty;

  /// Returns true if results were found.
  bool get isNotEmpty => matches.isNotEmpty;

  @override
  List<Object?> get props => [query, count, matches];
}
