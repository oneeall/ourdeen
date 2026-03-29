import '../entities/animation_preference.dart';
import '../repositories/animation_repository.dart';

/// Use case for retrieving animation preference
///
/// This use case encapsulates the business logic for fetching
/// the current animation setting from the repository.
class GetAnimationPreferenceUseCase {
  final AnimationRepository _repository;

  GetAnimationPreferenceUseCase(this._repository);

  /// Executes the use case to get the current animation preference
  ///
  /// Returns the current [AnimationPreference] from the repository.
  Future<AnimationPreference> execute() {
    return _repository.getAnimationPreference();
  }
}
