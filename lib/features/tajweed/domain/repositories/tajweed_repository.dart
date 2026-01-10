import '../entities/tajweed_preference.dart';

/// Repository interface for Tajweed preference data access
///
/// This abstract contract defines the operations for managing
/// Tajweed settings persistence. Implementations are responsible
/// for storing and retrieving the preference.
abstract class TajweedRepository {
  /// Retrieves the current Tajweed preference
  ///
  /// Returns a [TajweedPreference] object with the current state.
  Future<TajweedPreference> getTajweedPreference();

  /// Updates the Tajweed enabled state
  ///
  /// [value] - true to enable Tajweed mode, false to disable
  Future<void> setTajweedEnabled(bool value);
}
