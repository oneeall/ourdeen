import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:ourdeen/features/shared/base_viewmodel.dart';
import '../../domain/entities/memorization_session.dart';
import '../../domain/usecases/get_sessions_usecase.dart';
import '../../domain/usecases/create_session_usecase.dart';
import '../../domain/usecases/update_session_progress_usecase.dart';
import '../../domain/usecases/update_session_streak_usecase.dart';

class MemorizingViewModel extends BaseViewModel {
  final GetSessionsUseCase _getSessionsUseCase;
  final CreateSessionUseCase _createSessionUseCase;
  final UpdateSessionProgressUseCase _updateSessionProgressUseCase;
  final UpdateSessionStreakUseCase _updateSessionStreakUseCase;

  UnmodifiableListView<MemorizationSession> _sessions = UnmodifiableListView(
    [],
  );

  List<MemorizationSession> get sessions => _sessions;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  double _currentProgress = 0.0;

  double get currentProgress => _currentProgress;

  MemorizingViewModel(
    this._getSessionsUseCase,
    this._createSessionUseCase,
    this._updateSessionProgressUseCase,
    this._updateSessionStreakUseCase,
  );

  Future<void> loadSessions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _sessions = await _getSessionsUseCase();
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
        _sessions[index] = updatedSession;
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
}
