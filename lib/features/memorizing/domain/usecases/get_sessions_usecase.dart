import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class GetSessionsUseCase {
  final MemorizationRepository _memorizationRepository;

  GetSessionsUseCase(this._memorizationRepository);

  Future<List<MemorizationSession>> call() {
    return _memorizationRepository.getSessions();
  }
}