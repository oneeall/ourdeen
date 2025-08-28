import 'package:ourdeen/features/counter/domain/entities/counter.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';

class GetCounterUseCase {
  final CounterRepository repository;

  GetCounterUseCase(this.repository);

  Future<Counter> call() async {
    return await repository.getCounter();
  }
}