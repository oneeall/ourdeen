import 'package:ourdeen/features/counter/domain/entities/counter.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';

class IncrementCounterUseCase {
  final CounterRepository repository;

  IncrementCounterUseCase(this.repository);

  Future<Counter> call(Counter counter) async {
    return await repository.incrementCounter(counter);
  }
}