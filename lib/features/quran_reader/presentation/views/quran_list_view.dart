import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ourdeen/core/theme/theme.dart';
import 'package:ourdeen/core/services/alquran_cloud/domain/entities/edition_entity.dart';
import 'package:ourdeen/features/quran_reader/domain/entities/surah_list_item.dart';
import 'package:ourdeen/features/quran_reader/presentation/viewmodels/quran_list_viewmodel.dart';
import 'package:ourdeen/features/quran_reader/presentation/views/surah_preview_bottom_sheet.dart';

class QuranListView extends StatefulWidget {
  const QuranListView({super.key});

  @override
  State<QuranListView> createState() => _QuranListViewState();
}

class _QuranListViewState extends State<QuranListView>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _listController;
  late Animation<double> _headerAnimation;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.elasticOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _headerController.forward();
      _listController.forward();
    });

    // Initialize view model
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranListViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _listController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _showSurahPreview(SurahListItem surah, EditionEntity? edition) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SurahPreviewBottomSheet(
        surah: surah,
        edition: edition,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<QuranListViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with title
              ScaleTransition(
                scale: _headerAnimation,
                child: Column(
                  children: [
                    Text(
                      'Quran',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '114 Surahs',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.7),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Edition filter dropdown
              FadeTransition(
                opacity: _headerAnimation,
                child: _EditionFilterDropdown(
                  editions: viewModel.editions,
                  selectedEdition: viewModel.selectedEdition,
                  onEditionSelected: (edition) {
                    viewModel.setSelectedEdition(edition);
                    // Close keyboard when changing edition
                    _searchFocusNode.unfocus();
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Search bar
              FadeTransition(
                opacity: _headerAnimation,
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Search surah...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  style: MaterialTheme.accessibleBodyStyle,
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(height: 16),

              // Surah list
              Expanded(
                child: _buildContent(viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(QuranListViewModel viewModel) {
    if (viewModel.isLoading && viewModel.surahs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.errorMessage != null && viewModel.surahs.isEmpty) {
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
              'Failed to load surahs',
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
              onPressed: () => viewModel.loadSurahs(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final filteredSurahs = viewModel.getFilteredSurahs(_searchController.text);

    if (filteredSurahs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No surahs found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredSurahs.length,
      padding: const EdgeInsets.only(bottom: 16),
      itemBuilder: (context, index) {
        final surah = filteredSurahs[index];
        final delay = index / filteredSurahs.length;
        return AnimatedBuilder(
          animation: _listController,
          builder: (context, child) {
            final animationDelay = (delay * 0.5).clamp(0.0, 1.0);
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _listController,
              curve: Interval(animationDelay, animationDelay + 0.3),
            ));
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: _listController,
                curve: Interval(animationDelay, animationDelay + 0.3),
              ),
              child: SlideTransition(
                position: slideAnimation,
                child: child,
              ),
            );
          },
          child: _SurahListTile(
            surah: surah,
            onTap: () => _showSurahPreview(
              surah,
              viewModel.selectedEdition,
            ),
          ),
        );
      },
    );
  }
}

class _EditionFilterDropdown extends StatelessWidget {
  final List<EditionEntity> editions;
  final EditionEntity? selectedEdition;
  final ValueChanged<EditionEntity> onEditionSelected;

  const _EditionFilterDropdown({
    required this.editions,
    required this.selectedEdition,
    required this.onEditionSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (editions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<EditionEntity>(
          value: selectedEdition,
          isExpanded: true,
          hint: Text(
            'Select Translation',
            style: MaterialTheme.accessibleBodyStyle,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).colorScheme.primary,
          ),
          style: MaterialTheme.accessibleBodyStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          items: editions.map((edition) {
            return DropdownMenuItem<EditionEntity>(
              value: edition,
              child: Row(
                children: [
                  _buildLanguageFlag(context, edition.language),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            edition.englishName,
                            style: MaterialTheme.accessibleBodyStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            edition.name,
                            style: MaterialTheme.accessibleBodyStyle.copyWith(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (edition) {
            if (edition != null) {
              onEditionSelected(edition);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLanguageFlag(BuildContext context, String language) {
    // Simple flag emoji based on language code
    final flags = {
      'id': '🇮🇩',
      'en': '🇬🇧',
      'ar': '🇸🇦',
      'fr': '🇫🇷',
      'de': '🇩🇪',
      'es': '🇪🇸',
      'tr': '🇹🇷',
      'ur': '🇵🇰',
      'ru': '🇷🇺',
      'zh': '🇨🇳',
      'fa': '🇮🇷',
      'ha': '🇳🇬',
      'sw': '🇰🇪',
      'it': '🇮🇹',
      'nl': '🇳🇱',
      'bn': '🇧🇩',
      'th': '🇹🇭',
      'ta': '🇮🇳',
      'ml': '🇮🇳',
      'kk': '🇰🇿',
      'uz': '🇺🇿',
      'bs': '🇧🇦',
      'hr': '🇭🇷',
      'sr': '🇷🇸',
      'sq': '🇦🇱',
      'mg': '🇲🇬',
      'my': '🇲🇲',
      'ja': '🇯🇵',
      'ko': '🇰🇷',
      'pt': '🇵🇹',
      'pl': '🇵🇱',
      'sv': '🇸🇪',
      'no': '🇳🇴',
      'da': '🇩🇰',
      'fi': '🇫🇮',
      'el': '🇬🇷',
      'cs': '🇨🇿',
      'ro': '🇷🇴',
      'bg': '🇧🇬',
      'hu': '🇭🇺',
      'uk': '🇺🇦',
      'he': '🇮🇱',
      'hi': '🇮🇳',
      'ms': '🇲🇾',
    };
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          flags[language] ?? '🌐',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class _SurahListTile extends StatelessWidget {
  final SurahListItem surah;
  final VoidCallback onTap;

  const _SurahListTile({
    required this.surah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Surah number badge
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${surah.number}',
                      style: MaterialTheme.accessibleBodyStyle.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Surah info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.englishName,
                        style: MaterialTheme.accessibleBodyStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${surah.displayRevelationType} • ${surah.numberOfAyahs} Ayahs',
                        style: MaterialTheme.accessibleBodyStyle.copyWith(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      Text(
                        surah.englishNameTranslation,
                        style: MaterialTheme.accessibleBodyStyle.copyWith(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),

                // Arabic name
                Text(
                  surah.name,
                  style: MaterialTheme.arabicTextStyle.copyWith(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
