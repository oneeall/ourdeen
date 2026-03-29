import '../entities/animation_preference.dart';
import '../repositories/animation_repository.dart';

/// Use case for updating animation preference
///
/// This use case encapsulates the business logic for updating
/// the animation curve type in the repository.
class UpdateAnimationPreferenceUseCase {
  final AnimationRepository _repository;

  UpdateAnimationPreferenceUseCase(this._repository);

  /// Executes the use case to update the animation curve type
  ///
  /// [curveType] - the animation curve type to use
  Future<void> execute(AnimationCurveType curveType) {
    return _repository.setAnimationCurveType(curveType);
  }
}
