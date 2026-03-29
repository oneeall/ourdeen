import 'package:flutter/cupertino.dart';

class MemorizationVerseViewModel extends ChangeNotifier {
  List<String> verses, translationVerses;
  VoidCallback onVerseDone, onFullScreen;

  MemorizationVerseViewModel({
    required this.verses,
    required this.translationVerses,
    required this.onVerseDone,
    required this.onFullScreen,
  });

  int _currentVerseIndex = 0;

  int get currentVerseIndex => _currentVerseIndex;

  String _textVerse = '';

  String get textVerse => _textVerse;

  String _translationVerse = '';

  String get translationVerse => _translationVerse;

  void changeVerse() {
    _textVerse = verses[_currentVerseIndex];
    _translationVerse = translationVerses[_currentVerseIndex];
    notifyListeners();
  }

  void nextVerse() {
    if (_currentVerseIndex < verses.length - 1) {
      _currentVerseIndex++;
      changeVerse();
    } else {
      /// when the verse index exceeds the total number of verses, the [onDoneVerse] callback will be triggered
      onVerseDone();
    }
  }

  void previousVerse() {
    if (_currentVerseIndex != 0) {
      _currentVerseIndex--;
      changeVerse();
    } else {
      debugPrint('First verse');
    }
  }
}
