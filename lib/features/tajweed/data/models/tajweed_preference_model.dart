/// Data Transfer Object for Tajweed preference
///
/// This model represents the Tajweed preference data structure
/// for serialization and deserialization.
class TajweedPreferenceModel {
  final bool isTajweedEnabled;

  TajweedPreferenceModel({required this.isTajweedEnabled});

  /// Creates a TajweedPreferenceModel from JSON
  factory TajweedPreferenceModel.fromJson(Map<String, dynamic> json) {
    return TajweedPreferenceModel(
      isTajweedEnabled: json['tajweed_enabled'] ?? false,
    );
  }

  /// Converts the model to JSON
  Map<String, dynamic> toJson() {
    return {'tajweed_enabled': isTajweedEnabled};
  }
}
