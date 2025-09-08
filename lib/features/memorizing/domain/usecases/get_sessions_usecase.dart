import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class GetSessionsUseCase {
  final MemorizationRepository _memorizationRepository;

  GetSessionsUseCase(this._memorizationRepository);

  Future<IList<MemorizationSession>> call() {
    return _memorizationRepository.getSessions();
  }
}