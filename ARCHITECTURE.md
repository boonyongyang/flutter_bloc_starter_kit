# Feature-First Architecture

This project follows a **feature-first architecture** with clean architecture principles, organized as follows:

```
lib/
  ├── core/                 # Core functionality used across features
  │   ├── config/           # App configuration
  │   ├── constants/        # Constants used throughout the app
  │   ├── di/               # Dependency injection (service locator)
  │   ├── network/          # Network clients and configurations
  │   ├── providers/        # App-wide providers
  │   ├── routes/           # App routing
  │   ├── storage/          # Local storage implementations
  │   ├── style/            # Global styles, colors, themes
  │   └── utils/            # Utility functions
  │
  ├── features/             # Feature modules
  │   ├── fruits/           # Fruits feature
  │   │   ├── bloc/         # BLoC/Cubit state management 
  │   │   ├── data/         # Data sources and repositories
  │   │   ├── models/       # Feature-specific models
  │   │   └── presentation/ # UI components
  │   │       ├── pages/    # Feature screens
  │   │       └── widgets/  # Feature-specific widgets
  │   │
  │   ├── taxonomy/         # Taxonomy feature
  │   │   ├── bloc/
  │   │   ├── data/
  │   │   ├── models/
  │   │   └── presentation/
  │   │
  │   └── theme/           # Theme feature
  │       ├── bloc/
  │       ├── data/
  │       └── models/
  │
  └── main.dart            # Application entry point
```

## Feature Modules

### Fruits Feature
Demonstrates fetching and displaying a list of fruits with filtering, detailed views, and visualization of nutritional data.

### Taxonomy Feature
Shows how to manage and display taxonomical data with proper categorization and relationships.

### Theme Feature
Handles app-wide theme management with support for light and dark modes.

## Project Structure Rationale

The feature-first architecture was chosen because:

1. **Scalability**: As the app grows, new features can be added without affecting existing ones
2. **Team Collaboration**: Different teams can work on different features with minimal conflicts
3. **Maintainability**: Related code is located together, making it easier to understand and modify
4. **Testing**: Features can be tested in isolation
5. **Reusability**: Features can potentially be reused across different apps
