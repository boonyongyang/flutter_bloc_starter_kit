# Flutter Bloc Starter Kit

A demonstration of Flutter project architecture and best practices, showcasing how I approach building scalable Flutter applications.

## Overview

This project demonstrates my approach to Flutter development, including architectural decisions, state management patterns, and integration of essential dependencies. It serves as a practical example of clean code principles and modern Flutter development practices.

## Key Features

- **Clean Architecture**: 2-layer architecture focusing on separation of concerns
- **State Management**: BLoC/Cubit pattern with proper dependency injection
- **Type-safe APIs**: Retrofit with Dio for robust network layer
- **Local Storage**: Hive for efficient offline-first data persistence
- **Environment Management**: Type-safe environment configuration with Envied
- **Localization**: Multi-language support with proper l10n implementation
- **Testing**: Comprehensive test coverage across all layers

## Quick Start

```bash
# Clone the repository
git clone https://github.com/boonyongyang/flutter_bloc_starter_kit.git
cd flutter_bloc_starter_kit

# Set up environment variables
cp .env.example .env

# Install dependencies
flutter pub get

# Generate code (models, environment config)
flutter packages pub run build_runner build

# Run the application
flutter run
```

## Architecture Decisions

### 2-Layer Clean Architecture

This project uses a simplified 2-layer architecture instead of the traditional 3-layer approach:

```
Presentation Layer (UI + Business Logic)
├── Pages & Widgets
├── BLoC/Cubit (State Management)
└── UI State Handling

Data Layer (Data Access)
├── Repository Implementations
├── API Services (Retrofit/Dio)
├── Local Storage (Hive)
└── Data Models
```

**Why Skip the Domain Layer?**

For most applications, a domain layer adds unnecessary complexity without significant benefits:
- Reduces boilerplate code and development time
- Simpler project structure and easier onboarding
- Business logic in Cubits is sufficient for most use cases
- Can be added later when complexity genuinely requires it

### Sample Implementation: Fruits Feature

The fruits feature demonstrates the complete architecture pattern:

**Cubit (Business Logic)**
```dart
class FruitsCubit extends Cubit<FruitsState> {
  final IFruitsRepository _repository;
  
  Future<void> fetchFruits() async {
    emit(const FruitsLoading());
    try {
      final fruits = await _repository.fetchAllFruits();
      emit(FruitsLoaded(fruits));
    } catch (e) {
      emit(FruitsError(e.toString()));
    }
  }
}
```

**Repository (Data Access)**
```dart
class FruitsRepository implements IFruitsRepository {
  final FruitsApiService _apiService;
  
  @override
  Future<List<Fruit>> fetchAllFruits() async {
    return await _apiService.getAllFruits();
  }
}
```

**API Client (Network Layer)**
```dart
@RestApi(baseUrl: "https://fruityvice.com/api/")
abstract class FruitsApiService {
  factory FruitsApiService(Dio dio) = _FruitsApiService;
  
  @GET("/fruit/all")
  Future<List<Fruit>> getAllFruits();
}
```

## Key Dependencies

### Core Architecture
- **flutter_bloc**: State management with BLoC pattern
- **get_it**: Dependency injection container
- **go_router**: Declarative routing solution

### Network & Data
- **dio**: HTTP client with interceptors and error handling
- **retrofit**: Type-safe API client generation
- **hive_ce**: Lightweight, fast local database
- **json_serializable**: JSON serialization code generation
- **flutter_secure_storage**: Secure data persistence

### Environment & Configuration
- **envied**: Type-safe environment variable management
- **flutter_localizations**: Internationalization support
- **freezed**: Immutable data classes with code generation

### UI & Visualization
- **fl_chart**: Data visualization and charts
- **gap**: Consistent spacing widgets
- **shimmer**: Loading state animations

### Development Tools
- **build_runner**: Code generation automation
- **mocktail**: Mocking for unit tests
- **flutter_lints**: Code analysis and best practices
- **logger**: Structured logging with levels

These dependencies work together to provide:
- Type safety across the entire application
- Offline-first capabilities with automatic caching
- Maintainable and testable code architecture
- Developer-friendly tooling and code generation
- Secure data handling and environment management

## Environment Configuration

The project uses Envied for type-safe environment management:

```dart
// .env
ENV=dev
FRUITS_API_BASE_URL=https://fruityvice.com/api
APP_NAME=Flutter BLoC Starter Kit
LOG_LEVEL=debug

// Generated environment class
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FRUITS_API_BASE_URL')
  static const String fruitsApiBaseUrl = _Env.fruitsApiBaseUrl;
}
```

## Testing

Comprehensive testing structure covering all layers:

```bash
test/
├── features/
│   ├── fruits/
│   │   ├── data/repositories/    # Repository tests
│   │   └── presentation/bloc/    # Cubit/BLoC tests
│   └── taxonomy/
└── unit_test.dart               # Core functionality tests
```

**Running Tests**
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific feature tests
flutter test test/features/fruits/
```

## Project Structure

```
lib/
├── core/                    # Shared infrastructure
│   ├── config/             # App configuration
│   ├── di/                 # Dependency injection setup
│   ├── localization/       # L10n configuration and extensions
│   ├── network/            # API configuration
│   ├── routes/             # Navigation setup
│   ├── style/              # App theming and colors
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── auth/               # Authentication
│   ├── fruits/             # Sample feature implementation
│   ├── taxonomy/           # Local data management
│   └── theme/              # Theme switching
└── main.dart               # Application entry point
```

## Sample Features

### Fruits Feature
Demonstrates complete CRUD operations with:
- API integration using Retrofit
- Local caching with Hive
- State management with Cubit
- Error handling and loading states
- Data visualization with charts

### Authentication
Basic auth flow showing:
- Secure storage integration
- Route protection
- State persistence

### Theme Management
Dynamic theming with:
- Light/dark mode switching
- Persistent theme preferences
- **(🚧WIP)** Advanced color scheme customization
- **(🚧WIP)** System theme detection and auto-switching

### Localization
Multi-language support featuring:
- Type-safe localization with flutter_localizations
- Context extension for clean l10n access (`context.l10n`)
- Comprehensive string management in `.arb` files
- **(🚧WIP)** Dynamic language switching without app restart
- **(🚧WIP)** Pluralization and date formatting patterns
- **(🚧WIP)** RTL language support and layout adaptation

## Future Enhancements

**Performance & Optimization**
- Implementation of proper pagination for large datasets
- Background sync with conflict resolution
- Image caching and optimization strategies

**Developer Experience**
- CI/CD pipeline setup with GitHub Actions
- Code generation templates for new features
- Automated testing in CI environment

**Production Readiness**
- Crash reporting integration (Firebase Crashlytics)
- Analytics implementation (Firebase Analytics, Mixpanel)
- Performance monitoring setup

**Architecture Evolution**
- Migration to domain layer when business complexity increases
- Implementation of use cases for complex business rules
- Advanced error handling patterns

This project represents a practical approach to Flutter development, balancing simplicity with scalability, and demonstrating real-world patterns that can be applied to production applications.

