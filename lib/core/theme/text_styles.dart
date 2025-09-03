import 'package:flutter/material.dart';

class TextStyles {
  // Large display text for headers
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0.5,
  );

  // Medium display text for section titles
  static const TextStyle displayMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
    letterSpacing: 0.25,
  );

  // Small display text for subsections
  static const TextStyle displaySmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  // Headline text
  static const TextStyle headline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    height: 1.4,
  );

  // Title text for cards and list items
  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // Body text for primary content
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Body text for secondary content
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Caption text for supplementary information
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
  );

  // AppBar title
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  // Label text for form fields
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Text theme for light mode
  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: displayLarge.copyWith(color: const Color(0xFF121212)),
    displayMedium: displayMedium.copyWith(color: const Color(0xFF121212)),
    displaySmall: displaySmall.copyWith(color: const Color(0xFF121212)),
    headlineMedium: headline.copyWith(color: const Color(0xFF121212)),
    titleLarge: title.copyWith(color: const Color(0xFF121212)),
    bodyLarge: bodyLarge.copyWith(color: const Color(0xFF121212)),
    bodyMedium: bodyMedium.copyWith(color: const Color(0xFF424242)),
    bodySmall: bodySmall.copyWith(color: const Color(0xFF616161)),
    labelLarge: button.copyWith(color: const Color(0xFF121212)),
    titleSmall: label.copyWith(color: const Color(0xFF616161)),
  );

  // Text theme for dark mode
  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: displayLarge.copyWith(color: const Color(0xFFFFFFFF)),
    displayMedium: displayMedium.copyWith(color: const Color(0xFFFFFFFF)),
    displaySmall: displaySmall.copyWith(color: const Color(0xFFFFFFFF)),
    headlineMedium: headline.copyWith(color: const Color(0xFFFFFFFF)),
    titleLarge: title.copyWith(color: const Color(0xFFFFFFFF)),
    bodyLarge: bodyLarge.copyWith(color: const Color(0xFFFFFFFF)),
    bodyMedium: bodyMedium.copyWith(color: const Color(0xFFBDBDBD)),
    bodySmall: bodySmall.copyWith(color: const Color(0xFF9E9E9E)),
    labelLarge: button.copyWith(color: const Color(0xFFFFFFFF)),
    titleSmall: label.copyWith(color: const Color(0xFF9E9E9E)),
  );
}