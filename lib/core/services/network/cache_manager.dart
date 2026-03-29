import 'dart:convert';
import 'package:clock/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A cache entry with data and expiration information.
class CacheEntry<T> {
  /// The cached data.
  final T data;

  /// When the data was cached.
  final DateTime cachedAt;

  /// Time-to-live for this cache entry.
  final Duration ttl;

  CacheEntry({
    required this.data,
    required this.cachedAt,
    required this.ttl,
  });

  /// Returns true if this cache entry has expired.
  bool get isExpired => clock.now().isAfter(cachedAt.add(ttl));

  /// Creates a CacheEntry from JSON.
  factory CacheEntry.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    return CacheEntry<T>(
      data: fromJson(json['data']),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
      ttl: Duration(milliseconds: json['ttl'] as int),
    );
  }

  /// Converts this CacheEntry to JSON.
  Map<String, dynamic> toJson(dynamic Function(T) toJson) {
    return {
      'data': toJson(data),
      'cachedAt': cachedAt.toIso8601String(),
      'ttl': ttl.inMilliseconds,
    };
  }
}

/// Generic cache manager using SharedPreferences.
class CacheManager {
  final SharedPreferences _prefs;

  CacheManager(this._prefs);

  /// Sets a value in the cache with the given TTL.
  Future<void> set(String key, dynamic value, Duration ttl) async {
    final entry = CacheEntry(
      data: value,
      cachedAt: clock.now(),
      ttl: ttl,
    );

    // Store as JSON string
    final jsonString = jsonEncode({
      'data': value,
      'cachedAt': clock.now().toIso8601String(),
      'ttl': ttl.inMilliseconds,
    });

    await _prefs.setString(key, jsonString);
  }

  /// Gets a value from the cache.
  ///
  /// Returns null if the key doesn't exist or if the cache has expired.
  Future<T?> get<T>(String key) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(json['cachedAt'] as String);
      final ttl = Duration(milliseconds: json['ttl'] as int);

      // Check if expired
      if (clock.now().isAfter(cachedAt.add(ttl))) {
        // Remove expired entry
        await invalidate(key);
        return null;
      }

      return json['data'] as T;
    } catch (e) {
      // If parsing fails, remove the corrupted entry
      await invalidate(key);
      return null;
    }
  }

  /// Invalidates a specific cache key.
  Future<void> invalidate(String key) async {
    await _prefs.remove(key);
  }

  /// Clears all cached data.
  Future<void> clear() async {
    // Only clear keys that start with our cache prefix
    final keys = _prefs.getKeys().where((key) => key.startsWith('alquran_'));
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }

  /// Checks if a key exists and is not expired.
  Future<bool> hasValid(String key) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return false;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(json['cachedAt'] as String);
      final ttl = Duration(milliseconds: json['ttl'] as int);
      return !clock.now().isAfter(cachedAt.add(ttl));
    } catch (e) {
      return false;
    }
  }
}
