import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ourdeen/features/tajweed/domain/entities/tajweed_color_type.dart';
import 'package:ourdeen/features/tajweed/presentation/services/tajweed_color_resolver.dart';

void main() {
  group('TajweedColorResolver', () {
    test('should return different colors for light and dark themes', () {
      const colorType = TajweedColorType.normalProlongation;

      final lightColor = TajweedColorResolver.resolveColor(
        colorType,
        Brightness.light,
      );

      final darkColor = TajweedColorResolver.resolveColor(
        colorType,
        Brightness.dark,
      );

      // Colors should be different between themes
      expect(lightColor, isNot(equals(darkColor)));

      // Light theme should use the original blue
      expect(lightColor, equals(const Color(0xFF537FFF)));

      // Dark theme should use enhanced blue
      expect(darkColor, equals(const Color(0xFF7BA3FF)));
    });

    test('should return correct color for all Tajweed codes in light theme', () {
      // Test a few key codes
      expect(
        TajweedColorResolver.resolveColorForCode('n', Brightness.light),
        equals(const Color(0xFF537FFF)), // Normal Prolongation
      );

      expect(
        TajweedColorResolver.resolveColorForCode('q', Brightness.light),
        equals(const Color(0xFFDD0008)), // Qalaqah
      );

      expect(
        TajweedColorResolver.resolveColorForCode('g', Brightness.light),
        equals(const Color(0xFFFF7E1E)), // Ghunnah
      );

      expect(
        TajweedColorResolver.resolveColorForCode('h', Brightness.light),
        equals(const Color(0xFF757575)), // Hamzat ul Wasl (silent)
      );
    });

    test('should return correct color for all Tajweed codes in dark theme', () {
      // Test a few key codes
      expect(
        TajweedColorResolver.resolveColorForCode('n', Brightness.dark),
        equals(const Color(0xFF7BA3FF)), // Normal Prolongation
      );

      expect(
        TajweedColorResolver.resolveColorForCode('q', Brightness.dark),
        equals(const Color(0xFFFF5252)), // Qalaqah
      );

      expect(
        TajweedColorResolver.resolveColorForCode('g', Brightness.dark),
        equals(const Color(0xFFFFAB40)), // Ghunnah
      );

      expect(
        TajweedColorResolver.resolveColorForCode('h', Brightness.dark),
        equals(const Color(0xFFB0B0B0)), // Hamzat ul Wasl (silent)
      );
    });

    test('should return fallback color for unknown codes', () {
      const unknownCode = 'x';

      final lightColor = TajweedColorResolver.resolveColorForCode(
        unknownCode,
        Brightness.light,
      );

      final darkColor = TajweedColorResolver.resolveColorForCode(
        unknownCode,
        Brightness.dark,
      );

      expect(lightColor, equals(const Color(0xFF424242)));
      expect(darkColor, equals(const Color(0xFFE0E0E0)));
    });

    test('should return all 17 unique colors', () {
      final lightColors = TajweedColorResolver.getAllColors(Brightness.light);
      final darkColors = TajweedColorResolver.getAllColors(Brightness.dark);

      // Should have exactly 17 colors (excluding unknown)
      expect(lightColors.length, equals(18)); // 17 + unknown
      expect(darkColors.length, equals(18)); // 17 + unknown

      // All colors should be valid (not transparent)
      for (final color in lightColors.values) {
        expect(color.alpha, greaterThan(0));
      }

      for (final color in darkColors.values) {
        expect(color.alpha, greaterThan(0));
      }
    });

    test('should maintain semantic color categories', () {
      final lightColors = TajweedColorResolver.getAllColors(Brightness.light);

      // Silent letters should be gray
      expect(
        lightColors[TajweedColorType.hamzatUlWasl],
        equals(const Color(0xFF757575)),
      );
      expect(
        lightColors[TajweedColorType.silent],
        equals(const Color(0xFF757575)),
      );

      // Prolongation rules should be blue
      expect(
        lightColors[TajweedColorType.normalProlongation],
        equals(const Color(0xFF537FFF)),
      );

      // Qalaqah should be red
      expect(
        lightColors[TajweedColorType.qalaqah],
        equals(const Color(0xFFDD0008)),
      );

      // Ghunnah should be orange
      expect(
        lightColors[TajweedColorType.ghunnah],
        equals(const Color(0xFFFF7E1E)),
      );
    });
  });
}
