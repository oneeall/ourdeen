import 'package:ourdeen/features/counter/domain/entities/counter.dart';

abstract class CounterRepository {
  Future<Counter> getCounter();
  Future<Counter> incrementCounter(Counter counter);
}