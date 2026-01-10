import 'package:flutter/material.dart';
import 'package:ourdeen/features/tajweed/domain/entities/tajweed_color_rule.dart';
import 'package:ourdeen/core/theme/theme.dart';

/// A reusable widget that displays the Tajweed color legend
///
/// This widget shows all Tajweed color coding rules in an organized,
/// visually appealing format. It can be used standalone or embedded
/// in other widgets like bottom sheets or dialogs.
///
/// Example:
/// ```dart
/// const TajweedColorLegend()
/// ```
class TajweedColorLegend extends StatelessWidget {
  const TajweedColorLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        _buildHeader(context),
        const SizedBox(height: 24),

        // Legend items grouped by category
        ...TajweedColorRules.categorizedRules.entries.map((entry) {
          return _buildCategory(
            context,
            entry.key,
            entry.value,
          );
        }),

        // Footer with helpful info
        const SizedBox(height: 16),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Icon(
          Icons.palette_outlined,
          size: 48,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Tajweed Color Guide',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Colors indicate different pronunciation rules',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCategory(
    BuildContext context,
    String category,
    List<TajweedColorRule> rules,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              category,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // Rules in this category
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Column(
              children: rules
                  .map((rule) => _buildLegendItem(context, rule))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, TajweedColorRule rule) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Color indicator
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: rule.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: rule.color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Code badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              rule.code.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Description
          Expanded(
            child: Text(
              rule.description,
              style: MaterialTheme.accessibleBodyStyle.copyWith(
                fontSize: 14,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'These colors follow the standard Tajweed rules used in Alquran.cloud API',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSecondaryContainer,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}