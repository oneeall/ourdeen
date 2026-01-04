import 'package:shared_preferences/shared_preferences.dart';
import 'package:ourdeen/core/services/network/api_response.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/surah_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/ayah_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/quran_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/juz_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/page_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/hizb_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/manzil_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/ruku_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/sajda_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/search_result_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/repositories/alquran_cloud_repository.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/datasources/alquran_cloud_api.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/datasources/alquran_cloud_cache.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/edition/edition_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/surah/surah_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/surah/surah_with_ayahs_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/ayah/ayah_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/quran/quran_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/search/search_response.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/juz/juz_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/page/page_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/hizb/hizb_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/manzil/manzil_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/ruku/ruku_model.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/sajda/sajda_model.dart';

/// Repository implementation for Alquran.cloud API.
///
/// Provides cache-first data access with fallback to API.
class AlquranCloudRepositoryImpl implements AlquranCloudRepository {
  final AlquranCloudApi _api;
  final AlquranCloudCache _cache;

  AlquranCloudRepositoryImpl({
    required AlquranCloudApi api,
    required SharedPreferences prefs,
  }) : _api = api,
       _cache = AlquranCloudCache(prefs);

  // Edition endpoints

  @override
  Future<ApiResponse<List<EditionEntity>>> getEditions() async {
    try {
      // Try cache first
      final cached = await _cache.getEditions();
      if (cached != null && cached.isSuccess && cached.data != null) {
        final editions = (cached.data as List)
            .map((json) => EditionModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();
        return ApiResponse.success(editions);
      }

      // Fetch from API
      final response = await _api.getEditions();

      if (response.isSuccess && response.data != null) {
        final editions = (response.data as List)
            .map((json) => EditionModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();

        // Cache the result
        await _cache.setEditions(response);

        return ApiResponse.success(editions);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<EditionEntity>>> getEditionsByLanguage(String language) async {
    try {
      final response = await _api.getEditionsByLanguage(language);

      if (response.isSuccess && response.data != null) {
        final editions = (response.data as List)
            .map((json) => EditionModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();
        return ApiResponse.success(editions);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<EditionEntity>>> getEditionsByType(String type) async {
    try {
      final response = await _api.getEditionsByType(type);

      if (response.isSuccess && response.data != null) {
        final editions = (response.data as List)
            .map((json) => EditionModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();
        return ApiResponse.success(editions);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Quran endpoints

  @override
  Future<ApiResponse<QuranEntity>> getQuran(String edition) async {
    try {
      final response = await _api.getQuran(edition);

      if (response.isSuccess && response.data != null) {
        final quran = QuranModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(quran.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Surah endpoints

  @override
  Future<ApiResponse<List<SurahEntity>>> getSurahs() async {
    try {
      // Try cache first
      final cached = await _cache.getSurahs();
      if (cached != null && cached.isSuccess && cached.data != null) {
        final surahs = (cached.data as List)
            .map((json) => SurahModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();
        return ApiResponse.success(surahs);
      }

      // Fetch from API
      final response = await _api.getSurahs();

      if (response.isSuccess && response.data != null) {
        final surahs = (response.data as List)
            .map((json) => SurahModel.fromJson(json as Map<String, dynamic>))
            .map((model) => model.toEntity())
            .toList();

        // Cache the result
        await _cache.setSurahs(response);

        return ApiResponse.success(surahs);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<SurahEntity>> getSurah(int number) async {
    try {
      // Try cache first
      final cached = await _cache.getSurah(number);
      if (cached != null && cached.isSuccess && cached.data != null) {
        if (cached.data is Map<String, dynamic>) {
          final surah = SurahWithAyahsModel.fromJson(cached.data as Map<String, dynamic>);
          return ApiResponse.success(surah.toEntity());
        }
      }

      // Fetch from API
      final response = await _api.getSurah(number);

      if (response.isSuccess && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final surah = SurahWithAyahsModel.fromJson(response.data as Map<String, dynamic>);
          final entity = surah.toEntity();

          // Cache the result
          await _cache.setSurah(number, response);

          return ApiResponse.success(entity);
        }
      }

      return ApiResponse.failure(
        response.status,
        response.code,
      );
    } catch (e, stackTrace) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<SurahEntity>> getSurahWithEditions(int number, List<String> editions) async {
    try {
      final editionsStr = editions.join(',');
      final response = await _api.getSurahWithEditions(number, editionsStr);

      if (response.isSuccess && response.data != null) {
        // When requesting multiple editions, response contains an array
        final data = response.data;
        if (data is List && data.isNotEmpty) {
          // First item should be the Arabic Quran
          final surah = SurahWithAyahsModel.fromJson(data[0] as Map<String, dynamic>);
          return ApiResponse.success(surah.toEntity());
        } else if (data is Map) {
          final surah = SurahWithAyahsModel.fromJson(data as Map<String, dynamic>);
          return ApiResponse.success(surah.toEntity());
        }
      }

      return ApiResponse.failure(
        response.status,
        response.code,
      );
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Ayah endpoints

  @override
  Future<ApiResponse<AyahEntity>> getAyah(String reference) async {
    try {
      // Try cache first
      final cached = await _cache.getAyah(reference);
      if (cached != null && cached.isSuccess && cached.data != null) {
        final ayah = AyahModel.fromJson(cached.data as Map<String, dynamic>);
        return ApiResponse.success(ayah.toEntity());
      }

      // Fetch from API
      final response = await _api.getAyah(reference);

      if (response.isSuccess && response.data != null) {
        final ayah = AyahModel.fromJson(response.data as Map<String, dynamic>);
        final entity = ayah.toEntity();

        // Cache the result
        await _cache.setAyah(reference, response);

        return ApiResponse.success(entity);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<List<AyahEntity>>> getAyahWithEditions(String reference, List<String> editions) async {
    try {
      final editionsStr = editions.join(',');
      final response = await _api.getAyahWithEditions(reference, editionsStr);

      if (response.isSuccess && response.data != null) {
        final data = response.data;
        List<AyahEntity> ayahs = [];

        if (data is List) {
          for (final item in data) {
            final ayah = AyahModel.fromJson(item as Map<String, dynamic>);
            ayahs.add(ayah.toEntity());
          }
        } else if (data is Map) {
          final ayah = AyahModel.fromJson(data as Map<String, dynamic>);
          ayahs.add(ayah.toEntity());
        }

        return ApiResponse.success(ayahs);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Search

  @override
  Future<ApiResponse<SearchResultEntity>> search(String keyword, String? surah, String edition) async {
    try {
      final surahParam = surah ?? 'all';
      final response = await _api.search(keyword, surahParam, edition);

      if (response.isSuccess && response.data != null) {
        final searchData = SearchDataModel.fromJson(response.data as Map<String, dynamic>);
        final searchResult = SearchResultEntity(
          query: keyword,
          count: searchData.count,
          matches: searchData.matches.map((m) => m.toEntity()).toList(),
        );
        return ApiResponse.success(searchResult);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Juz

  @override
  Future<ApiResponse<JuzEntity>> getJuz(int number) async {
    try {
      final response = await _api.getJuz(number);

      if (response.isSuccess && response.data != null) {
        final juz = JuzModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(juz.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<JuzEntity>> getJuzWithEdition(int number, String edition) async {
    try {
      final response = await _api.getJuzWithEdition(number, edition);

      if (response.isSuccess && response.data != null) {
        final juz = JuzModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(juz.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Page

  @override
  Future<ApiResponse<PageEntity>> getPage(int number) async {
    try {
      final response = await _api.getPage(number);

      if (response.isSuccess && response.data != null) {
        final page = PageModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(page.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<PageEntity>> getPageWithEdition(int number, String edition) async {
    try {
      final response = await _api.getPageWithEdition(number, edition);

      if (response.isSuccess && response.data != null) {
        final page = PageModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(page.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Hizb

  @override
  Future<ApiResponse<HizbEntity>> getHizb(int number) async {
    try {
      final response = await _api.getHizb(number);

      if (response.isSuccess && response.data != null) {
        final hizb = HizbModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(hizb.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<HizbEntity>> getHizbWithEdition(int number, String edition) async {
    try {
      final response = await _api.getHizbWithEdition(number, edition);

      if (response.isSuccess && response.data != null) {
        final hizb = HizbModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(hizb.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Manzil

  @override
  Future<ApiResponse<ManzilEntity>> getManzil(int number) async {
    try {
      final response = await _api.getManzil(number);

      if (response.isSuccess && response.data != null) {
        final manzil = ManzilModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(manzil.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<ManzilEntity>> getManzilWithEdition(int number, String edition) async {
    try {
      final response = await _api.getManzilWithEdition(number, edition);

      if (response.isSuccess && response.data != null) {
        final manzil = ManzilModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(manzil.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Ruku

  @override
  Future<ApiResponse<RukuEntity>> getRuku(int number) async {
    try {
      final response = await _api.getRuku(number);

      if (response.isSuccess && response.data != null) {
        final ruku = RukuModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(ruku.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<RukuEntity>> getRukuWithEdition(int number, String edition) async {
    try {
      final response = await _api.getRukuWithEdition(number, edition);

      if (response.isSuccess && response.data != null) {
        final ruku = RukuModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(ruku.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Sajda

  @override
  Future<ApiResponse<SajdaEntity>> getSajda() async {
    try {
      final response = await _api.getSajda();

      if (response.isSuccess && response.data != null) {
        final sajda = SajdaModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(sajda.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  @override
  Future<ApiResponse<SajdaEntity>> getSajdaWithEdition(String edition) async {
    try {
      final response = await _api.getSajdaWithEdition(edition);

      if (response.isSuccess && response.data != null) {
        final sajda = SajdaModel.fromJson(response.data as Map<String, dynamic>);
        return ApiResponse.success(sajda.toEntity());
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Meta

  @override
  Future<ApiResponse<Map<String, dynamic>>> getMeta() async {
    try {
      final response = await _api.getMeta();

      if (response.isSuccess && response.data != null) {
        final meta = response.data as Map<String, dynamic>;
        return ApiResponse.success(meta);
      } else {
        return ApiResponse.failure(
          response.status,
          response.code,
        );
      }
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  // Cache management

  @override
  Future<void> clearCache() async {
    await _cache.clearAll();
  }
}
