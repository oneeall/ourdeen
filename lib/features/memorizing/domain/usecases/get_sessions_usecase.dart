import 'dart:collection';

import '../entities/memorization_session.dart';
import '../repositories/memorization_repository.dart';

class GetSessionsUseCase {
  final MemorizationRepository _memorizationRepository;

  GetSessionsUseCase(this._memorizationRepository);

  Future<UnmodifiableListView<MemorizationSession>> call() {
    return _memorizationRepository.getSessions();
  }
}