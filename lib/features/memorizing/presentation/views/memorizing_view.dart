import 'package:flutter/material.dart';
import 'package:ourdeen/factory_pattern/factory_example.dart';
import 'package:ourdeen/features/memorizing/domain/entities/memorization_session.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorizing_viewmodel.dart';
import 'package:ourdeen/features/memorizing/presentation/views/memorization_session_view.dart';
import 'package:ourdeen/features/memorizing/presentation/widgets/progress_summary_card.dart';
import 'package:ourdeen/features/memorizing/presentation/widgets/session_card.dart';

/// Main view for the Memorization Journey feature.
/// Displays all active memorization sessions with overall progress tracking,
/// streak counters, and navigation to individual session details.
class MemorizingView extends StatefulWidget {
  const MemorizingView({super.key});

  @override
  State<MemorizingView> createState() => _MemorizingViewState();
}

class _MemorizingViewState extends State<MemorizingView> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _controller.forward();
    // Load sessions when the view is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MemorizingViewModel>().loadSessions();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Initializes the progress animations
  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
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
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildProgressSummaryCard(context),
              const SizedBox(height: 24),
              _buildActiveSessionsSection(context),
              const SizedBox(height: 16),
              Expanded(child: _buildSessionsList(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header with title and streak counter
  Widget _buildHeader(BuildContext context) {
    return Consumer<MemorizingViewModel>(
      builder: (context, viewModel, child) {
        final streak = viewModel.metrics?.totalStreak ?? 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Memorization Journey',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$streak',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds the progress summary card with metrics
  Widget _buildProgressSummaryCard(BuildContext context) {
    return Consumer<MemorizingViewModel>(
      builder: (context, viewModel, child) {
        final metrics = viewModel.metrics;
        final sessions = viewModel.sessions;

        if (metrics == null) {
          return const SizedBox.shrink();
        }

        return ProgressSummaryCard(
          sessions: sessions,
          progress: metrics.weightedProgress,
          progressData: metrics.progressLevel.data.toMap(),
          totalVerses: metrics.totalVerses,
          streakDays: metrics.totalStreak,
          estimatedDays: metrics.estimatedDays,
          motivationalQuote: viewModel.getMotivationalQuote(),
        );
      },
    );
  }

  /// Builds the active sessions section header
  Widget _buildActiveSessionsSection(BuildContext context) {
    return Row(
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
            context.read<MemorizingViewModel>().createNewSession(48, 1, 3);
          },
          child: const Text('New Session'),
        ),
      ],
    );
  }

  /// Builds the list of sessions
  Widget _buildSessionsList(BuildContext context) {
    return Selector<MemorizingViewModel, ({List<MemorizationSession> sessions, bool isLoading})>(
      selector: (context, viewModel) => (sessions: viewModel.sessions, isLoading: viewModel.isLoading),
      builder: (context, data, child) {
        final sessions = data.sessions;
        final isLoading = data.isLoading;

        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return SessionCard(
              session: session,
              onTap: () => _navigateToSession(context, session),
            );
          },
        );
      },
    );
  }

  /// Navigates to the session detail view
  void _navigateToSession(BuildContext context, MemorizationSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemorizationSessionView(
          sessionId: session.id,
          surahNumber: session.surahNumber,
          startVerse: session.startVerse,
          endVerse: session.endVerse,
        ),
      ),
    );
  }
}
