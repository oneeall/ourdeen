import 'package:flutter/material.dart';
import 'package:ourdeen/features/tajweed/presentation/widgets/tajweed_color_legend.dart';

/// A bottom sheet wrapper for displaying the Tajweed color legend
///
/// This widget provides a modal bottom sheet with the Tajweed color legend.
/// It includes a draggable handle, close button, and proper accessibility
/// support.
///
/// Example:
/// ```dart
/// // Show the bottom sheet
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (context) => const TajweedLegendBottomSheet(),
/// );
///
/// // Or use the convenience method
/// TajweedLegendBottomSheet.show(context);
/// ```
class TajweedLegendBottomSheet extends StatelessWidget {
  const TajweedLegendBottomSheet({super.key});

  /// Convenience method to show the bottom sheet
  ///
  /// This method provides a clean API for showing the legend without
  /// needing to call showModalBottomSheet directly.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TajweedLegendBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Drag handle and close button
          _buildHeader(context),

          // Legend content
          Expanded(
            child: const TajweedColorLegend(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          // Drag handle indicator
          Expanded(
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Close button
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Close',
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest,
              foregroundColor: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}