import '../../domain/entities/quran_verse.dart';
import '../../domain/repositories/quran_repository.dart';

class QuranRepositoryImpl implements QuranRepository {
  @override
  Future<List<QuranVerse>> getVerses(int surahNumber, int startVerse, int endVerse) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // For now, only supporting Surah Al-Fatihah (QS 1)
    if (surahNumber == 1 && startVerse == 1 && endVerse == 7) {
      return [
        QuranVerse(
          surahNumber: 1,
          verseNumber: 1,
          arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          translation: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 2,
          arabicText: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
          translation: '[All] praise is [due] to Allah, Lord of the worlds -',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 3,
          arabicText: 'الرَّحْمَٰنِ الرَّحِيمِ',
          translation: 'The Entirely Merciful, the Especially Merciful,',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 4,
          arabicText: 'مَالِكِ يَوْمِ الدِّينِ',
          translation: 'Sovereign of the Day of Recompense.',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 5,
          arabicText: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
          translation: 'It is You we worship and You we ask for help.',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 6,
          arabicText: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
          translation: 'Guide us to the straight path -',
        ),
        QuranVerse(
          surahNumber: 1,
          verseNumber: 7,
          arabicText: 'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
          translation: 'The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.',
        ),
      ];
    }
    
    // Return empty list for unsupported requests
    return [];
  }
}