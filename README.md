# Multi-Package Flutter Sample

A modular Flutter project demonstrating a multi-package architecture using Melos. This project follows clean architecture principles, separating features and infrastructure into independent, reusable packages.

[中文文档 (README_CN.md)](./README_CN.md)

---

## Project Structure

The workspace is managed by [Melos](https://melos.invert.dev/) and organized into three main directories:

```text
.
├── app                  # Main application entry point
├── features             # Business feature modules
│   ├── auth             # Authentication (Login/Register)
│   ├── home             # Main dashboard/home screen
│   ├── message          # Messaging/Notifications
│   ├── profile          # User profile and settings
│   └── splash           # App launch/startup flow
└── infrastructure       # Core shared libraries
    ├── common           # Shared utilities and constants
    ├── network          # Dio-based network layer
    └── session          # Local storage and session management
```

---

## Architecture: API & Impl Separation

Each feature module in this project is split into two packages: `api` and `impl`. This design choice provides several key benefits:

1.  **Decoupling**: Other modules depend only on the `api` (interfaces), making the internal implementation details of a feature hidden and easily swappable.
2.  **Compilation Efficiency**: Changes to the concrete implementation (`impl`) do not require recompilation of modules that depend on the interface (`api`), significantly speeding up incremental builds.
3.  **Dependency Isolation**: The `api` package remains extremely lightweight with minimal dependencies. This prevents "dependency bloat" where a small module inadvertently inherits massive transitive dependencies.
4.  **Simplified Testing**: Mocking feature behavior for unit or integration tests is straightforward—you simply provide a mock implementation of the defined interface.

---

## MVI Architecture & Repository Pattern

This project implements a Model-View-Intent (MVI) architecture using `flutter_bloc` and `freezed` to ensure a unidirectional data flow and predictable state management. 

1. **Intent**: UI components dispatch `MviIntent`s (user actions or lifecyle events) to the Cubit.
2. **Model (State)**: The Cubit processes the intent, updates the immutable result using `MviViewState` (often a `freezed` data class), and emits the new state.
3. **View**: The UI blindly renders whatever in the `MviViewState`.
4. **Single Events**: One-off UI actions (like showing a dialog, toast, or navigation) are handled via a separate `effectStream` emitting `MviSingleEvent`s, decoupled from the continuous ViewState.

### Repository Pattern & SPI (Service Provider Interface)

- **Repositories**: All Cubits interact with Repositories rather than calling network or cache utilities directly. Repositories abstract the source of data.
- **Cross-Module SPI**: We use `get_it` alongside the `api`/`impl` separation to achieve an SPI-like pattern. For example, `profile` can refresh user data by calling an `IAuthService` interface defined in `auth_api`, which is injected via `get_it` and strictly implemented in `auth_impl`. This prevents strong coupling between feature implementations.

---

## Component Details

#### `app`
The main Flutter application. It serves as the orchestrator, integrating all features and infrastructure modules. It contains minimal business logic and focuses on dependency injection (DI) configuration and top-level routing.

#### `features/`
- **`auth`**: Handles user login, registration, and authentication state.
- **`home`**: The primary user interface after login.
- **`message`**: Messaging and notification functionality.
- **`profile`**: User account management and settings.
- **`splash`**: Initial loading and navigation logic.

#### `infrastructure/`
- **`common`**: General-purpose utilities, base classes, and domain-agnostic logic.
- **`network`**: Robust network client wrapper around `dio`, with support for interceptors (e.g., auth tokens).
- **`session`**: Management of persistent user data and application state using `shared_preferences`.

---

## Code Generation (Mason)

This project uses [Mason](https://github.com/felangel/mason) to maintain architectural consistency when creating new modules.

### Generating a New Feature
To create a new feature module following the `api` + `impl` pattern, run:

```bash
mason make feature_module --name <your_feature_name>
```

This will generate the standard directory structure, `pubspec.yaml` files, and boilerplate code for your new feature.

---

## Key Features & Technologies

- **Architecture**: Multi-package workspace with interface/implementation separation.
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc).
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) and [injectable](https://pub.dev/packages/injectable).
- **Script Management**: [Melos](https://melos.invert.dev/) for cross-package commands.
- **Multi-Environment**: Support for QA and Production builds via `.env` files and `dart-define`.
- **Linting**: Strict static analysis rules defined in `all_lint_rules.yaml`.

---

## Development Guide

### Prerequisites

- [FVM](https://fvm.app/) (Project uses specific Flutter SDK version)
- [Melos](https://melos.invert.dev/) (Global install via `dart pub global activate melos`)
- [Mason](https://github.com/felangel/mason) (Global install via `dart pub global activate mason_cli`)

### Getting Started

1. **Bootstrap the project**:
   ```bash
   melos bootstrap
   ```

2. **Generate Code (DI/JSON)**:
   ```bash
   melos run generate
   ```

3. **Run Linting**:
   ```bash
   melos run lint:all
   ```

### Builds

- **Build QA APK**:
  ```bash
  melos run build:qa
  ```
- **Build Production APK**:
  ```bash
  melos run build:prod
  ```

---

## References & Acknowledgments

This project was inspired by and partially references [building-a-multi-package-project-with-flutter](https://engineer-journal.hashnode.dev/building-a-multi-package-project-with-flutter).

Special thanks to the open-source community.
