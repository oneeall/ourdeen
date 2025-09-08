import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../domain/entities/memorization_session.dart';
import '../../domain/repositories/memorization_repository.dart';

class MemorizationRepositoryImpl implements MemorizationRepository {
  // In a real app, this would be stored in a database or fetched from an API

  IList<MemorizationSession> _sessions = [
    MemorizationSession(
      id: 1,
      surahNumber: 1,
      startVerse: 1,
      endVerse: 7,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastPracticed: DateTime.now().subtract(const Duration(days: 1)),
      streak: 3,
      progress: 0.8,
    ),
    MemorizationSession(
      id: 2,
      surahNumber: 112,
      startVerse: 1,
      endVerse: 4,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      lastPracticed: DateTime.now().subtract(const Duration(days: 2)),
      streak: 5,
      progress: 1.0,
    ),
    MemorizationSession(
      id: 3,
      surahNumber: 48,
      startVerse: 1,
      endVerse: 3,
      createdAt: DateTime.now().subtract(const Duration(days: 2,)),
      lastPracticed: DateTime.now().subtract(const Duration(days: 1,)),
      streak: 0,
      progress: 0.0,
    )
  ].toIList();

  @override
  Future<IList<MemorizationSession>> getSessions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _sessions;
  }

  @override
  Future<MemorizationSession> createSession(
    int surahNumber,
    int startVerse,
    int endVerse,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final newSession = MemorizationSession(
      id: _sessions.length + 1,
      surahNumber: surahNumber,
      startVerse: startVerse,
      endVerse: endVerse,
      createdAt: DateTime.now(),
      lastPracticed: DateTime.now(),
      streak: 0,
      progress: 0.0,
    );

    _sessions = [..._sessions, newSession].toIList();
    _sessions.add(newSession);
    return newSession;
  }

  @override
  Future<MemorizationSession> updateSessionProgress(
    int sessionId,
    double progress,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _sessions.indexWhere((session) => session.id == sessionId);
    if (index != -1) {
      final session = _sessions[index];

      // _sessions[index] = MemorizationSession(
      //   id: session.id,
      //   surahNumber: session.surahNumber,
      //   startVerse: session.startVerse,
      //   endVerse: session.endVerse,
      //   createdAt: session.createdAt,
      //   lastPracticed: DateTime.now(),
      //   streak: session.streak,
      //   progress: progress,
      // );
      _sessions = _sessions.map(
        (e) => e.id == session.id
            ? MemorizationSession(
                id: session.id,
                surahNumber: session.surahNumber,
                startVerse: session.startVerse,
                endVerse: session.endVerse,
                createdAt: session.createdAt,
                lastPracticed: DateTime.now(),
                streak: session.streak,
                progress: progress,
              )
            : e,
      ).toIList();

      return _sessions[index];
    }

    throw Exception('Session not found');
  }

  @override
  Future<MemorizationSession> updateSessionStreak(int sessionId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _sessions.indexWhere((session) => session.id == sessionId);
    if (index != -1) {
      final session = _sessions[index];
      // _sessions[index] = MemorizationSession(
      //   id: session.id,
      //   surahNumber: session.surahNumber,
      //   startVerse: session.startVerse,
      //   endVerse: session.endVerse,
      //   createdAt: session.createdAt,
      //   lastPracticed: DateTime.now(),
      //   streak: session.streak + 1,
      //   progress: session.progress,
      // );
      _sessions = _sessions.map(
        (e) => e.id == session.id
            ? MemorizationSession(
                id: session.id,
                surahNumber: session.surahNumber,
                startVerse: session.startVerse,
                endVerse: session.endVerse,
                createdAt: session.createdAt,
                lastPracticed: DateTime.now(),
                streak: session.streak + 1,
                progress: session.progress,
              )
            : e,
      ).toIList();
      return _sessions[index];
    }

    throw Exception('Session not found');
  }

  @override
  Future<void> deleteSession(int sessionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var removedList = _sessions.removeWhere((session) => session.id == sessionId);
    _sessions = removedList.toIList();
  }
}
