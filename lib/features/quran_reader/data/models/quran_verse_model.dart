class QuranVerseModel {
  final int surahNumber;
  final int verseNumber;
  final String arabicText;
  final String translation;

  QuranVerseModel({
    required this.surahNumber,
    required this.verseNumber,
    required this.arabicText,
    required this.translation,
  });

  factory QuranVerseModel.fromJson(Map<String, dynamic> json) {
    return QuranVerseModel(
      surahNumber: json['surah_number'] as int,
      verseNumber: json['verse_number'] as int,
      arabicText: json['arabic_text'] as String,
      translation: json['translation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surah_number': surahNumber,
      'verse_number': verseNumber,
      'arabic_text': arabicText,
      'translation': translation,
    };
  }
}