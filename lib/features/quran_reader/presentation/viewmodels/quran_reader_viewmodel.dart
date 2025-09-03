import 'package:flutter/foundation.dart';
import 'package:ourdeen/features/shared/base_viewmodel.dart';
import '../../domain/entities/quran_verse.dart';
import '../../domain/usecases/get_verses_usecase.dart';

class QuranReaderViewModel extends BaseViewModel {
  final GetVersesUseCase _getVersesUseCase;

  List<QuranVerse> _verses = [];
  List<QuranVerse> get verses => _verses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  QuranReaderViewModel(this._getVersesUseCase);

  Future<void> loadVerses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _verses = await _getVersesUseCase(1, 1, 7); // Load Surah Al-Fatihah
    } catch (e) {
      // Handle error appropriately in a real app
      if (kDebugMode) {
        print('Error loading verses: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
