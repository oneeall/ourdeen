import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ourdeen/core/services/alquran_cloud/alquran_cloud_service.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/repositories/alquran_cloud_repository_impl.dart';
import 'package:ourdeen/core/services/alquran_cloud/data/datasources/alquran_cloud_api.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/surah_entity.dart';

void main() {
  late AlquranCloudService service;

  setUpAll(() async {
    // Set up mock SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});

    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Create real API client (makes actual network calls)
    final api = AlquranCloudApi();

    // Create repository with real API
    final repository = AlquranCloudRepositoryImpl(
      api: api,
      prefs: prefs,
    );

    // Create service with repository
    service = AlquranCloudService(repository);

    // Clear cache to ensure fresh network calls
    await service.clearCache();
  });

  group('AlquranCloudService - getSurahs', () {
    test('should return list of 114 surahs', () async {
      final response = await service.getSurahs();

      expect(response.success, isTrue);
      expect(response.data, isNotNull);
      expect(response.data!.length, 114);

      // Verify first surah (Al-Fatihah)
      final firstSurah = response.data!.first;
      expect(firstSurah.number, 1);
      expect(firstSurah.englishName, 'Al-Faatiha');
      expect(firstSurah.englishNameTranslation, 'The Opening');
      expect(firstSurah.revelationType, 'Meccan');
      expect(firstSurah.numberOfAyahs, 7);

      // Verify last surah (An-Nas)
      final lastSurah = response.data!.last;
      expect(lastSurah.number, 114);
      expect(lastSurah.englishName, 'An-Naas');
    });

    test('should return surahs in correct order', () async {
      final response = await service.getSurahs();

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      for (int i = 0; i < response.data!.length; i++) {
        expect(response.data![i].number, i + 1);
      }
    });

    test('should have correct surah names for common surahs', () async {
      final response = await service.getSurahs();

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final surahMap = {
        for (var surah in response.data!) surah.number: surah,
      };

      // Al-Fatihah (1) - API returns 'Al-Faatiha'
      expect(surahMap[1]!.englishName, 'Al-Faatiha');

      // Al-Baqarah (2)
      expect(surahMap[2]!.englishName, 'Al-Baqara');
      expect(surahMap[2]!.numberOfAyahs, 286);

      // Al-Ikhlas (112)
      expect(surahMap[112]!.englishName, 'Al-Ikhlaas');
      expect(surahMap[112]!.numberOfAyahs, 4);

      // Al-Falaq (113)
      expect(surahMap[113]!.englishName, 'Al-Falaq');

      // An-Nas (114)
      expect(surahMap[114]!.englishName, 'An-Naas');
    });
  });

  group('AlquranCloudService - getSurah(1)', () {
    test('should return Surah Al-Fatihah with correct metadata', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final surah = response.data!;
      expect(surah.number, 1);
      expect(surah.englishName, 'Al-Faatiha');
      expect(surah.englishNameTranslation, 'The Opening');
      expect(surah.revelationType, 'Meccan');
      expect(surah.numberOfAyahs, 7);
    });

    test('should return Surah Al-Fatihah with 7 ayahs', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final surah = response.data!;
      expect(surah.ayahs, isNotNull);
      expect(surah.ayahs!.length, 7);

      // Verify each ayah has required fields
      for (final ayah in surah.ayahs!) {
        expect(ayah.number, greaterThan(0));
        expect(ayah.text, isNotEmpty);
      }
    });

    test('should have correct ayah numbers for Al-Fatihah', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final surah = response.data!;
      final ayahs = surah.ayahs;
      expect(ayahs, isNotNull);
      expect(ayahs!.length, 7);

      // Verify ayah numbers are sequential
      for (int i = 0; i < ayahs.length; i++) {
        expect(ayahs[i].numberInSurah, i + 1);
      }
    });

    test('first ayah should be number 1 with Basmala text', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final ayahs = response.data!.ayahs;
      expect(ayahs, isNotNull);
      expect(ayahs!.isNotEmpty, isTrue);

      final firstAyah = ayahs.first;
      expect(firstAyah.numberInSurah, 1);
      expect(firstAyah.text, isNotEmpty);
      // Basmala starts with "بسم"
      expect(firstAyah.text, startsWith('ب'));
    });

    test('ayahs should have valid reference format', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final ayahs = response.data!.ayahs;
      expect(ayahs, isNotNull);

      for (final ayah in ayahs!) {
        expect(ayah.numberInSurah, greaterThan(0));
        expect(ayah.number, greaterThan(0));
      }
    });

    test('ayah surahAyahReference should return correct format', () async {
      final response = await service.getSurah(1);

      expect(response.success, isTrue);
      expect(response.data, isNotNull);

      final ayahs = response.data!.ayahs;
      expect(ayahs, isNotNull);

      for (final ayah in ayahs!) {
        final reference = ayah.surahAyahReference;
        // Reference should be the ayah number (global number) since surahNumber is null
        expect(reference, isNotEmpty);
      }
    });
  });
}
