import 'package:flutter/foundation.dart';
import 'package:ourdeen/core/services/alquran_cloud/alquran_cloud_service.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/surah_entity.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/core/services/network/api_response.dart';
import 'package:ourdeen/features/shared/base_viewmodel.dart';

/// Display model for a verse with Arabic text and translation.
class VerseDisplay {
  final int number;
  final int numberInSurah;
  final String arabicText;
  final String? translation;
  final String? editionName;

  const VerseDisplay({
    required this.number,
    required this.numberInSurah,
    required this.arabicText,
    this.translation,
    this.editionName,
  });
}

class QuranReaderViewModel extends BaseViewModel {
  final AlquranCloudService _alquranCloudService;

  // Surah info
  SurahEntity? _surah;
  SurahEntity? get surah => _surah;

  String _surahName = '';
  String get surahName => _surahName;

  // Verses display
  List<VerseDisplay> _verses = [];
  List<VerseDisplay> get verses => _verses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  EditionEntity? _translationEdition;
  EditionEntity? get translationEdition => _translationEdition;

  QuranReaderViewModel(this._alquranCloudService);

  /// Load a specific surah with optional translation edition.
  Future<void> loadSurah(
    int surahNumber, [
    EditionEntity? translationEdition,
  ]) async {
    _isLoading = true;
    _errorMessage = null;
    _translationEdition = translationEdition;
    notifyListeners();

    try {
      if (translationEdition != null) {
        // Fetch with Arabic and translation - uses dynamic Tajweed-aware edition
        final response = await _alquranCloudService.getSurahWithMultipleEditions(
          surahNumber,
          [_alquranCloudService.currentArabicEdition, translationEdition.identifier],
        );

        if (response.success && response.data != null) {
          final surahs = response.data!;
          if (surahs.isNotEmpty) {
            _surah = surahs.first;
            _surahName = _surah!.englishName;
            // Convert to display verses with translation
            _verses = _convertToDisplayVersesWithTranslation(surahs);
          } else {
            throw Exception('No surahs found');
          }
        } else {
          throw Exception(response.error ?? 'Failed to load surah');
        }
      } else {
        // Fetch only Arabic
        final response = await _alquranCloudService.getSurah(surahNumber);

        if (response.success && response.data != null) {
          final surahEntity = response.data!;
          _surah = surahEntity;
          _surahName = surahEntity.englishName;
          _verses = _convertToDisplayVerses(surahEntity);
        } else {
          throw Exception(response.error ?? 'Failed to load surah');
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Error loading surah: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Convert surah entities to display verses with translations.
  List<VerseDisplay> _convertToDisplayVersesWithTranslation(
    List<SurahEntity> surahs,
  ) {
    if (surahs.isEmpty) {
      return [];
    }

    // First surah should be Arabic
    final arabicSurah = surahs.first;
    final arabicAyahs = arabicSurah.ayahs;

    if (arabicAyahs == null || arabicAyahs.isEmpty) {
      return [];
    }

    // If we have a second surah (translation), match up the ayahs
    if (surahs.length > 1) {
      final translationSurah = surahs[1];
      final translationAyahs = translationSurah.ayahs;

      // Create a map of translation ayahs by numberInSurah for quick lookup
      final translationMap = <int, String>{};
      if (translationAyahs != null) {
        for (final ayah in translationAyahs) {
          final numberInSurah = ayah.numberInSurah;
          if (numberInSurah != null) {
            translationMap[numberInSurah] = ayah.text;
          }
        }
      }

      // Pair up Arabic with translation
      return arabicAyahs.map((arabicAyah) {
        final numberInSurah = arabicAyah.numberInSurah ?? 1;
        return VerseDisplay(
          number: arabicAyah.number,
          numberInSurah: numberInSurah,
          arabicText: arabicAyah.text,
          translation: translationMap[numberInSurah],
          editionName: translationSurah.englishName,
        );
      }).toList();
    }

    // No translation, just Arabic
    return arabicAyahs.map((ayah) {
      return VerseDisplay(
        number: ayah.number,
        numberInSurah: ayah.numberInSurah ?? 1,
        arabicText: ayah.text,
        translation: null,
        editionName: null,
      );
    }).toList();
  }

  /// Convert a single surah to display verses (Arabic only).
  List<VerseDisplay> _convertToDisplayVerses(SurahEntity surah) {
    final ayahs = surah.ayahs;

    if (ayahs == null || ayahs.isEmpty) {
      return [];
    }

    return ayahs.map((ayah) {
      return VerseDisplay(
        number: ayah.number,
        numberInSurah: ayah.numberInSurah ?? 1,
        arabicText: ayah.text,
        translation: null,
        editionName: null,
      );
    }).toList();
  }

  /// Load verses for backward compatibility.
  Future<void> loadVerses({int surahNumber = 1}) async {
    await loadSurah(surahNumber);
  }
}
