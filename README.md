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

### Component Details

#### `app`
The main Flutter application. It serves as the orchestrator, integrating all features and infrastructure modules. It contains minimal business logic and focuses on dependency injection (DI) configuration and top-level routing.

#### `features/`
Each feature is split into `api` (interfaces/contracts) and `impl` (concrete implementations).
- **`auth`**: Handles user login, registration, and authentication state.
- **`home`**: The primary user interface after login.
- **`message`**: Messaging and notification functionality.
- **`profile`**: User account management and settings.
- **`splash`**: Initial loading and navigation logic.

#### `infrastructure/`
Shared libraries used across the entire project.
- **`common`**: General-purpose utilities, base classes, and domain-agnostic logic.
- **`network`**: Robust network client wrapper around `dio`, with support for interceptors (e.g., auth tokens).
- **`session`**: Management of persistent user data and application state using `shared_preferences`.

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
