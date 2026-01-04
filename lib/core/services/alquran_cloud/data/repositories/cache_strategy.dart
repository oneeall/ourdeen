/// Cache TTL (Time-To-Live) strategy for different data types.
class CacheStrategy {
  /// Editions rarely change - cache for 30 days
  static const Duration editionsTtl = Duration(days: 30);

  /// Surah list (metadata) rarely changes - cache for 30 days
  static const Duration surahsTtl = Duration(days: 30);

  /// Complete Quran - cache for 7 days
  static const Duration quranTtl = Duration(days: 7);

  /// Single surah with ayahs - cache for 1 day
  static const Duration surahTtl = Duration(days: 1);

  /// Single ayah - cache for 1 day
  static const Duration ayahTtl = Duration(days: 1);

  /// Juz - cache for 7 days (static grouping)
  static const Duration juzTtl = Duration(days: 7);

  /// Page - cache for 7 days (static grouping)
  static const Duration pageTtl = Duration(days: 7);

  /// Hizb - cache for 7 days (static grouping)
  static const Duration hizbTtl = Duration(days: 7);

  /// Manzil - cache for 7 days (static grouping)
  static const Duration manzilTtl = Duration(days: 7);

  /// Ruku - cache for 7 days (static grouping)
  static const Duration rukuTtl = Duration(days: 7);

  /// Search results - cache for 1 hour (user-generated, needs freshness)
  static const Duration searchTtl = Duration(hours: 1);

  /// Sajda - cache for 30 days (rarely changes)
  static const Duration sajdaTtl = Duration(days: 30);

  /// Meta data - cache for 30 days (rarely changes)
  static const Duration metaTtl = Duration(days: 30);
}

/// Cache key patterns for storing data in SharedPreferences.
class CacheKeys {
  static const String _prefix = 'alquran_';

  static String editions() => '${_prefix}editions';
  static String surahs() => '${_prefix}surahs';
  static String surah(int number) => '${_prefix}surah_$number';
  static String ayah(String reference) => '${_prefix}ayah_$reference';
  static String quran(String edition) => '${_prefix}quran_$edition';
  static String juz(int number) => '${_prefix}juz_$number';
  static String page(int number) => '${_prefix}page_$number';
  static String hizb(int number) => '${_prefix}hizb_$number';
  static String manzil(int number) => '${_prefix}manzil_$number';
  static String ruku(int number) => '${_prefix}ruku_$number';
  static String sajda(String edition) => '${_prefix}sajda_$edition';
  static String search(String query) => '${_prefix}search_${query.toLowerCase()}';
  static String meta() => '${_prefix}meta';

  /// Clears all cache keys (use with caution).
  static String all() => '$_prefix*';
}
