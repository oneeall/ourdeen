/// Semantic color identifiers for Tajweed rules
///
/// This enum represents the 17 distinct colors used in Tajweed notation,
/// independent of any UI framework. The actual color values are resolved
/// in the presentation layer based on the current theme (light/dark).
///
/// This keeps the domain layer pure and framework-agnostic, following
/// Domain-Driven Design principles.
///
/// The colors are organized by semantic category:
/// - Silent letters (gray variants)
/// - Prolongation rules (blue variants)
/// - Emphasis rules (red variants)
/// - Concealment rules (purple/pink variants)
/// - Merging rules (green/cyan variants)
/// - Nasal sound rules (orange variants)
enum TajweedColorType {
  // ===== SILENT LETTERS (Gray) =====
  /// Hamzat ul Wasl - gray
  hamzatUlWasl,

  /// Silent letter - gray
  silent,

  /// Lam Shamsiyyah - gray
  lamShamsiyyah,

  // ===== PROLONGATION RULES (Blue) =====
  /// Normal Prolongation (2 Vowels) - light blue
  normalProlongation,

  /// Permissible Prolongation (2,4,6 Vowels) - medium blue
  permissibleProlongation,

  /// Necessary Prolongation (6 Vowels) - dark blue
  necessaryProlongation,

  /// Obligatory Prolongation (4-5 Vowels) - medium-dark blue
  obligatoryProlongation,

  // ===== EMPHASIS RULES (Red) =====
  /// Qalaqah (Bouncing Letters) - red
  qalaqah,

  // ===== CONCEALMENT RULES (Purple/Pink) =====
  /// Ikhafa' Shafawi (With Meem) - pink
  ikhafaShafawi,

  /// Ikhafa' - purple
  ikhafa,

  // ===== MERGING RULES (Green/Cyan) =====
  /// Idgham Shafawi (With Meem) - green
  idghamShafawi,

  /// Iqlab - cyan
  iqlab,

  /// Idgham (With Ghunnah) - teal
  idghamWithGhunnah,

  /// Idgham (Without Ghunnah) - dark green
  idghamWithoutGhunnah,

  /// Idgham (Mutajanisayn) - gray (special case)
  idghamMutajanisayn,

  /// Idgham (Mutaqaribayn) - gray (special case)
  idghamMutaqaribayn,

  // ===== NASAL SOUND RULES (Orange) =====
  /// Ghunnah (Nasal Sound, 2 Vowels) - orange
  ghunnah,

  /// Fallback color for unrecognized codes
  unknown,
}

/// Extension to provide human-readable names for color types
extension TajweedColorTypeExtension on TajweedColorType {
  /// Get a human-readable name for this color type
  String get displayName {
    switch (this) {
      case TajweedColorType.hamzatUlWasl:
        return 'Hamzat ul Wasl';
      case TajweedColorType.silent:
        return 'Silent';
      case TajweedColorType.lamShamsiyyah:
        return 'Lam Shamsiyyah';
      case TajweedColorType.normalProlongation:
        return 'Normal Prolongation';
      case TajweedColorType.permissibleProlongation:
        return 'Permissible Prolongation';
      case TajweedColorType.necessaryProlongation:
        return 'Necessary Prolongation';
      case TajweedColorType.obligatoryProlongation:
        return 'Obligatory Prolongation';
      case TajweedColorType.qalaqah:
        return 'Qalaqah';
      case TajweedColorType.ikhafaShafawi:
        return 'Ikhafa\' Shafawi';
      case TajweedColorType.ikhafa:
        return 'Ikhafa\'';
      case TajweedColorType.idghamShafawi:
        return 'Idgham Shafawi';
      case TajweedColorType.iqlab:
        return 'Iqlab';
      case TajweedColorType.idghamWithGhunnah:
        return 'Idgham (With Ghunnah)';
      case TajweedColorType.idghamWithoutGhunnah:
        return 'Idgham (Without Ghunnah)';
      case TajweedColorType.idghamMutajanisayn:
        return 'Idgham (Mutajanisayn)';
      case TajweedColorType.idghamMutaqaribayn:
        return 'Idgham (Mutaqaribayn)';
      case TajweedColorType.ghunnah:
        return 'Ghunnah';
      case TajweedColorType.unknown:
        return 'Unknown';
    }
  }

  /// Get the semantic category for this color type
  String get category {
    switch (this) {
      case TajweedColorType.hamzatUlWasl:
      case TajweedColorType.silent:
      case TajweedColorType.lamShamsiyyah:
        return 'Silent Letters';

      case TajweedColorType.normalProlongation:
      case TajweedColorType.permissibleProlongation:
      case TajweedColorType.necessaryProlongation:
      case TajweedColorType.obligatoryProlongation:
        return 'Prolongation (Madd)';

      case TajweedColorType.qalaqah:
        return 'Emphasis (Qalaqah)';

      case TajweedColorType.ikhafaShafawi:
      case TajweedColorType.ikhafa:
        return 'Concealment (Ikhafa)';

      case TajweedColorType.idghamShafawi:
      case TajweedColorType.iqlab:
      case TajweedColorType.idghamWithGhunnah:
      case TajweedColorType.idghamWithoutGhunnah:
      case TajweedColorType.idghamMutajanisayn:
      case TajweedColorType.idghamMutaqaribayn:
        return 'Merging (Idgham)';

      case TajweedColorType.ghunnah:
        return 'Nasal Sound (Ghunnah)';

      case TajweedColorType.unknown:
        return 'Unknown';
    }
  }
}
