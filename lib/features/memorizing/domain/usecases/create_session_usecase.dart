import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class CreateSessionUseCase {
  final MemorizationRepository _memorizationRepository;

  CreateSessionUseCase(this._memorizationRepository);

  Future<MemorizationSession> call(int surahNumber, int startVerse, int endVerse) {
    return _memorizationRepository.createSession(surahNumber, startVerse, endVerse);
  }
}