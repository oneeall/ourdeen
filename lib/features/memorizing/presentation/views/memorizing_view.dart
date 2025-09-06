import 'package:flutter/material.dart';
import 'package:ourdeen/features/memorizing/domain/entities/memorization_session.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';
import 'package:ourdeen/features/memorizing/presentation/views/memorization_session_view.dart';

class MemorizingView extends StatefulWidget {
  const MemorizingView({super.key});

  @override
  State<MemorizingView> createState() => _MemorizingViewState();
}

class _MemorizingViewState extends State<MemorizingView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _colorAnimation = ColorTween(
      begin: Colors.blue.withOpacity(0.3),
      end: Colors.green.withOpacity(0.8),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with title and user stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Memorization Journey',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.orange,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Builder(
                          builder: (context) {
                            final sessions = context
                                .select<
                                  MemorizingViewModel,
                                  List<MemorizationSession>
                                >((vm) => vm.sessions);
                            return Text(
                              '${_calculateTotalStreak(sessions)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Progress summary card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Builder(
                  builder: (context) {
                    final viewModel = Provider.of<MemorizingViewModel>(context);
                    return Column(
                      children: [
                        Text(
                          'Your Progress',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: _calculateOverallProgress(viewModel.sessions),
                          backgroundColor: Colors.grey[300],
                          color: Theme.of(context).colorScheme.primary,
                          minHeight: 12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_calculateOverallProgress(viewModel.sessions) * 100).toStringAsFixed(0)}% Complete',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Active sessions title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Sessions',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement add new session
                      context.read<MemorizingViewModel>().createNewSession(
                        48,
                        1,
                        3,
                      );
                    },
                    child: const Text('New Session'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sessions list
              Builder(
                builder: (context) {

                  final sessions = context
                      .select<MemorizingViewModel, List<MemorizationSession>>(
                        (vm) => vm.sessions,
                  );
                  final isLoading = context.select<MemorizingViewModel, bool>(
                    (vm) => vm.isLoading,
                  );

                  return Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: sessions.length,
                            itemBuilder: (context, index) {
                              final session = sessions[index];
                              return _SessionCard(
                                session: session,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MemorizationSessionView(
                                            sessionId: session.id,
                                            surahNumber: session.surahNumber,
                                            startVerse: session.startVerse,
                                            endVerse: session.endVerse,
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateOverallProgress(List sessions) {
    if (sessions.isEmpty) return 0.0;
    double totalProgress = 0.0;
    for (var session in sessions) {
      totalProgress += session.progress;
    }
    return totalProgress / sessions.length;
  }

  int _calculateTotalStreak(List sessions) {
    int totalStreak = 0;
    for (var session in sessions) {
      totalStreak += session.streak as int;
    }
    return totalStreak;
  }
}

class _SessionCard extends StatelessWidget {
  final dynamic session; // Using dynamic to avoid import issues
  final VoidCallback onTap;

  const _SessionCard({required this.session, required this.onTap});

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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Surah ${session.surahNumber}:${session.startVerse}-${session.endVerse}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (session.progress as double) == 1.0
                        ? Colors.green.withOpacity(0.2)
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    (session.progress as double) == 1.0
                        ? 'Mastered'
                        : '${((session.progress as double) * 100).toInt()}%',
                    style: TextStyle(
                      color: (session.progress as double) == 1.0
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: session.progress as double,
              backgroundColor: Colors.grey[300],
              color: _getProgressColor(session.progress as double),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: (session.streak as int) > 0
                      ? Colors.orange
                      : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '${session.streak} day streak',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  'Last practiced: ${_formatDate(session.lastPracticed as DateTime)}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
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

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '$difference days ago';
  }
}
