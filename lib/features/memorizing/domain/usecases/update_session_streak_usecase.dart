import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class UpdateSessionStreakUseCase {
  final MemorizationRepository _memorizationRepository;

  UpdateSessionStreakUseCase(this._memorizationRepository);

  Future<MemorizationSession> call(int sessionId) {
    return _memorizationRepository.updateSessionStreak(sessionId);
  }
}