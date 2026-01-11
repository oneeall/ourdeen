import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/animation_preference.dart';
import '../../domain/repositories/animation_repository.dart';

/// Implementation of AnimationRepository using SharedPreferences
///
/// This repository handles the persistence of animation settings
/// using SharedPreferences for local storage.
class AnimationRepositoryImpl implements AnimationRepository {
  /// SharedPreferences key for storing the animation curve type
  static const String _key = 'animation_curve_type';

  @override
  Future<AnimationPreference> getAnimationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final curveTypeIndex = prefs.getInt(_key) ?? 0;
    final curveType = AnimationCurveType.values[curveTypeIndex];
    return AnimationPreference(curveType: curveType);
  }

  @override
  Future<void> setAnimationCurveType(AnimationCurveType curveType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, curveType.index);
  }
}
