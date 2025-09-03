import '../entities/quran_verse.dart';
import '../repositories/quran_repository.dart';

class GetVersesUseCase {
  final QuranRepository _quranRepository;

  GetVersesUseCase(this._quranRepository);

  Future<List<QuranVerse>> call(int surahNumber, int startVerse, int endVerse) {
    return _quranRepository.getVerses(surahNumber, startVerse, endVerse);
  }
}