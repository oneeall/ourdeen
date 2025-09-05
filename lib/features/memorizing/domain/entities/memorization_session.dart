class MemorizationSession {
  final int id;
  final int surahNumber;
  final int startVerse;
  final int endVerse;
  final DateTime createdAt;
  final DateTime lastPracticed;
  final int streak;
  final double progress;

  MemorizationSession({
    required this.id,
    required this.surahNumber,
    required this.startVerse,
    required this.endVerse,
    required this.createdAt,
    required this.lastPracticed,
    required this.streak,
    required this.progress,
  });
}