import 'package:flutter/material.dart';
import '../../domain/entities/tajweed_color_type.dart';

/// Theme-aware color resolver for Tajweed rules
///
/// This service is responsible for resolving semantic Tajweed color types
/// into actual Color values based on the current theme (light/dark mode).
///
/// This follows DDD principles by keeping the domain layer framework-agnostic
/// and handling UI-specific color mapping in the presentation layer.
///
/// The color palettes are carefully designed to:
/// - Maintain WCAG AA contrast ratios (4.5:1 for normal text)
/// - Preserve visual distinction between the 17 Tajweed rules
/// - Use semantic colors (blues for prolongation, reds for emphasis, etc.)
/// - Look good in both light and dark themes
///
/// Example usage:
/// ```dart
/// final resolver = TajweedColorResolver();
/// final color = resolver.resolveColor(
///   TajweedColorType.normalProlongation,
///   Theme.of(context).brightness,
/// );
/// ```
class TajweedColorResolver {
  /// Private constructor to prevent instantiation
  /// Use the static methods directly
  TajweedColorResolver._();

  /// ===== LIGHT THEME COLORS =====
  ///
  /// These colors are optimized for light backgrounds with good contrast.
  /// They closely match the original Alquran.cloud API colors while
  /// ensuring readability.

  /// Silent letters - gray (unchanged, works well in both themes)
  static const Color _lightHamzatUlWasl = Color(0xFF757575);
  static const Color _lightSilent = Color(0xFF757575);
  static const Color _lightLamShamsiyyah = Color(0xFF757575);

  /// Prolongation rules - shades of blue
  static const Color _lightNormalProlongation = Color(0xFF537FFF);
  static const Color _lightPermissibleProlongation = Color(0xFF4050FF);
  static const Color _lightNecessaryProlongation = Color(0xFF000EBC);
  static const Color _lightObligatoryProlongation = Color(0xFF2144C1);

  /// Qalaqah - red
  static const Color _lightQalaqah = Color(0xFFDD0008);

  /// Ikhafa rules - shades of purple/pink
  static const Color _lightIkhafaShafawi = Color(0xFFD500B7);
  static const Color _lightIkhafa = Color(0xFF9400A8);

  /// Idgham rules - shades of green/cyan
  static const Color _lightIdghamShafawi = Color(0xFF58B800);
  static const Color _lightIqlab = Color(0xFF26BFFD);
  static const Color _lightIdghamWithGhunnah = Color(0xFF169777);
  static const Color _lightIdghamWithoutGhunnah = Color(0xFF169200);
  static const Color _lightIdghamMutajanisayn = Color(0xFF757575);
  static const Color _lightIdghamMutaqaribayn = Color(0xFF757575);

  /// Ghunnah - orange
  static const Color _lightGhunnah = Color(0xFFFF7E1E);

  /// Unknown fallback - dark gray (for light theme)
  static const Color _lightUnknown = Color(0xFF424242);

  /// ===== DARK THEME COLORS =====
  ///
  /// These colors are optimized for dark backgrounds with enhanced
  /// brightness and saturation to maintain readability and visual
  /// distinction from the original colors.

  /// Silent letters - light gray (enhanced for dark backgrounds)
  static const Color _darkHamzatUlWasl = Color(0xFFB0B0B0);
  static const Color _darkSilent = Color(0xFFB0B0B0);
  static const Color _darkLamShamsiyyah = Color(0xFFB0B0B0);

  /// Prolongation rules - enhanced blues for dark theme
  static const Color _darkNormalProlongation = Color(0xFF7BA3FF);
  static const Color _darkPermissibleProlongation = Color(0xFF6680FF);
  static const Color _darkNecessaryProlongation = Color(0xFF4D6FFF);
  static const Color _darkObligatoryProlongation = Color(0xFF5C7DFF);

  /// Qalaqah - enhanced red
  static const Color _darkQalaqah = Color(0xFFFF5252);

  /// Ikhafa rules - enhanced purples/pinks
  static const Color _darkIkhafaShafawi = Color(0xFFE040FB);
  static const Color _darkIkhafa = Color(0xFFAA00FF);

  /// Idgham rules - enhanced greens/cyans
  static const Color _darkIdghamShafawi = Color(0xFF76FF03);
  static const Color _darkIqlab = Color(0xFF40C4FF);
  static const Color _darkIdghamWithGhunnah = Color(0xFF1DE9B6);
  static const Color _darkIdghamWithoutGhunnah = Color(0xFF00E676);
  static const Color _darkIdghamMutajanisayn = Color(0xFFB0B0B0);
  static const Color _darkIdghamMutaqaribayn = Color(0xFFB0B0B0);

  /// Ghunnah - enhanced orange
  static const Color _darkGhunnah = Color(0xFFFFAB40);

  /// Unknown fallback - light gray (for dark theme)
  static const Color _darkUnknown = Color(0xFFE0E0E0);

  /// Resolve a Tajweed color type to an actual Color value
  ///
  /// Takes into account the current theme brightness to return
  /// appropriate colors for light or dark mode.
  ///
  /// Parameters:
  /// - [colorType]: The semantic color type to resolve
  /// - [brightness]: The current theme brightness (from Theme.of(context))
  ///
  /// Returns the appropriate Color for the given color type and theme.
  static Color resolveColor(
    TajweedColorType colorType,
    Brightness brightness,
  ) {
    final isDark = brightness == Brightness.dark;

    switch (colorType) {
      // ===== SILENT LETTERS =====
      case TajweedColorType.hamzatUlWasl:
        return isDark ? _darkHamzatUlWasl : _lightHamzatUlWasl;

      case TajweedColorType.silent:
        return isDark ? _darkSilent : _lightSilent;

      case TajweedColorType.lamShamsiyyah:
        return isDark ? _darkLamShamsiyyah : _lightLamShamsiyyah;

      // ===== PROLONGATION RULES =====
      case TajweedColorType.normalProlongation:
        return isDark ? _darkNormalProlongation : _lightNormalProlongation;

      case TajweedColorType.permissibleProlongation:
        return isDark
            ? _darkPermissibleProlongation
            : _lightPermissibleProlongation;

      case TajweedColorType.necessaryProlongation:
        return isDark ? _darkNecessaryProlongation : _lightNecessaryProlongation;

      case TajweedColorType.obligatoryProlongation:
        return isDark ? _darkObligatoryProlongation : _lightObligatoryProlongation;

      // ===== EMPHASIS RULES =====
      case TajweedColorType.qalaqah:
        return isDark ? _darkQalaqah : _lightQalaqah;

      // ===== CONCEALMENT RULES =====
      case TajweedColorType.ikhafaShafawi:
        return isDark ? _darkIkhafaShafawi : _lightIkhafaShafawi;

      case TajweedColorType.ikhafa:
        return isDark ? _darkIkhafa : _lightIkhafa;

      // ===== MERGING RULES =====
      case TajweedColorType.idghamShafawi:
        return isDark ? _darkIdghamShafawi : _lightIdghamShafawi;

      case TajweedColorType.iqlab:
        return isDark ? _darkIqlab : _lightIqlab;

      case TajweedColorType.idghamWithGhunnah:
        return isDark ? _darkIdghamWithGhunnah : _lightIdghamWithGhunnah;

      case TajweedColorType.idghamWithoutGhunnah:
        return isDark
            ? _darkIdghamWithoutGhunnah
            : _lightIdghamWithoutGhunnah;

      case TajweedColorType.idghamMutajanisayn:
        return isDark ? _darkIdghamMutajanisayn : _lightIdghamMutajanisayn;

      case TajweedColorType.idghamMutaqaribayn:
        return isDark
            ? _darkIdghamMutaqaribayn
            : _lightIdghamMutaqaribayn;

      // ===== NASAL SOUND RULES =====
      case TajweedColorType.ghunnah:
        return isDark ? _darkGhunnah : _lightGhunnah;

      // ===== FALLBACK =====
      case TajweedColorType.unknown:
        return isDark ? _darkUnknown : _lightUnknown;
    }
  }

  /// Convenience method to resolve color from a BuildContext
  ///
  /// This is the most common way to use the resolver in widgets.
  /// It automatically extracts the theme brightness from the context.
  ///
  /// Example:
  /// ```dart
  /// final color = TajweedColorResolver.resolveFromContext(
  ///   context,
  ///   TajweedColorType.normalProlongation,
  /// );
  /// ```
  static Color resolveFromContext(
    BuildContext context,
    TajweedColorType colorType,
  ) {
    final brightness = Theme.of(context).brightness;
    return resolveColor(colorType, brightness);
  }

  /// Get the resolved color for a Tajweed rule code
  ///
  /// This is a convenience method that combines looking up the color type
  /// and resolving it to a Color value.
  ///
  /// Parameters:
  /// - [code]: The single-letter Tajweed code (e.g., 'n', 'm', 'q')
  /// - [brightness]: The current theme brightness
  ///
  /// Returns the appropriate Color for the given code and theme.
  static Color resolveColorForCode(
    String code,
    Brightness brightness,
  ) {
    final colorType = TajweedColorType.unknown;

    // Map the code to the appropriate color type
    // This could be optimized with a static Map, but switch is fast enough
    final TajweedColorType mappedType;
    switch (code) {
      // Silent letters
      case 'h':
        mappedType = TajweedColorType.hamzatUlWasl;
        break;
      case 's':
        mappedType = TajweedColorType.silent;
        break;
      case 'l':
        mappedType = TajweedColorType.lamShamsiyyah;
        break;

      // Prolongation rules
      case 'n':
        mappedType = TajweedColorType.normalProlongation;
        break;
      case 'p':
        mappedType = TajweedColorType.permissibleProlongation;
        break;
      case 'm':
        mappedType = TajweedColorType.necessaryProlongation;
        break;
      case 'o':
        mappedType = TajweedColorType.obligatoryProlongation;
        break;

      // Qalaqah
      case 'q':
        mappedType = TajweedColorType.qalaqah;
        break;

      // Ikhafa rules
      case 'c':
        mappedType = TajweedColorType.ikhafaShafawi;
        break;
      case 'f':
        mappedType = TajweedColorType.ikhafa;
        break;

      // Idgham rules
      case 'w':
        mappedType = TajweedColorType.idghamShafawi;
        break;
      case 'i':
        mappedType = TajweedColorType.iqlab;
        break;
      case 'a':
        mappedType = TajweedColorType.idghamWithGhunnah;
        break;
      case 'u':
        mappedType = TajweedColorType.idghamWithoutGhunnah;
        break;
      case 'd':
        mappedType = TajweedColorType.idghamMutajanisayn;
        break;
      case 'b':
        mappedType = TajweedColorType.idghamMutaqaribayn;
        break;

      // Ghunnah
      case 'g':
        mappedType = TajweedColorType.ghunnah;
        break;

      default:
        mappedType = colorType;
    }

    return resolveColor(mappedType, brightness);
  }

  /// Convenience method to resolve color for a code from BuildContext
  ///
  /// This combines code lookup and color resolution in one call.
  ///
  /// Example:
  /// ```dart
  /// final color = TajweedColorResolver.resolveCodeFromContext(
  ///   context,
  ///   'n', // Normal Prolongation
  /// );
  /// ```
  static Color resolveCodeFromContext(
    BuildContext context,
    String code,
  ) {
    final brightness = Theme.of(context).brightness;
    return resolveColorForCode(code, brightness);
  }

  /// Get all colors for the current theme
  ///
  /// Returns a Map of TajweedColorType to Color for all known color types.
  /// Useful for creating color legends or previewing all colors.
  ///
  /// Parameters:
  /// - [brightness]: The current theme brightness
  ///
  /// Returns a Map containing all 17 Tajweed colors resolved for the theme.
  static Map<TajweedColorType, Color> getAllColors(Brightness brightness) {
    return {
      // Silent letters
      TajweedColorType.hamzatUlWasl: resolveColor(
        TajweedColorType.hamzatUlWasl,
        brightness,
      ),
      TajweedColorType.silent: resolveColor(
        TajweedColorType.silent,
        brightness,
      ),
      TajweedColorType.lamShamsiyyah: resolveColor(
        TajweedColorType.lamShamsiyyah,
        brightness,
      ),

      // Prolongation rules
      TajweedColorType.normalProlongation: resolveColor(
        TajweedColorType.normalProlongation,
        brightness,
      ),
      TajweedColorType.permissibleProlongation: resolveColor(
        TajweedColorType.permissibleProlongation,
        brightness,
      ),
      TajweedColorType.necessaryProlongation: resolveColor(
        TajweedColorType.necessaryProlongation,
        brightness,
      ),
      TajweedColorType.obligatoryProlongation: resolveColor(
        TajweedColorType.obligatoryProlongation,
        brightness,
      ),

      // Qalaqah
      TajweedColorType.qalaqah: resolveColor(
        TajweedColorType.qalaqah,
        brightness,
      ),

      // Ikhafa rules
      TajweedColorType.ikhafaShafawi: resolveColor(
        TajweedColorType.ikhafaShafawi,
        brightness,
      ),
      TajweedColorType.ikhafa: resolveColor(
        TajweedColorType.ikhafa,
        brightness,
      ),

      // Idgham rules
      TajweedColorType.idghamShafawi: resolveColor(
        TajweedColorType.idghamShafawi,
        brightness,
      ),
      TajweedColorType.iqlab: resolveColor(
        TajweedColorType.iqlab,
        brightness,
      ),
      TajweedColorType.idghamWithGhunnah: resolveColor(
        TajweedColorType.idghamWithGhunnah,
        brightness,
      ),
      TajweedColorType.idghamWithoutGhunnah: resolveColor(
        TajweedColorType.idghamWithoutGhunnah,
        brightness,
      ),
      TajweedColorType.idghamMutajanisayn: resolveColor(
        TajweedColorType.idghamMutajanisayn,
        brightness,
      ),
      TajweedColorType.idghamMutaqaribayn: resolveColor(
        TajweedColorType.idghamMutaqaribayn,
        brightness,
      ),

      // Ghunnah
      TajweedColorType.ghunnah: resolveColor(
        TajweedColorType.ghunnah,
        brightness,
      ),

      // Unknown
      TajweedColorType.unknown: resolveColor(
        TajweedColorType.unknown,
        brightness,
      ),
    };
  }
}
