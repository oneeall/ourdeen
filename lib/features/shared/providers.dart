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
import 'package:ourdeen/features/memorizing/data/repositories/memorization_repository_impl.dart';
import 'package:ourdeen/features/memorizing/domain/repositories/memorization_repository.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/get_sessions_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/create_session_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/update_session_progress_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/update_session_streak_usecase.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';

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
        
        // Memorizing feature providers
        Provider<MemorizationRepository>(
          create: (_) => MemorizationRepositoryImpl(),
        ),
        Provider<GetSessionsUseCase>(
          create: (context) => GetSessionsUseCase(
            context.read<MemorizationRepository>(),
          ),
        ),
        Provider<CreateSessionUseCase>(
          create: (context) => CreateSessionUseCase(
            context.read<MemorizationRepository>(),
          ),
        ),
        Provider<UpdateSessionProgressUseCase>(
          create: (context) => UpdateSessionProgressUseCase(
            context.read<MemorizationRepository>(),
          ),
        ),

        Provider<MemorizationRepositoryLocalImp>(
          create: (_) => MemorizationRepositoryLocalImp(),
        ),
        Provider<UpdateSessionLocalProgressUseCase>(
          create: (context) => UpdateSessionLocalProgressUseCase(
            context.read<MemorizationRepositoryLocalImp>()
          ),
        ),
        Provider<UpdateSessionStreakUseCase>(
          create: (context) => UpdateSessionStreakUseCase(
            context.read<MemorizationRepository>(),
          ),
        ),
        ChangeNotifierProvider<MemorizingViewModel>(
          create: (context) => MemorizingViewModel(
            context.read<GetSessionsUseCase>(),
            context.read<CreateSessionUseCase>(),
            context.read<UpdateSessionProgressUseCase>(),
            context.read<UpdateSessionStreakUseCase>(),
          )..loadSessions(),
        ),
      ],
      child: child,
    );
  }
}