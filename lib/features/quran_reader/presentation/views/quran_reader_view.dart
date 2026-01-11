import 'package:flutter/material.dart';
import 'package:ourdeen/features/tajweed/presentation/widgets/tajweed_text.dart';
import 'package:ourdeen/features/tajweed/presentation/widgets/tajweed_legend_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/core/theme/theme.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_reader_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/animation_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/domain/entities/animation_preference.dart';
import 'dart:math' as math;

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

/// Helper class to store pre-calculated animation parameters
class _AnimationParams {
  final double startDelay;
  final double endDelay;

  _AnimationParams(this.startDelay, this.endDelay);
}

class _QuranReaderViewState extends State<QuranReaderView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  // OPTIMIZATION: Cache animation parameters to avoid repeated calculations
  List<_AnimationParams>? _animationParams;
  int? _cachedVerseCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
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

  /// Pre-calculate animation parameters for all items
  List<_AnimationParams> _calculateAnimationParams(int itemCount) {
    if (itemCount == 0) return [];

    return List.generate(
      itemCount,
      (index) {
        final startDelay = itemCount > 1 ? index / (itemCount - 1) * 0.5 : 0.0;
        final endDelay = startDelay + 0.5 > 1.0 ? 1.0 : startDelay + 0.5;
        return _AnimationParams(startDelay, endDelay);
      },
    );
  }

  /// Calculate scale based on animation value and delays
  /// This avoids creating CurvedAnimation objects for every item
  double _calculateScale(
    double animationValue,
    double startDelay,
    double endDelay,
    AnimationCurveType curveType,
  ) {
    if (animationValue < startDelay) {
      return 0.8; // Haven't started yet
    } else if (animationValue > endDelay) {
      return 1.0; // Animation complete
    } else {
      // Interpolate between 0.8 and 1.0
      final progress = (animationValue - startDelay) / (endDelay - startDelay);
      final curveValue = switch (curveType) {
        AnimationCurveType.none => 1.0, // No animation, immediate scale
        AnimationCurveType.smooth => _easeOutCubic(progress),
        AnimationCurveType.bouncy => _elasticOut(progress),
      };
      return 0.8 + (0.2 * curveValue);
    }
  }

  /// OPTIMIZED: easeOutCubic curve implementation - much faster than elasticOut
  /// Uses simple arithmetic instead of expensive trigonometric functions
  double _easeOutCubic(double t) {
    final p = 1 - t;
    return 1 - (p * p * p);
  }

  /// Bouncy elasticOut curve implementation
  /// More playful but uses expensive trigonometric functions (pow, sin, pi)
  double _elasticOut(double t) {
    final p = 0.3;
    final s = p / 4;
    return math.pow(2, -10 * t) * math.sin((t - s) * (2 * math.pi) / p) + 1;
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // OPTIMIZATION: Use context.watch instead of Provider.of
    // This is clearer and more explicit about rebuild behavior
    final viewModel = context.watch<QuranReaderViewModel>();
    final animationViewModel = context.watch<AnimationViewModel>();
    final animationCurveType = animationViewModel.curveType;

    return Scaffold(
      body: CustomScrollView(
        // OPTIMIZATION: Use ClampingScrollPhysics to disable overscroll stretch effect
        // This provides a more consistent reading experience without bouncy edges
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          // SliverAppBar with floating behavior for smooth scrolling
          _buildSliverAppBar(viewModel),

          // Loading state
          if (viewModel.isLoading)
            SliverFillRemaining(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Error state
          if (viewModel.errorMessage != null && viewModel.verses.isEmpty)
            SliverFillRemaining(
              child: _buildErrorWidget(viewModel),
            ),

          // Empty state
          if (viewModel.verses.isEmpty && !viewModel.isLoading && viewModel.errorMessage == null)
            SliverFillRemaining(
              child: const Center(
                child: Text('No verses found'),
              ),
            ),

          // Verses list using SliverList for optimal performance
          if (viewModel.verses.isNotEmpty && !viewModel.isLoading)
            _buildVersesSliver(viewModel, animationCurveType),
        ],
      ),
    );
  }

  /// Builds the SliverAppBar with floating behavior
  Widget _buildSliverAppBar(QuranReaderViewModel viewModel) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: colorScheme.onSurface,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        // Tajweed color legend button
        IconButton(
          icon: Icon(
            Icons.palette_outlined,
            color: colorScheme.onSurface,
          ),
          onPressed: () => TajweedLegendBottomSheet.show(context),
          tooltip: 'Tajweed Color Legend',
        ),
      ],
      // Floating app bar that collapses on scroll
      floating: true,
      // App bar remains pinned at top when collapsed
      pinned: true,
      // Smooth snap animation when scrolling
      snap: false,
      // Expand height to show surah information
      expandedHeight: 100,
      // Flexible space for surah title
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        collapseMode: CollapseMode.parallax,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface,
                colorScheme.surface,
              ],
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              viewModel.surahName.isNotEmpty
                  ? 'Surah ${viewModel.surahName}'
                  : 'Surah ${widget.surahNumber}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (viewModel.translationEdition != null)
              Text(
                'Translation: ${viewModel.translationEdition!.englishName}',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
          ],
        ),
      ),
      elevation: 0,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
    );
  }

  /// Builds the error widget when surah fails to load
  Widget _buildErrorWidget(QuranReaderViewModel viewModel) {
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

  /// Builds the SliverList containing all verses
  Widget _buildVersesSliver(
    QuranReaderViewModel viewModel,
    AnimationCurveType animationCurveType,
  ) {
    // CRITICAL: Pre-calculate animation parameters if verse count changed
    if (_cachedVerseCount != viewModel.verses.length) {
      _animationParams = _calculateAnimationParams(viewModel.verses.length);
      _cachedVerseCount = viewModel.verses.length;
    }

    // CRITICAL: Extract theme data ONCE before building slivers
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final verse = viewModel.verses[index];
            final params = _animationParams![index];

            // CRITICAL OPTIMIZATION: Use AnimatedBuilder instead of ScaleTransition
            return RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final animationValue = _controller.value;
                  final scale = _calculateScale(
                    animationValue,
                    params.startDelay,
                    params.endDelay,
                    animationCurveType,
                  );

                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  key: ValueKey('verse_${verse.number}'),
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      // Ayah number badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Ayah ${verse.numberInSurah}',
                          style: MaterialTheme.accessibleBodyStyle.copyWith(
                            fontSize: 12,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Arabic text with Tajweed styling
                      DefaultTextStyle(
                        style: MaterialTheme.arabicTextStyle.copyWith(
                          fontSize: 32,
                          height: 2.2,
                          shadows: [
                            Shadow(
                              offset: const Offset(2, 2),
                              blurRadius: 4.0,
                              color: colorScheme.onSurface.withValues(alpha: 0.1),
                            ),
                          ],
                        ),
                        child: TajweedText(
                          key: ValueKey('tajweed_${verse.number}'),
                          rawVerse: verse.arabicText,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Translation text (if available)
                      if (verse.translation != null) ...[
                        Text(
                          verse.translation!,
                          style: MaterialTheme.accessibleBodyStyle.copyWith(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ] else if (viewModel.translationEdition != null) ...[
                        Text(
                          'Translation available in full view',
                          style: MaterialTheme.accessibleBodyStyle.copyWith(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: viewModel.verses.length,
          // OPTIMIZATION: Add semantic separator counts for better accessibility
          semanticIndexCallback: (Widget widget, int localIndex) {
            return localIndex;
          },
        ),
      ),
    );
  }
}
