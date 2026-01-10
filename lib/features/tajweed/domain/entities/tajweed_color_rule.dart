import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Value object representing a Tajweed color coding rule
///
/// This entity encapsulates the mapping between Tajweed rule codes,
/// their descriptions, and their visual representation (color).
/// It follows the Value Object pattern - instances are immutable
/// and defined by their values, not identity.
///
/// Example:
/// ```dart
/// final rule = TajweedColorRule(
///   code: 'n',
///   description: 'Normal Prolongation (2 Vowels)',
///   color: Color(0xFF537FFF),
/// );
/// ```
class TajweedColorRule extends Equatable {
  /// The single-letter code used in the Tajweed text markup
  /// Examples: 'n', 'm', 'q', 'g', etc.
  final String code;

  /// Human-readable description of the Tajweed rule
  /// This should be clear and concise for users
  final String description;

  /// The color used to highlight text following this rule
  /// Matches the colors used in the Tajweed API response
  final Color color;

  const TajweedColorRule({
    required this.code,
    required this.description,
    required this.color,
  });

  /// Creates a copy with modified fields
  ///
  /// Useful for updating individual properties while maintaining
  /// immutability of the original instance.
  TajweedColorRule copyWith({
    String? code,
    String? description,
    Color? color,
  }) {
    return TajweedColorRule(
      code: code ?? this.code,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [code, description, color];

  @override
  String toString() {
    return 'TajweedColorRule(code: $code, description: $description, color: $color)';
  }
}

/// Collection of all Tajweed color rules
///
/// This is the single source of truth for Tajweed color mappings
/// across the application. Any changes to colors or descriptions
/// should be made here.
///
/// The colors match the Alquran.cloud API's Tajweed edition:
/// - https://alquran.cloud/api/Tajweed
///
/// Rules are organized into logical groups for better presentation:
/// 1. Silent letters (gray)
/// 2. Prolongation rules (blues)
/// 3. Qalaqah (red)
/// 4. Ikhafa rules (purples)
/// 5. Idgham rules (greens)
/// 6. Ghunnah (orange)
class TajweedColorRules {
  TajweedColorRules._();

  /// Silent letters - shown in gray
  /// These letters are not pronounced in recitation
  static const List<TajweedColorRule> silentRules = [
    TajweedColorRule(
      code: 'h',
      description: 'Hamzat ul Wasl',
      color: Color(0xFFAAAAAA),
    ),
    TajweedColorRule(
      code: 's',
      description: 'Silent',
      color: Color(0xFFAAAAAA),
    ),
    TajweedColorRule(
      code: 'l',
      description: 'Lam Shamsiyyah',
      color: Color(0xFFAAAAAA),
    ),
  ];

  /// Prolongation (Madd) rules - shown in shades of blue
  /// These indicate how long to extend vowel sounds
  static const List<TajweedColorRule> prolongationRules = [
    TajweedColorRule(
      code: 'n',
      description: 'Normal Prolongation (2 Vowels)',
      color: Color(0xFF537FFF),
    ),
    TajweedColorRule(
      code: 'p',
      description: 'Permissible Prolongation (2,4,6 Vowels)',
      color: Color(0xFF4050FF),
    ),
    TajweedColorRule(
      code: 'm',
      description: 'Necessary Prolongation (6 Vowels)',
      color: Color(0xFF000EBC),
    ),
    TajweedColorRule(
      code: 'o',
      description: 'Obligatory Prolongation (4-5 Vowels)',
      color: Color(0xFF2144C1),
    ),
  ];

  /// Qalaqah rules - shown in red
  /// Bouncing letters that require emphasis
  static const List<TajweedColorRule> qalaqahRules = [
    TajweedColorRule(
      code: 'q',
      description: 'Qalaqah (Bouncing Letters)',
      color: Color(0xFFDD0008),
    ),
  ];

  /// Ikhafa rules - shown in shades of purple/pink
  /// Concealing the pronunciation of noon sakina
  static const List<TajweedColorRule> ikhafaRules = [
    TajweedColorRule(
      code: 'c',
      description: 'Ikhafa\' Shafawi (With Meem)',
      color: Color(0xFFD500B7),
    ),
    TajweedColorRule(
      code: 'f',
      description: 'Ikhafa\'',
      color: Color(0xFF9400A8),
    ),
  ];

  /// Idgham rules - shown in shades of green
  /// Merging or assimilating letters
  static const List<TajweedColorRule> idghamRules = [
    TajweedColorRule(
      code: 'w',
      description: 'Idgham Shafawi (With Meem)',
      color: Color(0xFF58B800),
    ),
    TajweedColorRule(
      code: 'i',
      description: 'Iqlab',
      color: Color(0xFF26BFFD),
    ),
    TajweedColorRule(
      code: 'a',
      description: 'Idgham (With Ghunnah)',
      color: Color(0xFF169777),
    ),
    TajweedColorRule(
      code: 'u',
      description: 'Idgham (Without Ghunnah)',
      color: Color(0xFF169200),
    ),
    TajweedColorRule(
      code: 'd',
      description: 'Idgham (Mutajanisayn)',
      color: Color(0xFFA1A1A1),
    ),
    TajweedColorRule(
      code: 'b',
      description: 'Idgham (Mutaqaribayn)',
      color: Color(0xFFA1A1A1),
    ),
  ];

  /// Ghunnah rule - shown in orange
  /// Nasal sound resonance
  static const List<TajweedColorRule> ghunnahRules = [
    TajweedColorRule(
      code: 'g',
      description: 'Ghunnah (Nasal Sound, 2 Vowels)',
      color: Color(0xFFFF7E1E),
    ),
  ];

  /// All Tajweed color rules in a single flat list
  /// Useful for lookup by code
  static const List<TajweedColorRule> allRules = [
    ...silentRules,
    ...prolongationRules,
    ...qalaqahRules,
    ...ikhafaRules,
    ...idghamRules,
    ...ghunnahRules,
  ];

  /// Rules organized by category for better presentation
  /// Useful for grouped display in UI
  static const Map<String, List<TajweedColorRule>> categorizedRules = {
    'Silent Letters': silentRules,
    'Prolongation (Madd)': prolongationRules,
    'Emphasis (Qalaqah)': qalaqahRules,
    'Concealment (Ikhafa)': ikhafaRules,
    'Merging (Idgham)': idghamRules,
    'Nasal Sound (Ghunnah)': ghunnahRules,
  };

  /// Find a rule by its code
  ///
  /// Returns null if the code is not recognized.
  /// This is useful for parsing Tajweed text and applying colors.
  static TajweedColorRule? findByCode(String code) {
    try {
      return allRules.firstWhere((rule) => rule.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Get color for a specific code
  ///
  /// Returns black as a fallback color for unrecognized codes.
  static Color getColorForCode(String code) {
    return findByCode(code)?.color ?? Colors.black;
  }
}