import 'package:equatable/equatable.dart';

/// Value object representing Tajweed settings preference
///
/// This is a value object that holds the Tajweed activation state
/// and provides the Arabic Quran edition based on the preference.
class TajweedPreference extends Equatable {
  /// Whether Tajweed mode is enabled
  final bool isTajweedEnabled;

  const TajweedPreference({this.isTajweedEnabled = false});

  /// Returns the Arabic Quran edition identifier based on Tajweed setting
  ///
  /// When Tajweed is enabled, returns 'quran-tajweed' which contains
  /// color-coded Tajweed rules. Otherwise returns 'quran-uthmani'.
  String get arabicEdition =>
      isTajweedEnabled ? 'quran-tajweed' : 'quran-uthmani';

  @override
  List<Object?> get props => [isTajweedEnabled];

  /// Creates a copy with updated values
  TajweedPreference copyWith({bool? isTajweedEnabled}) {
    return TajweedPreference(
      isTajweedEnabled: isTajweedEnabled ?? this.isTajweedEnabled,
    );
  }

  @override
  String toString() {
    return 'TajweedPreference(isTajweedEnabled: $isTajweedEnabled, arabicEdition: $arabicEdition)';
  }
}
