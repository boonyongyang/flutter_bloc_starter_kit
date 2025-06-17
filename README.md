# Flutter Bloc Starter Kit

**Your go-to base template for starting new Flutter projects.**

Skip the initial setup headache and start with a solid foundation. This is the template I use when beginning any new Flutter project - it includes all the architectural decisions, package integrations, and boilerplate code you'd write anyway.

## The Problem This Solves

Starting a new Flutter project usually means:
- Setting up clean architecture from scratch
- Configuring state management (again)
- Integrating common packages like Dio, Hive, GoRouter
- Writing the same auth flow, routing, and error handling
- Setting up testing structure and CI

**This template gives you all of that out of the box.**

## What You Get

A complete starter project with real implementations of:

**Core Architecture Setup**
- Clean 2-layer architecture (Data + Presentation) already configured
- Bloc/Cubit state management with proper dependency injection
- Feature-first folder structure ready for your business logic
- Repository pattern with interfaces for easy testing

**Essential Integrations**
- **Dio + Retrofit**: Type-safe API calls with error handling
- **Hive**: Local storage with offline-first patterns
- **GoRouter**: Declarative navigation setup
- **fl_chart**: Data visualization examples
- **Build Runner**: Code generation pipeline configured

**Production-Ready Patterns**
- Authentication flow (replace with your auth provider)
- Error state management and user feedback
- Light/dark theme switching (Work In Progress)
- Responsive design foundations
- Comprehensive testing setup (unit, widget, integration)

**Sample Features** (replace with your own)
- Simple Login/logout flow
- Data listing with search and filtering
- Dashboard with interactive charts
- Settings and theme preferences

## Quick Start

```bash
# Use this template for your new project
git clone https://github.com/boonyongyang/flutter_bloc_starter_kit.git my_new_app
cd my_new_app

# Install dependencies
flutter pub get
flutter packages pub run build_runner build

# Run and see what you're starting with
flutter run
```

**What you'll see**: A working app with login, dashboard, and sample data - ready to be replaced with your actual features.

## Architecture Decisions Made For You

### 2-Layer Clean Architecture (No Domain Layer)

Most tutorials show 3-layer clean architecture. For 90% of apps, that's overkill. This template uses a practical 2-layer approach:

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  • Pages & Widgets                  │
│  • Bloc/Cubit (Business Logic)     │
│  • UI State Management             │
└─────────────────────────────────────┘
                    │
                    │ Repository Interface
                    ▼
┌─────────────────────────────────────┐
│            Data Layer               │
│  • API Services (Dio/Retrofit)     │
│  • Local Storage (Hive)            │
│  • Repository Implementations      │
│  • Data Models                     │
└─────────────────────────────────────┘
```

**Why this works for most projects:**
- Less boilerplate to maintain
- Easier for teams to understand
- Faster feature development
- You can add a domain layer later if complexity grows

**When you'd add a domain layer:**

```dart
// Simple case - stays in Cubit
class ProductsCubit extends Cubit<ProductsState> {
  void filterProducts(String category) {
    final filtered = allProducts.where((p) => p.category == category).toList();
    emit(ProductsLoaded(filtered));
  }
}

// Complex case - move to domain layer
class ProductRecommendationUseCase {
  List<Product> getRecommendations(User user) {
    // Complex algorithm considering:
    // - User purchase history
    // - Seasonal trends
    // - Inventory levels
    // - Price optimization
    // - ML-based predictions
    return _complexRecommendationLogic(user);
  }
}
```

### State Management Strategy

**Template includes both Bloc and Cubit examples:**

```dart
// Use Cubit for simple state changes
class ProductFilterCubit extends Cubit<List<Product>> {
  void filterByPrice(double maxPrice) {
    final filtered = state.where((p) => p.price <= maxPrice).toList();
    emit(filtered);
  }
}

// Use Bloc for complex flows with events
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  // Better when you need event history, side effects, etc.
}
```

### Repository Pattern Setup

The template includes working repository examples you can copy for your features:

```dart
// Interface (defined in data layer)
abstract class IProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<void> saveToFavorites(Product product);
}

// Implementation (handles API + local storage)
class ProductRepository implements IProductRepository {
  final ApiService _api;
  final LocalStorage _storage;
  
  @override
  Future<List<Product>> getProducts() async {
    // Cache-first strategy already implemented
    try {
      return await _storage.getCachedProducts();
    } catch (_) {
      final products = await _api.fetchProducts();
      await _storage.cacheProducts(products);
      return products;
    }
  }
}
```

## Customizing For Your Project

### Replace Sample Features

The template includes sample features (fruits, auth, dashboard) that demonstrate patterns. Replace these with your actual features:

```bash
# Current sample features
lib/features/
├── auth/           # Replace with your auth logic
├── fruits/         # Replace with your main feature
├── home/           # Customize dashboard
└── theme/          # Keep as-is

# Your new project structure
lib/features/
├── auth/           # Your authentication
├── products/       # Your main business feature
├── orders/         # Another business feature
├── home/           # Your dashboard
└── theme/          # Keep the theme management
```

### Update API Endpoints

Replace the sample API calls with your backend:

```dart
// In lib/core/network/api_service.dart
@RestApi(baseUrl: "https://your-api.com/")
abstract class ApiService {
  @GET("/your-endpoint")
  Future<List<YourModel>> getYourData();
}
```

### Customize Data Models

Replace sample models with your business models:

```dart
// Replace lib/features/fruits/data/models/
// With your models using the same patterns
@HiveType(typeId: 0)
class YourModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)  
  final String name;
  
  // Use the same annotation patterns for code generation
}
```

## Testing Your Features

The template includes testing examples for every layer:

```bash
# Test structure ready for your features
test/
├── features/
│   ├── auth/           # Authentication tests
│   ├── your_feature/   # Copy the test patterns
│   └── integration/    # End-to-end flows
├── core/              # Core functionality tests
└── helpers/           # Test utilities
```

## Development Workflow

### Adding New Features

1. **Copy the pattern** from existing features
2. **Replace sample data** with your models
3. **Update repository** with your API calls
4. **Modify UI** for your use case
5. **Add tests** following existing examples

### Code Generation

```bash
# Generate models, API clients, routes
flutter packages pub run build_runner build

# Watch for changes during development
flutter packages pub run build_runner watch
```

### Running Tests

```bash
flutter test                           # All tests
flutter test test/features/auth/       # Specific feature
flutter test --coverage               # With coverage
```

## Ready-to-Use Integrations

### API Client (Dio + Retrofit)
- HTTP interceptors configured
- Error handling setup
- Type-safe API calls
- Response caching

### Local Storage (Hive)
- Model adapters generated
- Offline-first patterns
- Data persistence layer

### Navigation (GoRouter)
- Route definitions
- Navigation guards
- Deep linking support

### Charts (fl_chart)
- Responsive chart examples
- Theme integration
- Data visualization patterns

## Project Structure

```
lib/
├── core/                    # Shared infrastructure
│   ├── di/                 # Dependency injection
│   ├── network/            # API configuration
│   ├── storage/            # Local storage setup
│   ├── routes/             # Navigation routes
│   └── theme/              # App theming
├── features/               # Your business features
│   ├── auth/               # Authentication (customize)
│   ├── sample_feature/     # Replace with your features
│   └── shared/             # Shared UI components
└── main.dart               # App entry point
```

## What to Build Next

This template handles the foundation. Focus on your business logic:

- Replace sample features with your app's core functionality
- Add your specific business models and API endpoints
- Customize the UI to match your brand
- Add feature-specific business rules
- Integrate with your chosen backend services

## Future Enhancements

Planned improvements to make this template even better:

**Advanced Features**
- Push notifications setup
- Deep linking configuration
- App analytics integration
- Crash reporting setup
- Performance monitoring tools

**UI/UX Improvements**
- Accessibility enhancements
- Animations and micro-interactions
- Component library expansion
- Design system documentation

**Offline-First Capabilities**
- Background sync with conflict resolution
- Offline queue for API requests
- Smart caching strategies for better performance
- Network connectivity awareness

**Developer Experience**
- VS Code snippets for common patterns
- GitHub Actions CI/CD templates
- Docker setup for consistent development
- Code generation templates for new features

