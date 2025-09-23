import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../entities/memorization_session.dart';

abstract class MemorizationRepository {
  Future<IList<MemorizationSession>> getSessions();
  Future<MemorizationSession> createSession(int surahNumber, int startVerse, int endVerse);
  Future<MemorizationSession> updateSessionProgress(int sessionId, double progress);
  Future<MemorizationSession> updateSessionStreak(int sessionId);
  Future<void> deleteSession(int sessionId);
}

class MemorizationRepositoryLocalImp implements MemorizationRepository {
  @override
  Future<MemorizationSession> createSession(int surahNumber, int startVerse, int endVerse) {
    // TODO: implement createSession
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSession(int sessionId) {
    // TODO: implement deleteSession
    throw UnimplementedError();
  }

  @override
  Future<IList<MemorizationSession>> getSessions() {
    // TODO: implement getSessions
    throw UnimplementedError();
  }

  @override
  Future<MemorizationSession> updateSessionProgress(int sessionId, double progress) {
    // TODO: implement updateSessionProgress
    throw UnimplementedError();
  }

  @override
  Future<MemorizationSession> updateSessionStreak(int sessionId) {
    // TODO: implement updateSessionStreak
    throw UnimplementedError();
  }

}