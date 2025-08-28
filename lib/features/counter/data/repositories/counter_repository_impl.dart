import 'package:ourdeen/features/counter/data/models/counter_dto.dart';
import 'package:ourdeen/features/counter/data/models/counter_mapper.dart';
import 'package:ourdeen/features/counter/domain/entities/counter.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  // In a real app, this would be an API client or database
  CounterDto _counterDto = CounterDto(value: 0);

  @override
  Future<Counter> getCounter() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return CounterMapper.toEntity(_counterDto);
  }

  @override
  Future<Counter> incrementCounter(Counter counter) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    counter.increment();
    _counterDto = CounterMapper.toDto(counter);
    return counter;
  }
}