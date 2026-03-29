import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ourdeen/core/services/network/network_exceptions.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/models/base_response.dart';

/// HTTP client for Alquran.cloud API.
///
/// Provides methods to access all Alquran.cloud endpoints.
/// Base URL: https://api.alquran.cloud/v1
class AlquranCloudApi {
  final http.Client _client;
  final String baseUrl;

  AlquranCloudApi({
    http.Client? client,
    this.baseUrl = 'https://api.alquran.cloud/v1',
  }) : _client = client ?? http.Client();

  /// Generic GET request handler with error handling.
  Future<T> get<T>(
    String endpoint, {
    Map<String, String>? queryParams,
    required T Function(Map<String, dynamic>) onSuccess,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParams,
      );

      final response = await _client.get(
        uri,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return onSuccess(jsonData);
      } else {
        throw NetworkException.fromStatusCode(
          response.statusCode,
          'Request failed: ${response.statusCode}',
        );
      }
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw NetworkException.networkUnavailable('Network error: $e');
    }
  }

  // Edition endpoints

  /// GET /edition - Get all editions
  Future<BaseResponse> getEditions() async {
    return await get(
      '/edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /edition/language/{language} - Get editions by language
  Future<BaseResponse> getEditionsByLanguage(String language) async {
    return await get(
      '/edition/language/$language',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /edition/type/{type} - Get editions by type
  Future<BaseResponse> getEditionsByType(String type) async {
    return await get(
      '/edition/type/$type',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Quran endpoints

  /// GET /quran/{edition} - Get complete Quran
  Future<BaseResponse> getQuran(String edition) async {
    return await get(
      '/quran/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Surah endpoints

  /// GET /surah - Get all surahs
  Future<BaseResponse> getSurahs() async {
    return await get(
      '/surah',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /surah/{number} - Get specific surah
  Future<BaseResponse> getSurah(int number) async {
    return await get(
      '/surah/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /surah/{number}/editions/{editions} - Get surah with multiple editions
  /// editions should be comma-separated, e.g., 'quran-uthmani,en.sahih'
  Future<BaseResponse> getSurahWithEditions(int number, String editions) async {
    return await get(
      '/surah/$number/editions/$editions',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Ayah endpoints

  /// GET /ayah/{number} - Get specific ayah
  /// number can be global ayah number or 'surah:ayah' format
  Future<BaseResponse> getAyah(String reference) async {
    return await get(
      '/ayah/$reference',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /ayah/{number}/editions/{editions} - Get ayah with multiple editions
  Future<BaseResponse> getAyahWithEditions(String reference, String editions) async {
    return await get(
      '/ayah/$reference/editions/$editions',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Search endpoint

  /// GET /search/{keyword}/{surah}/{edition} - Search Quran
  /// surah can be 'all' or a specific surah number
  Future<BaseResponse> search(String keyword, String surah, String edition) async {
    return await get(
      '/search/$keyword/$surah/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Juz endpoint

  /// GET /juz/{number} - Get specific juz
  Future<BaseResponse> getJuz(int number) async {
    return await get(
      '/juz/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /juz/{number}/{edition} - Get specific juz with edition
  Future<BaseResponse> getJuzWithEdition(int number, String edition) async {
    return await get(
      '/juz/$number/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Page endpoint

  /// GET /page/{number} - Get specific page
  Future<BaseResponse> getPage(int number) async {
    return await get(
      '/page/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /page/{number}/{edition} - Get specific page with edition
  Future<BaseResponse> getPageWithEdition(int number, String edition) async {
    return await get(
      '/page/$number/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Hizb endpoint

  /// GET /hizb/{number} - Get specific hizb quarter
  Future<BaseResponse> getHizb(int number) async {
    return await get(
      '/hizb/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /hizb/{number}/{edition} - Get specific hizb quarter with edition
  Future<BaseResponse> getHizbWithEdition(int number, String edition) async {
    return await get(
      '/hizb/$number/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Manzil endpoint

  /// GET /manzil/{number} - Get specific manzil
  Future<BaseResponse> getManzil(int number) async {
    return await get(
      '/manzil/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /manzil/{number}/{edition} - Get specific manzil with edition
  Future<BaseResponse> getManzilWithEdition(int number, String edition) async {
    return await get(
      '/manzil/$number/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Ruku endpoint

  /// GET /ruku/{number} - Get specific ruku
  Future<BaseResponse> getRuku(int number) async {
    return await get(
      '/ruku/$number',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /ruku/{number}/{edition} - Get specific ruku with edition
  Future<BaseResponse> getRukuWithEdition(int number, String edition) async {
    return await get(
      '/ruku/$number/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Sajda endpoint

  /// GET /sajda - Get all sajda ayahs
  Future<BaseResponse> getSajda() async {
    return await get(
      '/sajda',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  /// GET /sajda/{edition} - Get all sajda ayahs with edition
  Future<BaseResponse> getSajdaWithEdition(String edition) async {
    return await get(
      '/sajda/$edition',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }

  // Meta endpoint

  /// GET /meta - Get meta data about surahs, pages, hizbs and juzs
  Future<BaseResponse> getMeta() async {
    return await get(
      '/meta',
      onSuccess: (data) => BaseResponse.fromJson(data, (json) => json),
    );
  }
}
