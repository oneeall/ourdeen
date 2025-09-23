import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class UpdateSessionProgressUseCase {
  final MemorizationRepository _memorizationRepository;

  UpdateSessionProgressUseCase(this._memorizationRepository);

  Future<MemorizationSession> call(int sessionId, double progress) {
    return _memorizationRepository.updateSessionProgress(sessionId, progress);
  }
}

class UpdateSessionLocalProgressUseCase {
  final MemorizationRepository _memorizationRepository;
  UpdateSessionLocalProgressUseCase(this._memorizationRepository);

  Future<void> call(int sessionId, double progress) {
    return _memorizationRepository.updateSessionProgress(sessionId, progress);
  }
}