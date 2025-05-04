# Running the Flutter BLoC Starter Kit

This guide will help you set up and run the Flutter BLoC Starter Kit with its new feature-first architecture.

## Prerequisites

- Flutter SDK (latest stable version recommended)
- Dart SDK
- Android Studio / VS Code with Flutter plugins
- An emulator or physical device for testing

## Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/flutter_bloc_starter_kit.git
cd flutter_bloc_starter_kit
```

2. **Get dependencies**

```bash
flutter pub get
```

3. **Run code generation**

This project uses code generation for models and repositories, so you need to run the build_runner:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Cleanup legacy files (if needed)**

If you still have the legacy files from before the restructuring, run:

```bash
./cleanup.sh
```

5. **Run the application**

```bash
flutter run
```

## Architecture Overview

This project follows a feature-first architecture. For more details, see the [ARCHITECTURE.md](ARCHITECTURE.md) file.

## Features

- **Fruits Feature**: Browse, filter, and view details of various fruits with nutritional information
- **Taxonomy Feature**: Explore taxonomical classifications
- **Theme Feature**: Toggle between light and dark themes

## Troubleshooting

- If you encounter import errors, make sure you've run the code generation step
- If you see duplicate class definitions, run the cleanup script to remove legacy files
- For any dependency issues, try running `flutter clean` followed by `flutter pub get`
