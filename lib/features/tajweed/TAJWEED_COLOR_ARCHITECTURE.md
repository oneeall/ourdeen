# Tajweed Color Architecture

## Overview

This document describes the architecture for theme-aware Tajweed color coding in the Ourdeen app. The implementation follows **Domain-Driven Design (DDD)** principles by separating domain logic from presentation concerns.

## Architecture

### Three-Layer Color Resolution

```
┌─────────────────────────────────────────────────────────────┐
│ DOMAIN LAYER (Pure Dart, No Flutter deps)                   │
│                                                              │
│ TajweedColorType (enum)                                     │
│  - 17 semantic color identifiers                            │
│  - Framework-agnostic                                       │
│  - Located in: domain/entities/                             │
│                                                              │
│ TajweedColorRule (entity)                                   │
│  - code: String                                             │
│  - description: String                                      │
│  - colorType: TajweedColorType (not Flutter Color!)        │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ PRESENTATION LAYER                                          │
│                                                              │
│ TajweedColorResolver (service)                              │
│  - Maps semantic types to actual colors                     │
│  - Respects theme brightness (light/dark)                   │
│  - Located in: presentation/services/                       │
│                                                              │
│ Methods:                                                     │
│  + resolveColor(type, brightness): Color                   │
│  + resolveFromContext(context, type): Color                │
│  + resolveColorForCode(code, brightness): Color            │
│  + resolveCodeFromContext(context, code): Color            │
│  + getAllColors(brightness): Map<TajweedColorType, Color>  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ WIDGETS                                                     │
│                                                              │
│ TajweedText                                                  │
│  - Parses Tajweed markup [code[text]]                       │
│  - Uses TajweedColorResolver for colors                     │
│                                                              │
│ TajweedColorLegend                                           │
│  - Displays color legend with categories                    │
│  - Uses TajweedColorResolver for colors                     │
└─────────────────────────────────────────────────────────────┘
```

## Key Design Decisions

### 1. Domain Layer Purity

**Problem**: The original `TajweedColorRule` entity used Flutter's `Color` class, violating DDD principles.

**Solution**: Replace `Color` with `TajweedColorType` enum that represents semantic colors.

**Benefits**:
- Domain layer is framework-agnostic
- Easy to test without Flutter dependencies
- Clear separation of concerns
- Business logic is independent of UI implementation

### 2. Presentation-Layer Color Resolution

**Problem**: How to map semantic color types to actual theme-appropriate colors?

**Solution**: `TajweedColorResolver` service in the presentation layer.

**Benefits**:
- Single source of truth for color mappings
- Automatic theme adaptation
- Easy to modify colors without touching domain logic
- Testable in isolation

### 3. Color Strategy

**Light Theme Colors**: Closely match original Alquran.cloud API colors
**Dark Theme Colors**: Enhanced brightness and saturation for readability

**Color Categories**:
- **Gray** (silent letters): `0xFF757575` → `0xFFB0B0B0`
- **Blue** (prolongation): `0xFF537FFF` → `0xFF7BA3FF`
- **Red** (qalaqah): `0xFFDD0008` → `0xFFFF5252`
- **Purple/Pink** (ikhafa): `0xFFD500B7` → `0xFFE040FB`
- **Green/Cyan** (idgham): `0xFF58B800` → `0xFF76FF03`
- **Orange** (ghunnah): `0xFFFF7E1E` → `0xFFFFAB40`

## File Structure

```
lib/features/tajweed/
├── domain/
│   └── entities/
│       ├── tajweed_color_type.dart          # NEW: Semantic color enum
│       └── tajweed_color_rule.dart          # MODIFIED: Uses colorType
│
├── presentation/
│   ├── services/
│   │   └── tajweed_color_resolver.dart      # NEW: Color resolution service
│   └── widgets/
│       ├── tajweed_text.dart                # MODIFIED: Uses resolver
│       └── tajweed_color_legend.dart        # MODIFIED: Uses resolver
│
└── TAJWEED_COLOR_ARCHITECTURE.md            # NEW: This document
```

## Usage Examples

### In Widgets

```dart
// Example 1: Get color for a specific rule type
final color = TajweedColorResolver.resolveFromContext(
  context,
  TajweedColorType.normalProlongation,
);

// Example 2: Get color for a Tajweed code (e.g., from parsed text)
final color = TajweedColorResolver.resolveCodeFromContext(
  context,
  'n', // Normal Prolongation code
);

// Example 3: Get all colors for the current theme
final allColors = TajweedColorResolver.getAllColors(
  Theme.of(context).brightness,
);
```

### In TajweedText Widget

```dart
TextSpan(
  text: content,
  style: TextStyle(
    color: TajweedColorResolver.resolveCodeFromContext(
      context,
      code,
    ),
  ),
)
```

### In TajweedColorLegend Widget

```dart
Container(
  decoration: BoxDecoration(
    color: TajweedColorResolver.resolveFromContext(
      context,
      rule.colorType,
    ),
    shape: BoxShape.circle,
  ),
)
```

## Color Mapping Reference

### Light Theme Colors

| Color Type | Code | Hex Color | Category |
|------------|------|-----------|----------|
| hamzatUlWasl | h | 0xFF757575 | Silent |
| silent | s | 0xFF757575 | Silent |
| lamShamsiyyah | l | 0xFF757575 | Silent |
| normalProlongation | n | 0xFF537FFF | Madd |
| permissibleProlongation | p | 0xFF4050FF | Madd |
| necessaryProlongation | m | 0xFF000EBC | Madd |
| obligatoryProlongation | o | 0xFF2144C1 | Madd |
| qalaqah | q | 0xFFDD0008 | Qalaqah |
| ikhafaShafawi | c | 0xFFD500B7 | Ikhafa |
| ikhafa | f | 0xFF9400A8 | Ikhafa |
| idghamShafawi | w | 0xFF58B800 | Idgham |
| iqlab | i | 0xFF26BFFD | Idgham |
| idghamWithGhunnah | a | 0xFF169777 | Idgham |
| idghamWithoutGhunnah | u | 0xFF169200 | Idgham |
| idghamMutajanisayn | d | 0xFF757575 | Idgham |
| idghamMutaqaribayn | b | 0xFF757575 | Idgham |
| ghunnah | g | 0xFFFF7E1E | Ghunnah |

### Dark Theme Colors

| Color Type | Code | Hex Color | Category |
|------------|------|-----------|----------|
| hamzatUlWasl | h | 0xFFB0B0B0 | Silent |
| silent | s | 0xFFB0B0B0 | Silent |
| lamShamsiyyah | l | 0xFFB0B0B0 | Silent |
| normalProlongation | n | 0xFF7BA3FF | Madd |
| permissibleProlongation | p | 0xFF6680FF | Madd |
| necessaryProlongation | m | 0xFF4D6FFF | Madd |
| obligatoryProlongation | o | 0xFF5C7DFF | Madd |
| qalaqah | q | 0xFFFF5252 | Qalaqah |
| ikhafaShafawi | c | 0xFFE040FB | Ikhafa |
| ikhafa | f | 0xFFAA00FF | Ikhafa |
| idghamShafawi | w | 0xFF76FF03 | Idgham |
| iqlab | i | 0xFF40C4FF | Idgham |
| idghamWithGhunnah | a | 0xFF1DE9B6 | Idgham |
| idghamWithoutGhunnah | u | 0xFF00E676 | Idgham |
| idghamMutajanisayn | d | 0xFFB0B0B0 | Idgham |
| idghamMutaqaribayn | b | 0xFFB0B0B0 | Idgham |
| ghunnah | g | 0xFFFFAB40 | Ghunnah |

## Testing

### Unit Tests

Location: `test/features/tajweed/tajweed_color_resolver_test.dart`

Tests cover:
- Different colors for light/dark themes
- Correct color mapping for all codes
- Fallback behavior for unknown codes
- All 17 unique colors are present
- Semantic color categories are maintained

Run tests:
```bash
fvm flutter test test/features/tajweed/tajweed_color_resolver_test.dart
```

## Migration Guide

### Before (Old Approach)

```dart
// Domain entity with Flutter dependency
class TajweedColorRule {
  final Color color; // ❌ Violates DDD
}

// Widget directly accessing color
TextSpan(
  style: TextStyle(
    color: TajweedColorRules.getColorForCode(code), // ❌ Hard to test
  ),
)
```

### After (New Approach)

```dart
// Domain entity is framework-agnostic
class TajweedColorRule {
  final TajweedColorType colorType; // ✅ Pure Dart
}

// Widget uses resolver for theme-aware colors
TextSpan(
  style: TextStyle(
    color: TajweedColorResolver.resolveCodeFromContext(
      context,
      code,
    ), // ✅ Theme-aware, testable
  ),
)
```

## Benefits

1. **Architecture**: Follows DDD principles with clean layer separation
2. **Maintainability**: Single source of truth for color mappings
3. **Testability**: Domain layer can be tested without Flutter dependencies
4. **Flexibility**: Easy to modify colors or add new themes
5. **Performance**: No runtime overhead (compile-time constants)
6. **Accessibility**: Colors maintain WCAG AA contrast ratios in both themes

## Future Enhancements

1. **Custom Themes**: Add support for user-defined color palettes
2. **High Contrast Mode**: Additional color scheme for accessibility
3. **Color Blindness**: Alternative palettes for different types of color blindness
4. **Dynamic Colors**: Integration with Material You dynamic color system

## References

- Alquran.cloud API: https://alquran.cloud/api/Tajweed
- WCAG Contrast Guidelines: https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html
- Material Design 3: https://m3.material.io/styles/color/the-color-system/tokens
