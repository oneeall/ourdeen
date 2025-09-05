class MemorizationSessionModel {
  final int id;
  final int surahNumber;
  final int startVerse;
  final int endVerse;
  final DateTime createdAt;
  final DateTime lastPracticed;
  final int streak;
  final double progress;

  MemorizationSessionModel({
    required this.id,
    required this.surahNumber,
    required this.startVerse,
    required this.endVerse,
    required this.createdAt,
    required this.lastPracticed,
    required this.streak,
    required this.progress,
  });

  factory MemorizationSessionModel.fromJson(Map<String, dynamic> json) {
    return MemorizationSessionModel(
      id: json['id'] as int,
      surahNumber: json['surah_number'] as int,
      startVerse: json['start_verse'] as int,
      endVerse: json['end_verse'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastPracticed: DateTime.parse(json['last_practiced'] as String),
      streak: json['streak'] as int,
      progress: (json['progress'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surah_number': surahNumber,
      'start_verse': startVerse,
      'end_verse': endVerse,
      'created_at': createdAt.toIso8601String(),
      'last_practiced': lastPracticed.toIso8601String(),
      'streak': streak,
      'progress': progress,
    };
  }
}