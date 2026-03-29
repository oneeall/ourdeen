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
import 'package:ourdeen/features/tajweed/presentation/viewmodels/tajweed_viewmodel.dart';

/// Facade service for easy access to Alquran.cloud API.
///
/// Provides a simplified interface for features to use,
/// with convenient methods for common operations.
///
/// When [tajweedViewModel] is provided, automatically uses
/// 'quran-tajweed' edition when Tajweed mode is enabled.
class AlquranCloudService {
  final AlquranCloudRepository _repository;
  final TajweedViewModel? _tajweedViewModel;

  AlquranCloudService(this._repository, {TajweedViewModel? tajweedViewModel})
      : _tajweedViewModel = tajweedViewModel;

  /// Get the Arabic edition identifier based on current Tajweed setting
  ///
  /// When Tajweed is enabled, returns 'quran-tajweed' which contains
  /// color-coded Tajweed rules. Otherwise returns 'quran-uthmani'.
  String get _arabicEdition => _tajweedViewModel?.arabicEdition ?? 'quran-uthmani';

  /// Public getter for the current Arabic edition
  /// Allows ViewModels to access the dynamically determined Arabic edition
  String get currentArabicEdition => _arabicEdition;

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

  Future<ApiResponse<QuranEntity>> getQuran([String? edition]) =>
      _repository.getQuran(edition ?? _arabicEdition);

  // Surah

  Future<ApiResponse<List<SurahEntity>>> getSurahs() => _repository.getSurahs();

  Future<ApiResponse<SurahEntity>> getSurah(int number) => _repository.getSurah(number);

  Future<ApiResponse<SurahEntity>> getSurahWithTranslation(
    int number, [
    String translationEdition = 'en.sahih',
  ]) =>
      _repository.getSurahWithEditions(number, [_arabicEdition, translationEdition]);

  Future<ApiResponse<SurahEntity>> getSurahWithMultipleTranslations(
    int number,
    List<String> translations,
  ) =>
      _repository.getSurahWithEditions(number, [_arabicEdition, ...translations]);

  Future<ApiResponse<List<SurahEntity>>> getSurahWithMultipleEditions(
    int number,
    List<String> editions,
  ) =>
      _repository.getSurahWithMultipleEditions(number, editions);

  // Ayah

  Future<ApiResponse<AyahEntity>> getAyah(String reference) => _repository.getAyah(reference);

  Future<ApiResponse<AyahEntity>> getAyahWithTranslation(
    String reference, [
    String translationEdition = 'en.sahih',
  ]) async {
    final response = await _repository.getAyahWithEditions(
      reference,
      [_arabicEdition, translationEdition],
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

  Future<ApiResponse<JuzEntity>> getJuz(int number, [String? edition]) =>
      _repository.getJuzWithEdition(number, edition ?? _arabicEdition);

  // Page

  Future<ApiResponse<PageEntity>> getPage(int number, [String? edition]) =>
      _repository.getPageWithEdition(number, edition ?? _arabicEdition);

  // Hizb

  Future<ApiResponse<HizbEntity>> getHizb(int number, [String? edition]) =>
      _repository.getHizbWithEdition(number, edition ?? _arabicEdition);

  // Manzil

  Future<ApiResponse<ManzilEntity>> getManzil(int number, [String? edition]) =>
      _repository.getManzilWithEdition(number, edition ?? _arabicEdition);

  // Ruku

  Future<ApiResponse<RukuEntity>> getRuku(int number, [String? edition]) =>
      _repository.getRukuWithEdition(number, edition ?? _arabicEdition);

  // Sajda

  Future<ApiResponse<SajdaEntity>> getSajda([String? edition]) =>
      _repository.getSajdaWithEdition(edition ?? _arabicEdition);

  // Meta

  Future<ApiResponse<Map<String, dynamic>>> getMeta() => _repository.getMeta();

  // Cache

  Future<void> clearCache() => _repository.clearCache();
}
