import 'dart:collection';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../entities/memorization_session.dart';

abstract class MemorizationRepository {
  Future<IList<MemorizationSession>> getSessions();
  Future<MemorizationSession> createSession(int surahNumber, int startVerse, int endVerse);
  Future<MemorizationSession> updateSessionProgress(int sessionId, double progress);
  Future<MemorizationSession> updateSessionStreak(int sessionId);
  Future<void> deleteSession(int sessionId);
}