import '../entities/animation_preference.dart';

/// Repository interface for animation preference data access
///
/// This abstract contract defines the operations for managing
/// animation settings persistence. Implementations are responsible
/// for storing and retrieving the preference.
abstract class AnimationRepository {
  /// Retrieves the current animation preference
  ///
  /// Returns an [AnimationPreference] object with the current state.
  Future<AnimationPreference> getAnimationPreference();

  /// Updates the animation curve type
  ///
  /// [curveType] - the animation curve type to use
  Future<void> setAnimationCurveType(AnimationCurveType curveType);
}
