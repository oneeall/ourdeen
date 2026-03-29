import 'package:ourdeen/features/shared/base_viewmodel.dart';
import '../../domain/usecases/get_tajweed_preference_usecase.dart';
import '../../domain/usecases/update_tajweed_preference_usecase.dart';
import '../../domain/entities/tajweed_preference.dart';

/// ViewModel for managing Tajweed settings
///
/// This ViewModel handles the presentation logic for Tajweed settings,
/// including loading the preference and toggling the Tajweed mode.
/// It extends BaseViewModel for consistent state management.
class TajweedViewModel extends BaseViewModel {
  final GetTajweedPreferenceUseCase _getPreferenceUseCase;
  final UpdateTajweedPreferenceUseCase _updatePreferenceUseCase;

  TajweedPreference? _preference;

  /// The current Tajweed preference
  TajweedPreference? get preference => _preference;

  /// Whether Tajweed mode is currently enabled
  bool get isTajweedEnabled => _preference?.isTajweedEnabled ?? false;

  TajweedViewModel(
    this._getPreferenceUseCase,
    this._updatePreferenceUseCase,
  );

  /// Loads the Tajweed preference from persistent storage
  Future<void> loadPreference() async {
    setBusy(true);
    try {
      _preference = await _getPreferenceUseCase.execute();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Toggles the Tajweed mode
  ///
  /// [value] - true to enable Tajweed mode, false to disable
  Future<void> toggleTajweed(bool value) async {
    setBusy(true);
    try {
      await _updatePreferenceUseCase.execute(value);
      _preference = _preference?.copyWith(isTajweedEnabled: value) ??
          TajweedPreference(isTajweedEnabled: value);
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  /// Get the Arabic edition identifier based on current Tajweed setting
  ///
  /// This will be used by AlquranCloudService to determine which
  /// Quran edition to fetch. Returns 'quran-tajweed' if enabled,
  /// otherwise 'quran-uthmani'.
  String get arabicEdition => _preference?.arabicEdition ?? 'quran-uthmani';
}
