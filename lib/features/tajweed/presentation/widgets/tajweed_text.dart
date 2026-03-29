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
/// OPTIMIZATION: Caches parsed spans to avoid re-parsing on rebuilds.
/// Only re-parses when the text content or theme brightness changes.
///
/// Example:
/// ```dart
/// TajweedText(rawVerse: 'إِ[g[نّ]َا فَتَحْنَا لَكَ فَتْ[a:12625[حًا م]ُّبِينًا')
/// ```
class TajweedText extends StatefulWidget {
  const TajweedText({super.key, required this.rawVerse});

  /// The raw Tajweed text with markup tags
  /// Format: `[code[content]]` where code is a single letter (e.g., 'n', 'm', 'q')
  final String rawVerse;

  @override
  State<TajweedText> createState() => _TajweedTextState();
}

class _TajweedTextState extends State<TajweedText> {
  // OPTIMIZATION: Cache the parsed spans to avoid re-parsing on every rebuild
  List<InlineSpan>? _cachedSpans;
  String? _cachedText;
  Brightness? _cachedBrightness;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;

    // Check if we need to re-parse (only if text or brightness changed)
    if (_cachedSpans == null ||
        _cachedText != widget.rawVerse ||
        _cachedBrightness != brightness) {
      _cachedSpans = _parseTajweed(context, widget.rawVerse, brightness);
      _cachedText = widget.rawVerse;
      _cachedBrightness = brightness;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text.rich(
        TextSpan(
          children: _cachedSpans,
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
  ///
  /// OPTIMIZATION: Uses pre-fetched brightness to avoid calling Theme.of
  /// repeatedly during parsing.
  List<InlineSpan> _parseTajweed(
    BuildContext context,
    String text,
    Brightness brightness,
  ) {
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

      // OPTIMIZATION: Resolve color directly using brightness instead of
      // calling resolveCodeFromContext which calls Theme.of internally
      final Color color =
          TajweedColorResolver.resolveColorForCode(code, brightness);

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
