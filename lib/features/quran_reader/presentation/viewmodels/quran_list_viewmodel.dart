import 'package:flutter/foundation.dart';
import 'package:ourdeen/core/services/alquran_cloud/alquran_cloud_service.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/features/shared/base_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/domain/entities/surah_list_item.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/get_surahs_list_usecase.dart';

class QuranListViewModel extends BaseViewModel {
  final GetSurahsListUseCase _getSurahsListUseCase;
  final AlquranCloudService _alquranCloudService;

  List<SurahListItem> _surahs = [];
  List<SurahListItem> get surahs => _surahs;

  List<EditionEntity> _editions = [];
  List<EditionEntity> get editions => _editions;

  EditionEntity? _selectedEdition;
  EditionEntity? get selectedEdition => _selectedEdition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  QuranListViewModel(
    this._getSurahsListUseCase,
    this._alquranCloudService,
  );

  /// Initialize the view model by loading surahs and editions.
  Future<void> initialize() async {
    await loadSurahs();
    await loadEditions();
  }

  /// Load the list of all surahs.
  Future<void> loadSurahs() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _surahs = await _getSurahsListUseCase();
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Error loading surahs: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Load available translation editions.
  Future<void> loadEditions() async {
    try {
      final response = await _alquranCloudService.getEditions();
      if (response.success && response.data != null) {
        // Filter only translation editions
        _editions = response.data!
            .where((edition) =>
                edition.type == 'translation' && edition.format == 'text')
            .toList();

        // Set default to Indonesian if available, otherwise English
        if (_editions.any((e) => e.language == 'id')) {
          _selectedEdition = _editions.firstWhere((e) => e.language == 'id');
        } else if (_editions.any((e) => e.language == 'en')) {
          _selectedEdition = _editions.firstWhere((e) => e.language == 'en');
        } else if (_editions.isNotEmpty) {
          _selectedEdition = _editions.first;
        }
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading editions: $e');
      }
    }
  }

  /// Set the selected edition for translations.
  void setSelectedEdition(EditionEntity edition) {
    if (_selectedEdition?.identifier != edition.identifier) {
      _selectedEdition = edition;
      notifyListeners();
    }
  }

  /// Get surahs filtered by search query.
  List<SurahListItem> getFilteredSurahs(String query) {
    if (query.isEmpty) return _surahs;

    final lowerQuery = query.toLowerCase();
    return _surahs.where((surah) {
      return surah.name.toLowerCase().contains(lowerQuery) ||
          surah.englishName.toLowerCase().contains(lowerQuery) ||
          surah.englishNameTranslation.toLowerCase().contains(lowerQuery) ||
          surah.number.toString().contains(lowerQuery);
    }).toList();
  }
}
