# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Build & Run
```bash
flutter run                    # Run the app
flutter pub get               # Install dependencies
```

### Code Generation
```bash
# Generate JSON serialization code (after modifying models with @JsonSerializable)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/core/services/alquran_cloud/alquran_cloud_service_test.dart

# Run a specific test by name
flutter test --plain-name "test name"

# Run tests with coverage
flutter test --coverage
```

### Linting
```bash
flutter analyze               # Analyze code for issues
```

## Architecture Overview

This Flutter app uses **Domain-Driven Design (DDD)** with **MVVM** and **Provider** for state management.

### Directory Structure

```
lib/
├── core/                              # Shared infrastructure (NOT business logic)
│   ├── services/                      # External services & APIs
│   │   └── alquran_cloud/            # Quran API service (clean architecture)
│   │       ├── alquran_cloud_service.dart      # Facade service
│   │       ├── data/                          # Data layer
│   │       │   ├── datasources/               # API client, cache
│   │       │   ├── models/                   # DTOs with JSON serialization
│   │       │   └── repositories/             # Repository implementations
│   │       └── domain/                        # Domain layer
│   │           ├── entities/                 # Domain entities
│   │           └── repositories/             # Repository interfaces
│   ├── theme/                        # App theming (colors, text styles)
│   └── widgets/                      # Shared UI widgets
│
├── features/                          # Feature-based modules (business logic)
│   ├── shared/                       # Cross-feature shared code
│   │   ├── base_viewmodel.dart       # Base ViewModel with busy state
│   │   └── providers.dart            # DI container (all Provider setup)
│   │
│   ├── quran_reader/                # Quran reading feature
│   ├── memorizing/                  # Gamified memorization feature
│   └── counter/                     # Example feature
│
└── main.dart                         # App entry point
```

### Key Architecture Concepts

**Core vs Features:**
- `core/` = Technical infrastructure (API clients, theme, shared utilities)
- `features/` = Business domain logic (Quran reading, memorization, etc.)

**Three-Layer Pattern (within each feature):**
1. **Data Layer** (`data/`): Repository implementations, DTOs
2. **Domain Layer** (`domain/`): Entities, repository interfaces, use cases
3. **Presentation Layer** (`presentation/`): ViewModels, Views

**Dependency Flow:** Presentation → Domain ← Data
- Inner layers (domain) must NOT depend on outer layers (data, presentation)
- Domain layer has NO Flutter dependencies

### State Management with Provider

All dependencies are wired in `lib/features/shared/providers.dart`:

```dart
AlquranCloudProvider              // API service (root level)
  └── MultiProvider
      ├── Provider<Repository>    // Repository interface
      ├── Provider<UseCase>        // Use cases depend on repository
      └── ChangeNotifierProvider<ViewModel>  // ViewModel uses use cases
```

**Key Pattern:** ViewModels call Use Cases → Use Cases call Repository Interface → Repository Implementation accesses data

### BaseViewModel

All ViewModels extend `BaseViewModel` which provides:
- `isBusy` getter and `setBusy(bool)` method for loading states
- Extends `ChangeNotifier` for Provider integration

### Alquran.cloud API Service

The Quran API service follows clean architecture:

- **Facade**: `AlquranCloudService` provides convenient methods for features
- **Repository Interface**: `AlquranCloudRepository` (domain layer)
- **Repository Implementation**: `AlquranCloudRepositoryImpl` with cache-first strategy
- **API Client**: `AlquranCloudApi` handles HTTP requests
- **Cache**: `AlquranCloudCache` uses SharedPreferences with TTL

**Cache TTL Strategy** (`lib/core/services/alquran_cloud/data/repositories/cache_strategy.dart`):
- Editions/Surahs: 30 days (rarely changes)
- Quran/Juz/Page: 7 days (static groupings)
- Individual Surah/Ayah: 1 day
- Search: 1 hour (user-generated)

**Important:** When adding new API endpoints:
1. Add entity to `domain/entities/`
2. Add model to `data/models/` with `@JsonSerializable()`
3. Add method to `domain/repositories/alquran_cloud_repository.dart`
4. Implement in `data/repositories/alquran_cloud_repository_impl.dart`
5. Add convenience method to `alquran_cloud_service.dart`
6. Run `flutter pub run build_runner build --delete-conflicting-outputs`

### Value Objects

Domain objects that are defined by their values (not identity) and should be immutable:
- Use `Equatable` for value equality
- Provide `copyWith()` method for creating updated instances
- Examples: `MemorizationMetrics` (see `lib/features/memorizing/domain/entities/VALUE_OBJECT_LEARNING.md`)

### Testing Notes

- Unit tests use real network calls (no mocking) for API integration tests
- Tests are located at `test/core/services/` for core services
- Test files mirror the lib structure: `test/core/services/alquran_cloud/alquran_cloud_service_test.dart`

## Important Implementation Details

### JSON Serialization

Models use `json_serializable` package. After modifying any model:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### AyahModel Edition Field

The `edition` field in `AyahModel` is nullable (`EditionModel?`) because the API doesn't always return edition data for ayahs (e.g., when fetching a surah). The `toEntity()` method provides a default edition when null.

### Repository Pattern

All data access goes through repositories:
- Domain layer defines repository **interfaces** (abstract contracts)
- Data layer provides repository **implementations**
- This allows swapping data sources without affecting business logic

### Cache-First Strategy

The `AlquranCloudRepositoryImpl` checks cache before making API calls. Cache keys follow the pattern `alquran_{resource}_{identifier}` (see `CacheKeys` class).

## Features Overview

### Memorizing Feature

Gamified Quran memorization with progress tracking, streaks, and session management.

**Key Files:**
- `lib/features/memorizing/presentation/views/memorizing_view.dart` - Main dashboard
- `lib/features/memorizing/domain/usecases/calculate_memorization_metrics_usecase.dart` - Metrics calculation
- `lib/features/memorizing/domain/entities/memorization_metrics.dart` - Value object for metrics

**Documentation:** See `lib/features/memorizing/README.md` for detailed workflow and architecture.

### Quran Reader Feature

Clean, minimalist interface for reading Quran verses with proper Arabic typography.

### Counter Feature

Example feature demonstrating the DDD+MVVM pattern. Use as reference when adding new features.
