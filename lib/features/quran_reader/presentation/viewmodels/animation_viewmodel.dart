import 'package:ourdeen/features/shared/base_viewmodel.dart';
import '../../domain/usecases/get_animation_preference_usecase.dart';
import '../../domain/usecases/update_animation_preference_usecase.dart';
import '../../domain/entities/animation_preference.dart';

/// ViewModel for managing animation settings
///
/// This ViewModel handles the presentation logic for animation settings,
/// including loading the preference and changing the animation curve.
/// It extends BaseViewModel for consistent state management.
class AnimationViewModel extends BaseViewModel {
  final GetAnimationPreferenceUseCase _getPreferenceUseCase;
  final UpdateAnimationPreferenceUseCase _updatePreferenceUseCase;

  AnimationPreference? _preference;

  /// The current animation preference
  AnimationPreference? get preference => _preference;

  /// Whether smooth animation (easeOutCubic) is enabled
  bool get isSmoothEnabled => _preference?.curveType == AnimationCurveType.smooth;

  /// Whether bouncy animation (elasticOut) is enabled
  bool get isBouncyEnabled => _preference?.curveType == AnimationCurveType.bouncy;

  /// Whether animation is disabled
  bool get isAnimationDisabled => _preference?.curveType == AnimationCurveType.none;

  AnimationViewModel(
    this._getPreferenceUseCase,
    this._updatePreferenceUseCase,
  );

  /// Loads the animation preference from persistent storage
  Future<void> loadPreference() async {
    setBusy(true);
    try {
      _preference = await _getPreferenceUseCase.execute();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Sets the animation curve type
  ///
  /// [curveType] - the animation curve type to use
  Future<void> setAnimationCurve(AnimationCurveType curveType) async {
    setBusy(true);
    try {
      await _updatePreferenceUseCase.execute(curveType);
      _preference = _preference?.copyWith(curveType: curveType) ??
          AnimationPreference(curveType: curveType);
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Toggles between smooth and bouncy animation
  Future<void> toggleAnimation() async {
    final newCurveType = isSmoothEnabled
        ? AnimationCurveType.bouncy
        : AnimationCurveType.smooth;
    await setAnimationCurve(newCurveType);
  }

  /// Get the current animation curve type
  AnimationCurveType get curveType =>
      _preference?.curveType ?? AnimationCurveType.none;
}
