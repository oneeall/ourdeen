# Ourdeen

A Flutter project implementing Domain-Driven Design (DDD) with MVVM architecture and Provider for state management.

## New Architecture

This project now follows a feature-based organization with Domain-Driven Design (DDD) and MVVM (Model-View-ViewModel) for the presentation layer:

```
lib/
├── core/                     # Shared utilities, constants, and base classes | These are truly universal
│   ├── constants/             # App-wide constants
│   ├── exceptions/            # Custom exceptions
│   ├── extensions/            # Dart extensions
│   ├── utils/                # Utility functions
│   ├── widgets/              # Reusable UI components
│   └── models/               # Models for used everywhere like base_response_model.dart, pagination_model.dart, api_error_model.dart, etc
│   └── providers.dart        # Dependency injection setup
├── features/                  # Feature-based modules (each feature is self-contained)
│   ├── counter/              # Example feature module
│   │   ├── data/             # Data layer for this feature
│   │   │   ├── models/       # Data models (DTOs)
│   │   │   └── repositories/ # Repository implementations
│   │   ├── domain/           # Domain layer for this feature
│   │   │   ├── entities/     # Domain entities
│   │   │   ├── repositories/ # Repository interfaces
│   │   │   └── usecases/     # Business use cases
│   │   └── presentation/     # Presentation layer for this feature
│   │       ├── viewmodels/   # View models
│   │       └── views/        # UI components
│   ├── shared/              # These are shared business concepts
│   │   ├── data/             # Data layer for this feature
│   │   │   ├── models/       # Data models (DTOs) like user_model.dart, product_model.dart, order_model.dart, profile_model.dart, etc
│   └── ...                   # Other features
└── main.dart                 # App entry point
```

### Key Differences 

**ASPECT            CORE MODELS              FEATURES/SHARED MODELS**
Purpose             Technical/Infrastructure Business Domain
Scope               Entire application       Multiple business features
Change Frequency    Rarely changes           Changes with business rules
Ownership           Platform team            Product/Feature teams


### Key Improvements

1. **Feature-Based Organization**:
   - Grouped related code by features rather than layers
   - Each feature is a self-contained module with its own data/domain/presentation layers
   - Easier for new developers to understand and navigate

2. **Clear Separation of Concerns**:
   - Shared components that are used across features go in `shared/`
   - Feature-specific logic stays within its respective feature module

3. **Simplified Onboarding**:
   - New developers can focus on one feature at a time
   - Each feature follows the same internal structure
   - Documentation can be feature-specific

4. **Better Maintainability**:
   - Changes to one feature have minimal impact on others
   - Easier to test features in isolation
   - Clear boundaries between components

## Layer Details

### Core Layer
Technical infrastructure models (API responses, errors, pagination)

### Feature/Shared Layer
Each feature contains three sub-layers:

1. **Data Layer**: Implements data access with concrete repository implementations and data models (DTOs)
2. **Domain Layer**: Contains business logic, domain entities, repository interfaces, and use cases
3. **Presentation Layer**: Implements the UI (Views) and presentation logic (ViewModels)

### State Management

This project uses the Provider package for state management, following the MVVM pattern where:
- Views are in `features/[feature]/presentation/views/`
- ViewModels are in `features/[feature]/presentation/viewmodels/`
- Entities are in `features/[feature]/domain/entities/`

### Dependency Injection

Dependencies are managed through Provider with a custom Providers widget that sets up all the necessary services.

## Getting Started

1. Install dependencies:
   ```
   flutter pub get
   ```

2. Run the app:
   ```
   flutter run
   ```

## Dependencies

- [Provider](https://pub.dev/packages/provider) - State management solution
- [Flutter](https://flutter.dev/) - UI toolkit

## Folder Structure Explanation

### Shared Layer
Contains shared utilities and base classes:
- `base_viewmodel.dart`: Base view model with busy state management
- `providers.dart`: MultiProvider setup for dependency injection

### Feature Layer (Business Logic)
Each feature contains the complete DDD architecture:

#### Data Layer
Handles data access and external interfaces:
- `models/`: Data Transfer Objects (DTOs) that map to external data sources
- `repositories/`: Concrete implementations of domain repository interfaces

#### Domain Layer (Business Logic)
Contains the core business logic completely independent of frameworks:
- `entities/`: Business objects with behavior (not just data holders)
- `repositories/`: Abstract interfaces (contracts) for data access
- `usecases/`: Business logic encapsulated in single-responsibility classes

#### Presentation Layer
Handles UI and user interaction:
- `viewmodels/`: Presentation logic that converts domain data for the UI
- `views/`: UI components (Widgets)

## Key Architecture Principles

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Dependency Rule**: Inner layers should not depend on outer layers
3. **Domain Independence**: Domain layer is pure Dart with no Flutter dependencies
4. **Separation of Models**: 
   - Domain entities (business objects)
   - Data models (DTOs for external data sources)
5. **Single Responsibility**: Each class has one clear purpose
6. **Testability**: Business logic is separated from UI concerns

## Data Flow

1. **UI Event**: User interacts with the View
2. **View**: Calls method on ViewModel
3. **ViewModel**: Executes appropriate Use Case
4. **Use Case**: Calls Repository interface
5. **Repository Implementation**: Accesses data source
6. **Data Source**: Returns data
7. **Repository Implementation**: Maps data to domain entities
8. **Use Case**: Returns result to ViewModel
9. **ViewModel**: Updates state and notifies listeners
10. **View**: Automatically updates via Provider