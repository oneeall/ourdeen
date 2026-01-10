import '../entities/tajweed_preference.dart';
import '../repositories/tajweed_repository.dart';

/// Use case for retrieving Tajweed preference
///
/// This use case encapsulates the business logic for fetching
/// the current Tajweed setting from the repository.
class GetTajweedPreferenceUseCase {
  final TajweedRepository _repository;

  GetTajweedPreferenceUseCase(this._repository);

  /// Executes the use case to get the current Tajweed preference
  ///
  /// Returns the current [TajweedPreference] from the repository.
  Future<TajweedPreference> execute() {
    return _repository.getTajweedPreference();
  }
}
