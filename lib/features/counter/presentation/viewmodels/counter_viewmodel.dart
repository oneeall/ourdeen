import 'package:ourdeen/features/counter/domain/entities/counter.dart';
import 'package:ourdeen/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:ourdeen/features/counter/domain/usecases/increment_counter_usecase.dart';

import '../../../shared/base_viewmodel.dart';

class CounterViewModel extends BaseViewModel {
  final GetCounterUseCase _getCounterUseCase;
  final IncrementCounterUseCase _incrementCounterUseCase;
  Counter? _counter;

  CounterViewModel({
    required GetCounterUseCase getCounterUseCase,
    required IncrementCounterUseCase incrementCounterUseCase,
  })  : _getCounterUseCase = getCounterUseCase,
        _incrementCounterUseCase = incrementCounterUseCase;

  Counter? get counter => _counter;

  Future<void> initialize() async {
    await getCounter();
  }

  Future<void> getCounter() async {
    setBusy(true);
    try {
      _counter = await _getCounterUseCase();
    } catch (e) {
      // Handle error
      print('Error getting counter: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> incrementCounter() async {
    if (_counter != null) {
      setBusy(true);
      try {
        _counter = await _incrementCounterUseCase(_counter!);
        notifyListeners();
      } catch (e) {
        // Handle error
        print('Error incrementing counter: $e');
      } finally {
        setBusy(false);
      }
    }
  }
}