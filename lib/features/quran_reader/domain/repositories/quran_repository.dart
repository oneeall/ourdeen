import '../entities/quran_verse.dart';

abstract class QuranRepository {
  Future<List<QuranVerse>> getVerses(int surahNumber, int startVerse, int endVerse);
}