# Fruits Feature

This folder contains all code related to the Fruits feature, following the recommended BLoC architecture for scalability and testability.

## Structure

- `bloc/` - Business logic components (Cubits, States)
- `data/` - Repository interfaces and implementations
- `models/` - Data models (e.g., `fruit_model.dart`)
- `presentation/` - UI widgets and pages

## BLoC Pattern
- **Cubit**: Handles state management for fruits (see `fruits_cubit.dart`).
- **State**: Represents the UI state (see `fruits_state.dart`).
- **Repository**: Abstracts data access (see `fruits_repository.dart`).

## How to Extend
- Add new Cubits/States in `bloc/` for new business logic.
- Add new widgets/pages in `presentation/`.
- Add new data sources in `data/`.

---
This structure is ideal for teaching and scaling Flutter apps using BLoC.
