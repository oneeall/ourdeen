import 'package:flutter/material.dart';

class ArabicVerseWidget extends StatelessWidget {
  final String verseText;
  final String? translation;
  final String? reference;
  final TextStyle? verseStyle;
  final TextStyle? translationStyle;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;

  const ArabicVerseWidget({
    super.key,
    required this.verseText,
    this.translation,
    this.reference,
    this.verseStyle,
    this.translationStyle,
    this.padding,
    this.maxWidth = 600.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return RepaintBoundary(
      child: Container(
        padding: padding ?? const EdgeInsets.all(28.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth ?? 600.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Arabic verse with theme-appropriate styling
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        width: 3.0,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ), // More consistent with app theme
                    color: colorScheme.surface.withValues(
                      alpha: 0.4,
                    ), // Subtle background
                  ),
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    top: 12.0,
                    bottom: 12.0,
                  ), // Better padding
                  child: Text(
                    verseText,
                    style:
                        verseStyle ??
                        textTheme.displayMedium?.copyWith(
                          fontSize: 28.0, // Larger for cognitive clarity
                          fontFamily: 'Amiri',
                          height: 2.2, // Better readability spacing
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface, // Use theme color
                          letterSpacing: 0.8,
                          shadows:
                              Theme.of(context).brightness == Brightness.dark
                              ? [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 3,
                                  ),
                                  Shadow(
                                    color: Colors.white24,
                                    offset: Offset(0, 0),
                                    blurRadius: 4,
                                  ),
                                ]
                              : [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 3,
                                  ),
                                  Shadow(
                                    color: Colors.white70,
                                    offset: Offset(0, 0),
                                    blurRadius: 4,
                                  ),
                                ], // Slight letter spacing
                        ),
                    textAlign: TextAlign.right,
                    textScaler: const TextScaler.linear(1.0),
                  ),
                ),

                // Translation with theme-appropriate styling
                if (translation != null) ...[
                  const SizedBox(height: 20.0), // Consistent spacing
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface, // Use theme surface color
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Consistent with app theme
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      translation!,
                      style:
                          translationStyle ??
                          textTheme.bodyLarge?.copyWith(
                            fontSize: 18.0, // Maintain readability
                            color: colorScheme.onSurface.withValues(
                              alpha: 0.85,
                            ), // Use theme color
                            height: 1.6, // Enhanced readability
                            fontWeight: FontWeight
                                .w400, // Normal weight for better readability
                          ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],

                // Reference with theme-appropriate styling
                if (reference != null) ...[
                  const SizedBox(height: 16.0), // Consistent spacing
                  Align(
                    alignment: Alignment.centerLeft, // Left-align reference
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        reference!,
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 14.0, // Clear reference size
                          color: colorScheme.primary, // Use theme primary
                          fontWeight: FontWeight.w600, // Bold for hierarchy
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
