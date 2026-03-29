import '../repositories/tajweed_repository.dart';

/// Use case for updating Tajweed preference
///
/// This use case encapsulates the business logic for updating
/// the Tajweed enabled state in the repository.
class UpdateTajweedPreferenceUseCase {
  final TajweedRepository _repository;

  UpdateTajweedPreferenceUseCase(this._repository);

  /// Executes the use case to update the Tajweed enabled state
  ///
  /// [isEnabled] - true to enable Tajweed mode, false to disable
  Future<void> execute(bool isEnabled) {
    return _repository.setTajweedEnabled(isEnabled);
  }
}
