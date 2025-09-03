import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';
import 'package:ourdeen/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:ourdeen/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:ourdeen/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/data/repositories/quran_repository_impl.dart';
import 'package:ourdeen/features/quran_reader/domain/repositories/quran_repository.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/get_verses_usecase.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_reader_viewmodel.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Counter feature providers
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
        
        // Quran reader feature providers
        Provider<QuranRepository>(
          create: (_) => QuranRepositoryImpl(),
        ),
        Provider<GetVersesUseCase>(
          create: (context) => GetVersesUseCase(
            context.read<QuranRepository>(),
          ),
        ),
        ChangeNotifierProvider<QuranReaderViewModel>(
          create: (context) => QuranReaderViewModel(
            context.read<GetVersesUseCase>(),
          )..loadVerses(),
        ),
      ],
      child: child,
    );
  }
}