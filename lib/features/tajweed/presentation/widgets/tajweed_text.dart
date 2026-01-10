import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ourdeen/features/tajweed/presentation/services/tajweed_color_resolver.dart';

/// Widget that displays Tajweed-formatted Quran text with color coding
///
/// Parses Tajweed markup format `[code[content]]` and applies theme-aware colors
/// from [TajweedColorResolver] to highlight different Tajweed rules.
///
/// The colors automatically adapt to the current theme (light/dark mode)
/// while maintaining the 17 distinct colors needed for Tajweed notation.
///
/// Example:
/// ```dart
/// TajweedText(rawVerse: 'إِ[g[نّ]َا فَتَحْنَا لَكَ فَتْ[a:12625[حًا م]ُّبِينًا')
/// ```
class TajweedText extends StatelessWidget {
  const TajweedText({super.key, required this.rawVerse});

  /// The raw Tajweed text with markup tags
  /// Format: `[code[content]]` where code is a single letter (e.g., 'n', 'm', 'q')
  final String rawVerse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text.rich(
        TextSpan(
          children: _parseTajweed(context, rawVerse),
          style: GoogleFonts.amiri(
            fontSize: 28,
            height: 2.0,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  /// Parses the raw Tajweed string with tags [code[content]] into a list of TextSpans
  ///
  /// Regex matches patterns like [h[۞] or [f:9422[ة]
  /// - Group 1: The letter code (e.g., 'h', 'n')
  /// - Group 2: The content inside the brackets
  ///
  /// Colors are resolved using [TajweedColorResolver] which automatically
  /// adapts to the current theme (light/dark mode).
  List<InlineSpan> _parseTajweed(BuildContext context, String text) {
    final regex = RegExp(r'\[([a-z])(?::\d+)?\[([^\]]+)\]');

    final List<InlineSpan> spans = [];
    int lastIndex = 0;

    // Iterate through all matches
    for (final match in regex.allMatches(text)) {
      // 1. Add the text *before* this match (Plain text)
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }

      // 2. Add the text *inside* the match (Colored text)
      final String code = match.group(1)!;
      final String content = match.group(2)!;

      // Resolve the color using the theme-aware resolver
      final Color color = TajweedColorResolver.resolveCodeFromContext(
        context,
        code,
      );

      spans.add(
        TextSpan(
          text: content,
          style: TextStyle(color: color),
        ),
      );

      lastIndex = match.end;
    }

    // 3. Add any remaining text after the last match
    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return spans;
  }
}
