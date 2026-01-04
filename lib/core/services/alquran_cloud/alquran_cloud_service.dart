import 'package:ourdeen/core/services/alquran_cloud/domain/repositories/alquran_cloud_repository.dart';
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

/// Facade service for easy access to Alquran.cloud API.
///
/// Provides a simplified interface for features to use,
/// with convenient methods for common operations.
class AlquranCloudService {
  final AlquranCloudRepository _repository;

  AlquranCloudService(this._repository);

  // Edition

  Future<ApiResponse<List<EditionEntity>>> getEditions() => _repository.getEditions();

  Future<ApiResponse<List<EditionEntity>>> getArabicEditions() =>
      _repository.getEditionsByLanguage('ar');

  Future<ApiResponse<List<EditionEntity>>> getEnglishEditions() =>
      _repository.getEditionsByLanguage('en');

  Future<ApiResponse<List<EditionEntity>>> getTranslations() =>
      _repository.getEditionsByType('translation');

  Future<ApiResponse<List<EditionEntity>>> getTafsirs() =>
      _repository.getEditionsByType('tafsir');

  Future<ApiResponse<List<EditionEntity>>> getAudioEditions() =>
      _repository.getEditionsByType('audio');

  // Quran

  Future<ApiResponse<QuranEntity>> getQuran([String edition = 'quran-uthmani']) =>
      _repository.getQuran(edition);

  // Surah

  Future<ApiResponse<List<SurahEntity>>> getSurahs() => _repository.getSurahs();

  Future<ApiResponse<SurahEntity>> getSurah(int number) => _repository.getSurah(number);

  Future<ApiResponse<SurahEntity>> getSurahWithTranslation(
    int number, [
    String translationEdition = 'en.sahih',
  ]) =>
      _repository.getSurahWithEditions(number, ['quran-uthmani', translationEdition]);

  Future<ApiResponse<SurahEntity>> getSurahWithMultipleTranslations(
    int number,
    List<String> translations,
  ) =>
      _repository.getSurahWithEditions(number, ['quran-uthmani', ...translations]);

  // Ayah

  Future<ApiResponse<AyahEntity>> getAyah(String reference) => _repository.getAyah(reference);

  Future<ApiResponse<AyahEntity>> getAyahWithTranslation(
    String reference, [
    String translationEdition = 'en.sahih',
  ]) async {
    final response = await _repository.getAyahWithEditions(
      reference,
      ['quran-uthmani', translationEdition],
    );
    if (response.success && response.data != null && response.data!.isNotEmpty) {
      return ApiResponse.success(response.data!.first, response.statusCode ?? 200);
    }
    return ApiResponse.failure(response.error ?? 'Failed to get ayah', response.statusCode ?? 500);
  }

  /// Convenience method for getting ayah by surah and ayah numbers.
  Future<ApiResponse<AyahEntity>> getAyahBySurah(int surahNumber, int ayahNumber) =>
      _repository.getAyah('$surahNumber:$ayahNumber');

  /// Convenience method for getting ayah by global number.
  Future<ApiResponse<AyahEntity>> getAyahByNumber(int number) =>
      _repository.getAyah('$number');

  // Search

  Future<ApiResponse<SearchResultEntity>> searchInQuran(
    String keyword, {
    int? surahNumber,
    String edition = 'en.sahih',
  }) =>
      _repository.search(keyword, surahNumber?.toString(), edition);

  Future<ApiResponse<SearchResultEntity>> searchInSurah(
    String keyword,
    int surahNumber, [
    String edition = 'en.sahih',
  ]) =>
      _repository.search(keyword, surahNumber.toString(), edition);

  // Juz

  Future<ApiResponse<JuzEntity>> getJuz(int number, [String edition = 'quran-uthmani']) =>
      _repository.getJuzWithEdition(number, edition);

  // Page

  Future<ApiResponse<PageEntity>> getPage(int number, [String edition = 'quran-uthmani']) =>
      _repository.getPageWithEdition(number, edition);

  // Hizb

  Future<ApiResponse<HizbEntity>> getHizb(int number, [String edition = 'quran-uthmani']) =>
      _repository.getHizbWithEdition(number, edition);

  // Manzil

  Future<ApiResponse<ManzilEntity>> getManzil(int number, [String edition = 'quran-uthmani']) =>
      _repository.getManzilWithEdition(number, edition);

  // Ruku

  Future<ApiResponse<RukuEntity>> getRuku(int number, [String edition = 'quran-uthmani']) =>
      _repository.getRukuWithEdition(number, edition);

  // Sajda

  Future<ApiResponse<SajdaEntity>> getSajda([String edition = 'quran-uthmani']) =>
      _repository.getSajdaWithEdition(edition);

  // Meta

  Future<ApiResponse<Map<String, dynamic>>> getMeta() => _repository.getMeta();

  // Cache

  Future<void> clearCache() => _repository.clearCache();
}
