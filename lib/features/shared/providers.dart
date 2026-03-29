import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/core/services/alquran_cloud/alquran_cloud_provider.dart';
import 'package:ourdeen/core/services/alquran_cloud/alquran_cloud_service.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/repositories/alquran_cloud_repository.dart';
import 'package:ourdeen/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:ourdeen/features/counter/domain/repositories/counter_repository.dart';
import 'package:ourdeen/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:ourdeen/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:ourdeen/features/counter/presentation/viewmodels/counter_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/data/repositories/quran_repository_impl.dart';
import 'package:ourdeen/features/quran_reader/domain/repositories/quran_repository.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/get_verses_usecase.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_reader_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_list_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/get_surahs_list_usecase.dart';
import 'package:ourdeen/features/memorizing/data/repositories/memorization_repository_impl.dart';
import 'package:ourdeen/features/memorizing/domain/repositories/memorization_repository.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/get_sessions_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/create_session_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/update_session_progress_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/update_session_streak_usecase.dart';
import 'package:ourdeen/features/memorizing/domain/usecases/calculate_memorization_metrics_usecase.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';
import 'package:ourdeen/features/tajweed/data/repositories/tajweed_repository_impl.dart';
import 'package:ourdeen/features/tajweed/domain/repositories/tajweed_repository.dart';
import 'package:ourdeen/features/tajweed/domain/usecases/get_tajweed_preference_usecase.dart';
import 'package:ourdeen/features/tajweed/domain/usecases/update_tajweed_preference_usecase.dart';
import 'package:ourdeen/features/tajweed/presentation/viewmodels/tajweed_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/data/repositories/animation_repository_impl.dart';
import 'package:ourdeen/features/quran_reader/domain/repositories/animation_repository.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/get_animation_preference_usecase.dart';
import 'package:ourdeen/features/quran_reader/domain/usecases/update_animation_preference_usecase.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/animation_viewmodel.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Wrap with AlquranCloudProvider for API service
    return AlquranCloudProvider(
      child: MultiProvider(
        providers: [
          // Counter feature providers
          Provider<CounterRepository>(create: (_) => CounterRepositoryImpl()),
          Provider<GetCounterUseCase>(
            create: (context) =>
                GetCounterUseCase(context.read<CounterRepository>()),
          ),
          Provider<IncrementCounterUseCase>(
            create: (context) =>
                IncrementCounterUseCase(context.read<CounterRepository>()),
          ),
          ChangeNotifierProvider<CounterViewModel>(
            create: (context) => CounterViewModel(
              getCounterUseCase: context.read<GetCounterUseCase>(),
              incrementCounterUseCase: context.read<IncrementCounterUseCase>(),
            )..initialize(),
          ),

          // Quran reader feature providers
          Provider<QuranRepository>(create: (_) => QuranRepositoryImpl()),
          Provider<GetVersesUseCase>(
            create: (context) =>
                GetVersesUseCase(context.read<QuranRepository>()),
          ),

          // Memorizing feature providers
          Provider<MemorizationRepository>(
            create: (_) => MemorizationRepositoryImpl(),
          ),
          Provider<GetSessionsUseCase>(
            create: (context) =>
                GetSessionsUseCase(context.read<MemorizationRepository>()),
          ),
          Provider<CreateSessionUseCase>(
            create: (context) =>
                CreateSessionUseCase(context.read<MemorizationRepository>()),
          ),
          Provider<UpdateSessionProgressUseCase>(
            create: (context) => UpdateSessionProgressUseCase(
              context.read<MemorizationRepository>(),
            ),
          ),
          Provider<UpdateSessionStreakUseCase>(
            create: (context) => UpdateSessionStreakUseCase(
              context.read<MemorizationRepository>(),
            ),
          ),
          Provider<CalculateMemorizationMetricsUseCase>(
            create: (context) => const CalculateMemorizationMetricsUseCase(),
          ),
          ChangeNotifierProvider<MemorizingViewModel>(
            create: (context) => MemorizingViewModel(
              context.read<GetSessionsUseCase>(),
              context.read<CreateSessionUseCase>(),
              context.read<UpdateSessionProgressUseCase>(),
              context.read<UpdateSessionStreakUseCase>(),
              context.read<CalculateMemorizationMetricsUseCase>(),
            )..loadSessions(),
          ),

          // Tajweed feature providers
          Provider<AnimationRepository>(
            create: (_) => AnimationRepositoryImpl(),
          ),
          Provider<GetAnimationPreferenceUseCase>(
            create: (context) => GetAnimationPreferenceUseCase(
              context.read<AnimationRepository>(),
            ),
          ),
          Provider<UpdateAnimationPreferenceUseCase>(
            create: (context) => UpdateAnimationPreferenceUseCase(
              context.read<AnimationRepository>(),
            ),
          ),
          ChangeNotifierProvider<AnimationViewModel>(
            create: (context) => AnimationViewModel(
              context.read<GetAnimationPreferenceUseCase>(),
              context.read<UpdateAnimationPreferenceUseCase>(),
            )..loadPreference(),
          ),

          Provider<TajweedRepository>(
            create: (_) => TajweedRepositoryImpl(),
          ),
          Provider<GetTajweedPreferenceUseCase>(
            create: (context) => GetTajweedPreferenceUseCase(
              context.read<TajweedRepository>(),
            ),
          ),
          Provider<UpdateTajweedPreferenceUseCase>(
            create: (context) => UpdateTajweedPreferenceUseCase(
              context.read<TajweedRepository>(),
            ),
          ),
          ChangeNotifierProvider<TajweedViewModel>(
            create: (context) => TajweedViewModel(
              context.read<GetTajweedPreferenceUseCase>(),
              context.read<UpdateTajweedPreferenceUseCase>(),
            )..loadPreference(),
          ),

          // AlquranCloudService provided here to access TajweedViewModel
          Provider<AlquranCloudService>(
            create: (context) => AlquranCloudService(
              context.read<AlquranCloudRepository>(),
              tajweedViewModel: context.read<TajweedViewModel>(),
            ),
          ),

          // Quran reader ViewModels that depend on AlquranCloudService
          ChangeNotifierProvider<QuranReaderViewModel>(
            create: (context) => QuranReaderViewModel(
              context.read<AlquranCloudService>(),
            ),
          ),
          Provider<GetSurahsListUseCase>(
            create: (context) => GetSurahsListUseCase(
              context.read<AlquranCloudService>(),
            ),
          ),
          ChangeNotifierProvider<QuranListViewModel>(
            create: (context) => QuranListViewModel(
              context.read<GetSurahsListUseCase>(),
              context.read<AlquranCloudService>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
