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

/// Repository interface for Alquran.cloud API.
///
/// Provides methods to access all Alquran.cloud endpoints with caching support.
abstract class AlquranCloudRepository {
  // Edition endpoints

  Future<ApiResponse<List<EditionEntity>>> getEditions();

  Future<ApiResponse<List<EditionEntity>>> getEditionsByLanguage(String language);

  Future<ApiResponse<List<EditionEntity>>> getEditionsByType(String type);

  // Quran endpoints

  Future<ApiResponse<QuranEntity>> getQuran(String edition);

  // Surah endpoints

  Future<ApiResponse<List<SurahEntity>>> getSurahs();

  Future<ApiResponse<SurahEntity>> getSurah(int number);

  Future<ApiResponse<SurahEntity>> getSurahWithEditions(
    int number,
    List<String> editions,
  );

  Future<ApiResponse<List<SurahEntity>>> getSurahWithMultipleEditions(
    int number,
    List<String> editions,
  );

  // Ayah endpoints

  Future<ApiResponse<AyahEntity>> getAyah(String reference);

  Future<ApiResponse<List<AyahEntity>>> getAyahWithEditions(
    String reference,
    List<String> editions,
  );

  // Search

  Future<ApiResponse<SearchResultEntity>> search(
    String keyword,
    String? surah,
    String edition,
  );

  // Juz

  Future<ApiResponse<JuzEntity>> getJuz(int number);

  Future<ApiResponse<JuzEntity>> getJuzWithEdition(int number, String edition);

  // Page

  Future<ApiResponse<PageEntity>> getPage(int number);

  Future<ApiResponse<PageEntity>> getPageWithEdition(int number, String edition);

  // Hizb

  Future<ApiResponse<HizbEntity>> getHizb(int number);

  Future<ApiResponse<HizbEntity>> getHizbWithEdition(int number, String edition);

  // Manzil

  Future<ApiResponse<ManzilEntity>> getManzil(int number);

  Future<ApiResponse<ManzilEntity>> getManzilWithEdition(int number, String edition);

  // Ruku

  Future<ApiResponse<RukuEntity>> getRuku(int number);

  Future<ApiResponse<RukuEntity>> getRukuWithEdition(int number, String edition);

  // Sajda

  Future<ApiResponse<SajdaEntity>> getSajda();

  Future<ApiResponse<SajdaEntity>> getSajdaWithEdition(String edition);

  // Meta

  Future<ApiResponse<Map<String, dynamic>>> getMeta();

  // Cache management

  Future<void> clearCache();
}
