import 'package:flutter/material.dart';
import 'package:ourdeen/features/memorizing/domain/entities/memorization_session.dart';
import 'package:ourdeen/features/memorizing/presentation/widgets/stat_item.dart';

/// A card widget displaying the user's overall memorization progress
/// with visual indicators, stats, and motivational messages.
class ProgressSummaryCard extends StatelessWidget {
  final List<MemorizationSession> sessions;
  final double progress;
  final Map<String, dynamic> progressData;
  final int totalVerses;
  final int streakDays;
  final String estimatedDays;
  final String? motivationalQuote;

  const ProgressSummaryCard({
    super.key,
    required this.sessions,
    required this.progress,
    required this.progressData,
    required this.totalVerses,
    required this.streakDays,
    required this.estimatedDays,
    this.motivationalQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildProgressBar(context),
          const SizedBox(height: 16),
          _buildStatsRow(context),
          const SizedBox(height: 16),
          _buildMotivationalQuote(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          progressData['emoji'],
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                progressData['title'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                progressData['subtitle'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: progressData['color'].withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: progressData['color'],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Container(
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [progressData['startColor'], progressData['endColor']],
              ),
            ),
            height: 16,
            width: MediaQuery.of(context).size.width * 0.8 * progress,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatItem(
          emoji: '📖',
          label: 'Verses',
          value: '$totalVerses',
          tooltip: 'Total number of verses you are currently memorizing across all sessions',
        ),
        StatItem(
          emoji: '🔥',
          label: 'Streak',
          value: '$streakDays',
          tooltip: 'Total consecutive days of practice across all your memorization sessions',
        ),
        StatItem(
          emoji: '📅',
          label: 'Days Left',
          value: estimatedDays,
          tooltip: 'Estimated days remaining to complete your memorization goal based on current progress',
        ),
      ],
    );
  }

  Widget _buildMotivationalQuote(BuildContext context) {
    final quote = motivationalQuote ?? _getMotivationalQuote(progress);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text('💡', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              quote,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalQuote(double progress) {
    int percentage = (progress * 100).toInt();

    switch (percentage) {
      case <= 15:
        return "The journey of a thousand miles begins with a single step.";
      case <= 30:
        return "Consistency is the key to memorization. Keep going!";
      case <= 50:
        return "You're building a strong foundation. Your efforts are paying off!";
      case <= 70:
        return "Halfway there! Your dedication is truly inspiring.";
      case <= 85:
        return "The finish line is in sight. Push through with excellence!";
      case <= 95:
        return "Almost there! Your perseverance will be rewarded.";
      default:
        return "Masha Allah! You've achieved mastery. May Allah bless your journey!";
    }
  }
}