# Flutter Bloc Starter Kit

A demonstration of Flutter project architecture and best practices, showcasing how I approach building scalable Flutter applications.

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

For most applications, a domain layer adds unnecessary complexity:
- Reduces boilerplate code and development time
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

- **State Management:** `flutter_bloc`, `equatable`
- **Dependency Injection:** `get_it`
- **Routing:** `go_router`
- **Networking:** `dio`, `retrofit`
- **Local Storage:** `hive`, `flutter_secure_storage`
- **Code Generation & Models:** `freezed`, `json_serializable`
- **Environment Configuration:** `envied`
- **Localization:** `flutter_localizations`
- **Testing & Dev Tools:** `mocktail`, `flutter_lints`, `logger`
- **UI Utilities:** `shimmer`, `fl_chart`

These packages are chosen for their stability, community support, and alignment with best practices for scalable Flutter development.

These dependencies provide type safety, offline-first capabilities, and developer-friendly tooling.

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
└── main.dart               # Application entry point
```

## Sample Features
### Fruits Feature
Demonstrates fetching fruit data from an API, local caching, state management, error handling, and data visualization.

### Authentication & Theme
Basic auth flow with secure storage, route protection, and dynamic light/dark theming with persistence.

### Localization
Type-safe l10n with context extension (`context.l10n`) and `.arb` string management.  
**(🚧WIP)** Dynamic language switching, pluralization, RTL support

## Future Enhancements

**Performance:** Pagination, background sync, image caching  
**Developer Experience:** CI/CD pipeline, code generation templates  
**Production:** Crash reporting, analytics, performance monitoring  
**Architecture:** Domain layer migration for complex business rules

This project demonstrates practical Flutter development patterns, balancing simplicity with scalability for production applications.

