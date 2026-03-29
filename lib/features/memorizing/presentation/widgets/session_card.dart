import 'package:flutter/material.dart';

/// A card widget displaying information about a single memorization session.
/// Shows the Surah reference, progress percentage, streak, and last practiced date.
class SessionCard extends StatelessWidget {
  final dynamic session; // Using dynamic to avoid import issues
  final VoidCallback onTap;

  const SessionCard({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildProgressBar(context),
            const SizedBox(height: 12),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final progress = session.progress as double;
    final isMastered = progress == 1.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Surah ${session.surahNumber}:${session.startVerse}-${session.endVerse}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isMastered
                ? Colors.green.withValues(alpha: 0.2)
                : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isMastered ? 'Mastered' : '${(progress * 100).toInt()}%',
            style: TextStyle(
              color: isMastered ? Colors.green : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return LinearProgressIndicator(
      value: session.progress as double,
      backgroundColor: Colors.grey[300],
      color: _getProgressColor(session.progress as double),
      minHeight: 8,
      borderRadius: BorderRadius.circular(4),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final streak = session.streak as int;
    final lastPracticed = session.lastPracticed as DateTime;

    return Row(
      children: [
        Icon(
          Icons.local_fire_department,
          color: streak > 0 ? Colors.orange : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          '$streak day streak',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        Text(
          'Last practiced: ${_formatDate(lastPracticed)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.7) return Colors.orange;
    return Colors.green;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Yesterday';
      default:
        return '$difference days ago';
    }
  }
}