import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';
import 'package:ourdeen/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:ourdeen/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:ourdeen/features/counter/presentation/viewmodels/counter_viewmodel.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CounterRepository>(
          create: (_) => CounterRepositoryImpl(),
        ),
        Provider<GetCounterUseCase>(
          create: (context) => GetCounterUseCase(
            context.read<CounterRepository>(),
          ),
        ),
        Provider<IncrementCounterUseCase>(
          create: (context) => IncrementCounterUseCase(
            context.read<CounterRepository>(),
          ),
        ),
        ChangeNotifierProvider<CounterViewModel>(
          create: (context) => CounterViewModel(
            getCounterUseCase: context.read<GetCounterUseCase>(),
            incrementCounterUseCase: context.read<IncrementCounterUseCase>(),
          )..initialize(),
        ),
      ],
      child: child,
    );
  }
}