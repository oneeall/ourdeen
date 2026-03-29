import 'package:ourdeen/features/memorizing/domain/entities/memorization_session.dart';
import 'package:ourdeen/features/memorizing/domain/entities/memorization_metrics.dart';

/// Use case for calculating memorization metrics from sessions
/// This contains the business logic for progress calculations
class CalculateMemorizationMetricsUseCase {
  const CalculateMemorizationMetricsUseCase();

  /// Calculates comprehensive memorization metrics from a list of sessions
  MemorizationMetrics execute(List<MemorizationSession> sessions) {
    if (sessions.isEmpty) {
      return const MemorizationMetrics(
        weightedProgress: 0.0,
        totalVerses: 0,
        totalStreak: 0,
        estimatedDays: '🔮 Unknown',
        progressLevel: ProgressLevel.justStarted,
        percentage: 0,
      );
    }

    final weightedProgress = _calculateWeightedProgress(sessions);
    final totalVerses = _calculateTotalVerses(sessions);
    final totalStreak = _calculateTotalStreak(sessions);
    final estimatedDays = _calculateEstimatedDays(weightedProgress, sessions.length);
    final percentage = (weightedProgress * 100).toInt();
    final progressLevel = ProgressLevel.fromPercentage(percentage);

    return MemorizationMetrics(
      weightedProgress: weightedProgress,
      totalVerses: totalVerses,
      totalStreak: totalStreak,
      estimatedDays: estimatedDays,
      progressLevel: progressLevel,
      percentage: percentage,
    );
  }

  /// Calculates weighted progress based on verse length, recency, and streak
  /// Longer verses, recent practice, and high streaks get more weight
  double _calculateWeightedProgress(List<MemorizationSession> sessions) {
    double totalWeight = 0.0;
    double weightedSum = 0.0;

    for (var session in sessions) {
      final weight = _calculateSessionWeight(session);
      weightedSum += session.progress * weight;
      totalWeight += weight;
    }

    return weightedSum / totalWeight;
  }

  /// Calculates individual session weight based on multiple factors
  double _calculateSessionWeight(MemorizationSession session) {
    // Longer verses = more weight (normalized to prevent extreme values)
    final verseLength = session.endVerse - session.startVerse + 1;
    final lengthWeight = (verseLength / 10.0).clamp(0.1, 3.0);

    // Recent practice = more weight (decreases over time)
    final daysSincePractice = DateTime.now().difference(session.lastPracticed).inDays;
    final recencyWeight = (1.0 / (1.0 + daysSincePractice / 7.0)).clamp(0.1, 1.0);

    // High streak = more weight (encourages consistency)
    final streakWeight = (1.0 + (session.streak / 10.0)).clamp(1.0, 3.0);

    return lengthWeight * recencyWeight * streakWeight;
  }

  /// Calculates total number of verses across all sessions
  int _calculateTotalVerses(List<MemorizationSession> sessions) {
    int totalVerses = 0;
    for (var session in sessions) {
      totalVerses += (session.endVerse - session.startVerse + 1);
    }
    return totalVerses;
  }

  /// Calculates total streak across all sessions
  int _calculateTotalStreak(List<MemorizationSession> sessions) {
    int totalStreak = 0;
    for (var session in sessions) {
      totalStreak += session.streak;
    }
    return totalStreak;
  }

  /// Estimates days remaining based on current progress rate
  /// Uses a simple heuristic assuming 7 days per session average
  String _calculateEstimatedDays(double progress, int sessionCount) {
    if (progress >= 1.0) return '✅ Done!';
    if (progress == 0.0) return '🔮 Unknown';

    // Estimate based on current progress rate
    // This is a simple heuristic that can be refined with actual user data
    final daysPerSessionAverage = 7.0;
    final remainingProgress = 1.0 - progress;
    final estimatedDays = (remainingProgress * sessionCount * daysPerSessionAverage).toInt();

    return '$estimatedDays';
  }

  /// Gets motivational quote based on progress
  String getMotivationalQuote(int percentage) {
    if (percentage <= 15) {
      return "The journey of a thousand miles begins with a single step.";
    } else if (percentage <= 30) {
      return "Consistency is the key to memorization. Keep going!";
    } else if (percentage <= 50) {
      return "You're building a strong foundation. Your efforts are paying off!";
    } else if (percentage <= 70) {
      return "Halfway there! Your dedication is truly inspiring.";
    } else if (percentage <= 85) {
      return "The finish line is in sight. Push through with excellence!";
    } else if (percentage <= 95) {
      return "Almost there! Your perseverance will be rewarded.";
    } else {
      return "Masha Allah! You've achieved mastery. May Allah bless your journey!";
    }
  }
}