import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:ourdeen/features/shared/base_viewmodel.dart';
import '../../domain/entities/memorization_session.dart';
import '../../domain/entities/memorization_metrics.dart';
import '../../domain/usecases/get_sessions_usecase.dart';
import '../../domain/usecases/create_session_usecase.dart';
import '../../domain/usecases/update_session_progress_usecase.dart';
import '../../domain/usecases/update_session_streak_usecase.dart';
import '../../domain/usecases/calculate_memorization_metrics_usecase.dart';

/// View model for managing memorization sessions and their metrics
/// Handles the presentation logic and delegates business logic to use cases
class MemorizingViewModel extends BaseViewModel {
  final GetSessionsUseCase _getSessionsUseCase;
  final CreateSessionUseCase _createSessionUseCase;
  final UpdateSessionProgressUseCase _updateSessionProgressUseCase;
  final UpdateSessionStreakUseCase _updateSessionStreakUseCase;
  final CalculateMemorizationMetricsUseCase _calculateMemorizationMetricsUseCase;

  UnmodifiableListView<MemorizationSession> _sessions = UnmodifiableListView(
    [],
  );

  List<MemorizationSession> get sessions => _sessions;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  double _currentProgress = 0.0;

  double get currentProgress => _currentProgress;

  MemorizationMetrics? _metrics;

  MemorizationMetrics? get metrics => _metrics;

  MemorizingViewModel(
    this._getSessionsUseCase,
    this._createSessionUseCase,
    this._updateSessionProgressUseCase,
    this._updateSessionStreakUseCase,
    this._calculateMemorizationMetricsUseCase,
  );

  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sessions = await _getSessionsUseCase();
      // Calculate metrics after loading sessions
      _metrics = _calculateMemorizationMetricsUseCase.execute(_sessions);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading sessions: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewSession(
    int surahNumber,
    int startVerse,
    int endVerse,
  ) async {
    try {
      final newSession = await _createSessionUseCase(
        surahNumber,
        startVerse,
        endVerse,
      );

      _sessions = UnmodifiableListView([..._sessions, newSession]);
      // Recalculate metrics when new session is added
      _metrics = _calculateMemorizationMetricsUseCase.execute(_sessions);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error creating session: $e');
      }
    }
  }

  Future<void> updateProgress(int sessionId, double progress) async {
    try {
      final updatedSession = await _updateSessionProgressUseCase(
        sessionId,
        progress,
      );
      final index = _sessions.indexWhere((session) => session.id == sessionId);
      if (index != -1) {
        final listTemp = _sessions.toList();
        listTemp[index] = updatedSession;
        _sessions = UnmodifiableListView(listTemp);
        // Recalculate metrics when progress is updated
        _metrics = _calculateMemorizationMetricsUseCase.execute(_sessions);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating progress: $e');
      }
    }
  }

  Future<void> incrementStreak(int sessionId) async {
    try {
      final updatedSession = await _updateSessionStreakUseCase(sessionId);
      final index = _sessions.indexWhere((session) => session.id == sessionId);
      if (index != -1) {
        final listTemp = _sessions.toList();
        listTemp[index] = updatedSession;
        _sessions = UnmodifiableListView(listTemp);
        // Recalculate metrics when streak is updated
        _metrics = _calculateMemorizationMetricsUseCase.execute(_sessions);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating streak: $e');
      }
    }
  }

  void setCurrentProgress(double progress) {
    _currentProgress = progress;
    notifyListeners();
  }

  /// Calculates and updates memorization metrics for current sessions
  void calculateMetrics() {
    _metrics = _calculateMemorizationMetricsUseCase.execute(_sessions);
    notifyListeners();
  }

  /// Gets motivational quote based on current progress
  String getMotivationalQuote() {
    if (_metrics == null) return '';
    return _calculateMemorizationMetricsUseCase.getMotivationalQuote(_metrics!.percentage);
  }
}
