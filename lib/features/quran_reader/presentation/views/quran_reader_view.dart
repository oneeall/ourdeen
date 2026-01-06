import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/core/theme/theme.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_reader_viewmodel.dart';

class QuranReaderView extends StatefulWidget {
  /// The surah number to display (1-114).
  final int surahNumber;

  /// Optional translation edition to display alongside Arabic.
  final EditionEntity? translationEdition;

  const QuranReaderView({
    super.key,
    required this.surahNumber,
    this.translationEdition,
  });

  @override
  State<QuranReaderView> createState() => _QuranReaderViewState();
}

class _QuranReaderViewState extends State<QuranReaderView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Start the animation when the view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      // Load the surah
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadSurah();
      });
    });
  }

  @override
  void didUpdateWidget(QuranReaderView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload if surah number or edition changed
    if (oldWidget.surahNumber != widget.surahNumber ||
        oldWidget.translationEdition != widget.translationEdition) {
      _loadSurah();
    }
  }

  void _loadSurah() {
    context
        .read<QuranReaderViewModel>()
        .loadSurah(widget.surahNumber, widget.translationEdition);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuranReaderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              viewModel.surahName.isNotEmpty
                  ? 'Surah ${viewModel.surahName}'
                  : 'Surah ${widget.surahNumber}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (viewModel.translationEdition != null)
              Text(
                'Translation: ${viewModel.translationEdition!.englishName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                    ),
              ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: _buildContent(viewModel),
      ),
    );
  }

  Widget _buildContent(QuranReaderViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.errorMessage != null && viewModel.verses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load surah',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadSurah,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.verses.isEmpty) {
      return const Center(
        child: Text('No verses found'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: ListView.builder(
        itemCount: viewModel.verses.length,
        itemBuilder: (context, index) {
          final verse = viewModel.verses[index];
          // Calculate staggered animation delays
          final totalItems = viewModel.verses.length;
          final startDelay =
              totalItems > 1 ? index / (totalItems - 1) * 0.5 : 0.0;
          final endDelay = startDelay + 0.5 > 1.0 ? 1.0 : startDelay + 0.5;

          return ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Interval(
                  startDelay,
                  endDelay,
                  curve: Curves.elasticOut,
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  // Ayah number badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Ayah ${verse.numberInSurah}',
                      style: MaterialTheme.accessibleBodyStyle.copyWith(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Arabic text with special styling
                  Text(
                    verse.arabicText,
                    style: MaterialTheme.arabicTextStyle.copyWith(
                      fontSize: 32,
                      height: 2.2,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4.0,
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Translation text (if available)
                  if (verse.translation != null) ...[
                    Text(
                      verse.translation!,
                      style: MaterialTheme.accessibleBodyStyle.copyWith(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ] else if (viewModel.translationEdition != null) ...[
                    Text(
                      'Translation available in full view',
                      style: MaterialTheme.accessibleBodyStyle.copyWith(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}