import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text.rich(
                      /// TODO : text scaler can be use for scale up
                      textScaler: const TextScaler.linear(1.0),
                      TextSpan(
                        children: _parseTajweed(
                          'إِ[g[نّ]َا فَتَحْنَا لَكَ فَتْ[a:12625[حًا م]ُّبِينًا',
                        ),
                        /// TODO : font can be amiri or scheherazadeNew
                        style: GoogleFonts.scheherazadeNew(
                          fontSize: 28,
                          // Adjust font size as needed
                          height: 2.2,
                          // Line height
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
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
                                ],
                        ),
                      ),
                      textAlign: TextAlign.justify,
                    ),
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

// --- PARSING LOGIC ---

/// Parses the raw string with tags [code[content]] into a list of TextSpans
List<InlineSpan> _parseTajweed(String text) {
  // Regex to match patterns like [h[۞] or [f:9422[ة]
  // Group 1: The letter code (e.g., 'h', 'n')
  // Group 2: The content inside the brackets
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

    spans.add(
      TextSpan(
        text: content,
        style: TextStyle(color: _getColorForCode(code)),
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

/// Maps the letter code to the specific Tajweed color
Color _getColorForCode(String code) {
  switch (code) {
    case 'h': // hamza-wasl
      return const Color(0xFFAAAAAA);
    case 's': // silent
      return const Color(0xFFAAAAAA);
    case 'l': // laam-shamsiyah
      return const Color(0xFFAAAAAA);
    case 'n': // madda-normal
      return const Color(0xFF537FFF);
    case 'p': // madda-permissible
      return const Color(0xFF4050FF);
    case 'm': // madda-necesssary
      return const Color(0xFF000EBC);
    case 'q': // qalaqah
      return const Color(0xFFDD0008);
    case 'o': // madda-obligatory
      return const Color(0xFF2144C1);
    case 'c': // ikhafa-shafawi
      return const Color(0xFFD500B7);
    case 'f': // ikhafa
      return const Color(0xFF9400A8);
    case 'w': // idgham-shafawi
      return const Color(0xFF58B800);
    case 'i': // iqlab
      return const Color(0xFF26BFFD);
    case 'a': // idgham-with-ghunnah
      return const Color(0xFF169777);
    case 'u': // idgham-without-ghunnah
      return const Color(0xFF169200);
    case 'd': // idgham-mutajanisayn
      return const Color(0xFFA1A1A1);
    case 'b': // idgham-mutaqaribayn
      return const Color(0xFFA1A1A1);
    case 'g': // ghunnah
      return const Color(0xFFFF7E1E);
    default:
      return Colors.black; // Fallback
  }
}

class ColorLegend extends StatelessWidget {
  const ColorLegend({super.key});

  // Data source mapped directly to your switch statement logic
  static const List<LegendItem> _items = [
    LegendItem('h', 'Hamzat ul Wasl', 0xFFAAAAAA),
    LegendItem('s', 'Silent', 0xFFAAAAAA),
    LegendItem('l', 'Lam Shamsiyyah', 0xFFAAAAAA),
    LegendItem('n', 'Normal Prolongation (2 Vowels)', 0xFF537FFF),
    LegendItem('p', 'Permissible Prolongation (2,4,6 Vowels)', 0xFF4050FF),
    LegendItem('m', 'Necessary Prolongation (6 Vowels)', 0xFF000EBC),
    LegendItem('q', 'Qalaqah', 0xFFDD0008),
    LegendItem('o', 'Obligatory Prolongation (4-5 Vowels)', 0xFF2144C1),
    LegendItem('c', 'Ikhafa\' Shafawi - With Meem', 0xFFD500B7),
    LegendItem('f', 'Ikhafa\'', 0xFF9400A8),
    LegendItem('w', 'Idgham Shafawi - With Meem', 0xFF58B800),
    LegendItem('i', 'Iqlab', 0xFF26BFFD),
    LegendItem('a', 'Idgham - With Ghunnah', 0xFF169777),
    LegendItem('u', 'Idgham - Without Ghunnah', 0xFF169200),
    LegendItem('d', 'Idgham - Mutajanisayn', 0xFFA1A1A1),
    LegendItem('b', 'Idgham - Mutaqaribayn', 0xFFA1A1A1),
    LegendItem('g', 'Ghunnah (2 Vowels)', 0xFFFF7E1E),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 12.0,
        children: _items.map((item) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(item.colorValue),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.description,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class LegendItem {
  final String code;
  final String description;
  final int colorValue;

  const LegendItem(this.code, this.description, this.colorValue);
}
