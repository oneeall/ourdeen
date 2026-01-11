import 'package:equatable/equatable.dart';

/// Animation curve type for verse animations
enum AnimationCurveType {
  /// No animation effect
  none,

  /// Smooth cubic easing (better performance)
  smooth,

  /// Bouncy elastic easing (more playful but heavier)
  bouncy,
}

/// Value object representing animation settings preference
///
/// This is a value object that holds the animation curve preference
/// for Quran verse animations.
class AnimationPreference extends Equatable {
  /// The type of animation curve to use
  final AnimationCurveType curveType;

  const AnimationPreference({this.curveType = AnimationCurveType.none});

  @override
  List<Object?> get props => [curveType];

  /// Creates a copy with updated values
  AnimationPreference copyWith({AnimationCurveType? curveType}) {
    return AnimationPreference(
      curveType: curveType ?? this.curveType,
    );
  }

  @override
  String toString() {
    return 'AnimationPreference(curveType: $curveType)';
  }
}
