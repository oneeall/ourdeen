import 'dart:collection';

import '../entities/memorization_session.dart';

abstract class MemorizationRepository {
  Future<UnmodifiableListView<MemorizationSession>> getSessions();
  Future<MemorizationSession> createSession(int surahNumber, int startVerse, int endVerse);
  Future<MemorizationSession> updateSessionProgress(int sessionId, double progress);
  Future<MemorizationSession> updateSessionStreak(int sessionId);
  Future<void> deleteSession(int sessionId);
}