import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);
  /// Special text style for Arabic/Islamic text
  static TextStyle get arabicTextStyle => GoogleFonts.amiri(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.8,
  );

  /// Large text style for better accessibility (30-60 age group)
  static TextStyle get accessibleBodyStyle => GoogleFonts.notoSans(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 1);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1b6b51),
      surfaceTint: Color(0xff1b6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa6f2d1),
      onPrimaryContainer: Color(0xff00513b),
      secondary: Color(0xff725c0c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe088),
      onSecondaryContainer: Color(0xff574500),
      tertiary: Color(0xff8c4f27),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdbc9),
      onTertiaryContainer: Color(0xff6f3812),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff171d1a),
      onSurfaceVariant: Color(0xff404944),
      outline: Color(0xff707974),
      outlineVariant: Color(0xffbfc9c2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inversePrimary: Color(0xff8bd6b6),
      primaryFixed: Color(0xffa6f2d1),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8bd6b6),
      onPrimaryFixedVariant: Color(0xff00513b),
      secondaryFixed: Color(0xffffe088),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574500),
      tertiaryFixed: Color(0xffffdbc9),
      onTertiaryFixed: Color(0xff321200),
      tertiaryFixedDim: Color(0xffffb68c),
      onTertiaryFixedVariant: Color(0xff6f3812),
      surfaceDim: Color(0xffd6dbd6),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae4),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f2d),
      surfaceTint: Color(0xff1b6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2e7a5f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff433400),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff826a1c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5a2803),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9d5d34),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff0d1210),
      onSurfaceVariant: Color(0xff2f3834),
      outline: Color(0xff4b554f),
      outlineVariant: Color(0xff666f6a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inversePrimary: Color(0xff8bd6b6),
      primaryFixed: Color(0xff2e7a5f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff096148),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff826a1c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff685200),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9d5d34),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff80451f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c8c3),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe4eae4),
      surfaceContainerHigh: Color(0xffd8ded9),
      surfaceContainerHighest: Color(0xffcdd3ce),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003324),
      surfaceTint: Color(0xff1b6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00543d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff372b00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5a4700),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4c1f00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff723a14),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e2a),
      outlineVariant: Color(0xff424b46),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inversePrimary: Color(0xff8bd6b6),
      primaryFixed: Color(0xff00543d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003b2a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5a4700),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f3100),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff723a14),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff562401),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab5),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2ed),
      surfaceContainer: Color(0xffdee4df),
      surfaceContainerHigh: Color(0xffd0d6d1),
      surfaceContainerHighest: Color(0xffc2c8c3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bd6b6),
      surfaceTint: Color(0xff8bd6b6),
      onPrimary: Color(0xff003828),
      primaryContainer: Color(0xff00513b),
      onPrimaryContainer: Color(0xffa6f2d1),
      secondary: Color(0xffe2c46d),
      onSecondary: Color(0xff3c2f00),
      secondaryContainer: Color(0xff574500),
      onSecondaryContainer: Color(0xffffe088),
      tertiary: Color(0xffffb68c),
      onTertiary: Color(0xff532200),
      tertiaryContainer: Color(0xff6f3812),
      onTertiaryContainer: Color(0xffffdbc9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffdee4df),
      onSurfaceVariant: Color(0xffbfc9c2),
      outline: Color(0xff89938d),
      outlineVariant: Color(0xff404944),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff1b6b51),
      primaryFixed: Color(0xffa6f2d1),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8bd6b6),
      onPrimaryFixedVariant: Color(0xff00513b),
      secondaryFixed: Color(0xffffe088),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574500),
      tertiaryFixed: Color(0xffffdbc9),
      onTertiaryFixed: Color(0xff321200),
      tertiaryFixedDim: Color(0xffffb68c),
      onTertiaryFixedVariant: Color(0xff6f3812),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa0eccb),
      surfaceTint: Color(0xff8bd6b6),
      onPrimary: Color(0xff002c1f),
      primaryContainer: Color(0xff559e82),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff9da80),
      onSecondary: Color(0xff302400),
      secondaryContainer: Color(0xffa98e3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd3bc),
      onTertiary: Color(0xff421a00),
      tertiaryContainer: Color(0xffc77f54),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dfd8),
      outline: Color(0xffabb4ae),
      outlineVariant: Color(0xff89938d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff00533c),
      primaryFixed: Color(0xffa6f2d1),
      onPrimaryFixed: Color(0xff00150d),
      primaryFixedDim: Color(0xff8bd6b6),
      onPrimaryFixedVariant: Color(0xff003f2d),
      secondaryFixed: Color(0xffffe088),
      onSecondaryFixed: Color(0xff171000),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff433400),
      tertiaryFixed: Color(0xffffdbc9),
      onTertiaryFixed: Color(0xff220a00),
      tertiaryFixedDim: Color(0xffffb68c),
      onTertiaryFixedVariant: Color(0xff5a2803),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff404642),
      surfaceContainerLowest: Color(0xff040806),
      surfaceContainerLow: Color(0xff191f1c),
      surfaceContainer: Color(0xff232926),
      surfaceContainerHigh: Color(0xff2e3431),
      surfaceContainerHighest: Color(0xff393f3c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb7ffe0),
      surfaceTint: Color(0xff8bd6b6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff87d2b2),
      onPrimaryContainer: Color(0xff000e08),
      secondary: Color(0xffffefc9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffdec069),
      onSecondaryContainer: Color(0xff100b00),
      tertiary: Color(0xffffece4),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffb183),
      onTertiaryContainer: Color(0xff190600),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f2eb),
      outlineVariant: Color(0xffbbc5be),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inversePrimary: Color(0xff00533c),
      primaryFixed: Color(0xffa6f2d1),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8bd6b6),
      onPrimaryFixedVariant: Color(0xff00150d),
      secondaryFixed: Color(0xffffe088),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff171000),
      tertiaryFixed: Color(0xffffdbc9),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb68c),
      onTertiaryFixedVariant: Color(0xff220a00),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff4b514e),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b211e),
      surfaceContainer: Color(0xff2c322e),
      surfaceContainerHigh: Color(0xff373d39),
      surfaceContainerHighest: Color(0xff424845),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
