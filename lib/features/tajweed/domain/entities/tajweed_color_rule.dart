import 'package:equatable/equatable.dart';
import 'tajweed_color_type.dart';

/// Value object representing a Tajweed color coding rule
///
/// This entity encapsulates the mapping between Tajweed rule codes,
/// their descriptions, and their visual representation (semantic color type).
/// It follows the Value Object pattern - instances are immutable
/// and defined by their values, not identity.
///
/// This domain entity is framework-agnostic and does NOT depend on Flutter's Color class.
/// The actual color values are resolved in the presentation layer by TajweedColorResolver.
///
/// Example:
/// ```dart
/// final rule = TajweedColorRule(
///   code: 'n',
///   description: 'Normal Prolongation (2 Vowels)',
///   colorType: TajweedColorType.normalProlongation,
/// );
/// ```
class TajweedColorRule extends Equatable {
  /// The single-letter code used in the Tajweed text markup
  /// Examples: 'n', 'm', 'q', 'g', etc.
  final String code;

  /// Human-readable description of the Tajweed rule
  /// This should be clear and concise for users
  final String description;

  /// The semantic color type used to identify which color to use
  /// The actual color values are resolved in the presentation layer
  /// based on the current theme (light/dark mode).
  final TajweedColorType colorType;

  const TajweedColorRule({
    required this.code,
    required this.description,
    required this.colorType,
  });

  /// Creates a copy with modified fields
  ///
  /// Useful for updating individual properties while maintaining
  /// immutability of the original instance.
  TajweedColorRule copyWith({
    String? code,
    String? description,
    TajweedColorType? colorType,
  }) {
    return TajweedColorRule(
      code: code ?? this.code,
      description: description ?? this.description,
      colorType: colorType ?? this.colorType,
    );
  }

  @override
  List<Object?> get props => [code, description, colorType];

  @override
  String toString() {
    return 'TajweedColorRule(code: $code, description: $description, colorType: $colorType)';
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
///
/// Note: This domain entity uses semantic color types (TajweedColorType)
/// instead of Flutter Color objects. The actual color values are resolved
/// in the presentation layer by TajweedColorResolver.
class TajweedColorRules {
  TajweedColorRules._();

  /// Silent letters - shown in gray
  /// These letters are not pronounced in recitation
  static const List<TajweedColorRule> silentRules = [
    TajweedColorRule(
      code: 'h',
      description: 'Hamzat ul Wasl',
      colorType: TajweedColorType.hamzatUlWasl,
    ),
    TajweedColorRule(
      code: 's',
      description: 'Silent',
      colorType: TajweedColorType.silent,
    ),
    TajweedColorRule(
      code: 'l',
      description: 'Lam Shamsiyyah',
      colorType: TajweedColorType.lamShamsiyyah,
    ),
  ];

  /// Prolongation (Madd) rules - shown in shades of blue
  /// These indicate how long to extend vowel sounds
  static const List<TajweedColorRule> prolongationRules = [
    TajweedColorRule(
      code: 'n',
      description: 'Normal Prolongation (2 Vowels)',
      colorType: TajweedColorType.normalProlongation,
    ),
    TajweedColorRule(
      code: 'p',
      description: 'Permissible Prolongation (2,4,6 Vowels)',
      colorType: TajweedColorType.permissibleProlongation,
    ),
    TajweedColorRule(
      code: 'm',
      description: 'Necessary Prolongation (6 Vowels)',
      colorType: TajweedColorType.necessaryProlongation,
    ),
    TajweedColorRule(
      code: 'o',
      description: 'Obligatory Prolongation (4-5 Vowels)',
      colorType: TajweedColorType.obligatoryProlongation,
    ),
  ];

  /// Qalaqah rules - shown in red
  /// Bouncing letters that require emphasis
  static const List<TajweedColorRule> qalaqahRules = [
    TajweedColorRule(
      code: 'q',
      description: 'Qalaqah (Bouncing Letters)',
      colorType: TajweedColorType.qalaqah,
    ),
  ];

  /// Ikhafa rules - shown in shades of purple/pink
  /// Concealing the pronunciation of noon sakina
  static const List<TajweedColorRule> ikhafaRules = [
    TajweedColorRule(
      code: 'c',
      description: 'Ikhafa\' Shafawi (With Meem)',
      colorType: TajweedColorType.ikhafaShafawi,
    ),
    TajweedColorRule(
      code: 'f',
      description: 'Ikhafa\'',
      colorType: TajweedColorType.ikhafa,
    ),
  ];

  /// Idgham rules - shown in shades of green
  /// Merging or assimilating letters
  static const List<TajweedColorRule> idghamRules = [
    TajweedColorRule(
      code: 'w',
      description: 'Idgham Shafawi (With Meem)',
      colorType: TajweedColorType.idghamShafawi,
    ),
    TajweedColorRule(
      code: 'i',
      description: 'Iqlab',
      colorType: TajweedColorType.iqlab,
    ),
    TajweedColorRule(
      code: 'a',
      description: 'Idgham (With Ghunnah)',
      colorType: TajweedColorType.idghamWithGhunnah,
    ),
    TajweedColorRule(
      code: 'u',
      description: 'Idgham (Without Ghunnah)',
      colorType: TajweedColorType.idghamWithoutGhunnah,
    ),
    TajweedColorRule(
      code: 'd',
      description: 'Idgham (Mutajanisayn)',
      colorType: TajweedColorType.idghamMutajanisayn,
    ),
    TajweedColorRule(
      code: 'b',
      description: 'Idgham (Mutaqaribayn)',
      colorType: TajweedColorType.idghamMutaqaribayn,
    ),
  ];

  /// Ghunnah rule - shown in orange
  /// Nasal sound resonance
  static const List<TajweedColorRule> ghunnahRules = [
    TajweedColorRule(
      code: 'g',
      description: 'Ghunnah (Nasal Sound, 2 Vowels)',
      colorType: TajweedColorType.ghunnah,
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

  /// Get color type for a specific code
  ///
  /// Returns TajweedColorType.unknown as a fallback for unrecognized codes.
  /// Note: This returns the semantic color type. Use TajweedColorResolver
  /// in the presentation layer to get the actual Color value.
  static TajweedColorType getColorTypeForCode(String code) {
    return findByCode(code)?.colorType ?? TajweedColorType.unknown;
  }
}