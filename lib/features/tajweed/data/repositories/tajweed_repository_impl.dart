import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/tajweed_preference.dart';
import '../../domain/repositories/tajweed_repository.dart';

/// Implementation of TajweedRepository using SharedPreferences
///
/// This repository handles the persistence of Tajweed settings
/// using SharedPreferences for local storage.
class TajweedRepositoryImpl implements TajweedRepository {
  /// SharedPreferences key for storing the Tajweed enabled state
  static const String _key = 'tajweed_enabled';

  @override
  Future<TajweedPreference> getTajweedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool(_key) ?? false;
    return TajweedPreference(isTajweedEnabled: isEnabled);
  }

  @override
  Future<void> setTajweedEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
  }
}
