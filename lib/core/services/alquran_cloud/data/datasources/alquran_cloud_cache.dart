import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ourdeen/core/services/network/cache_manager.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/repositories/cache_strategy.dart';

/// Cache implementation for Alquran.cloud API responses.
class AlquranCloudCache {
  final CacheManager _cacheManager;

  AlquranCloudCache(SharedPreferences prefs) : _cacheManager = CacheManager(prefs);

  /// Gets a cached response with automatic type checking.
  Future<T?> get<T extends BaseResponse>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final jsonString = await _cacheManager.get<String>(key);
    if (jsonString == null) return null;

    try {
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(decoded);
    } catch (e) {
      // If deserialization fails, invalidate and return null
      await _cacheManager.invalidate(key);
      return null;
    }
  }

  /// Sets a cached response with the specified TTL.
  /// Stores the raw JSON data from the BaseResponse.
  Future<void> set<T extends BaseResponse>(
    String key,
    T data, {
    required Duration ttl,
  }) async {
    final jsonMap = {
      'code': data.code,
      'status': data.status,
      'data': data.data,
    };
    final jsonString = jsonEncode(jsonMap);
    await _cacheManager.set(key, jsonString, ttl);
  }

  /// Invalidates a specific cache key.
  Future<void> invalidate(String key) async {
    await _cacheManager.invalidate(key);
  }

  /// Clears all Alquran-related cached data.
  Future<void> clearAll() async {
    await _cacheManager.clear();
  }

  // Convenience methods for common data types

  Future<BaseResponse?> getEditions() async {
    return get<BaseResponse>(
      CacheKeys.editions(),
      fromJson: (json) => BaseResponse.fromJson(json, (data) {
        if (data is List) {
          return data.map((item) => item as Map<String, dynamic>).toList();
        }
        return data;
      }),
    );
  }

  Future<void> setEditions(BaseResponse data) async {
    await set(CacheKeys.editions(), data, ttl: CacheStrategy.editionsTtl);
  }

  Future<BaseResponse?> getSurahs() async {
    return get<BaseResponse>(
      CacheKeys.surahs(),
      fromJson: (json) => BaseResponse.fromJson(json, (data) {
        if (data is List) {
          return data.map((item) => item as Map<String, dynamic>).toList();
        }
        return data;
      }),
    );
  }

  Future<void> setSurahs(BaseResponse data) async {
    await set(CacheKeys.surahs(), data, ttl: CacheStrategy.surahsTtl);
  }

  Future<BaseResponse?> getSurah(int number) async {
    return get<BaseResponse>(
      CacheKeys.surah(number),
      fromJson: (json) => BaseResponse.fromJson(json, (data) {
        if (data == null) return null;
        if (data is Map) {
          return Map<String, dynamic>.from(data);
        }
        return data;
      }),
    );
  }

  Future<void> setSurah(int number, BaseResponse data) async {
    await set(CacheKeys.surah(number), data, ttl: CacheStrategy.surahTtl);
  }

  Future<BaseResponse?> getAyah(String reference) async {
    return get<BaseResponse>(
      CacheKeys.ayah(reference),
      fromJson: (json) => BaseResponse.fromJson(json, (data) {
        if (data is Map) {
          return data as Map<String, dynamic>;
        }
        return data;
      }),
    );
  }

  Future<void> setAyah(String reference, BaseResponse data) async {
    await set(CacheKeys.ayah(reference), data, ttl: CacheStrategy.ayahTtl);
  }
}
