# 📌 Flutter Clean App Base

A production-ready Flutter starter template designed with **Clean Architecture**, a **feature-first structure**, and built-in support for **localization**, **theming**, and **global text scaling**.

This template provides a clean foundation for building real applications with a scalable, maintainable architecture. It includes modern best practices and a modular layout suitable for both small and enterprise-level apps.

## ✨ Features

- 🌱 **Feature-First + Clean Architecture**
- 🏛️ **BLoC / Cubit** for state management  
- 📦 **GetIt** as the service locator (DI)  
- 🎨 **Material 3** with Light, Dark, and System theme modes  
- 🌍 **Localization** (English & Persian) with system locale detection  
- 🔤 **Global text scaling** with user-controlled font size  
- 🖼️ Custom **Android & iOS launcher icons**  
- 🎞️ Modern **animated splash screen**  
- 🧩 Clean modular folder structure  

# 📸 Screenshots

Dark & Light mode, Localization (EN/FA), and Global Text Scaling

<table>
<tr>
<td align="center"><b>Light Mode</b><div style="height:1px; background:#ccc; margin:6px 0;"></div><img src="https://github.com/user-attachments/assets/0895b7ca-2571-44b4-aedf-ff65ab70e820" width="220"></td>
<td align="center"><b>Dark Mode</b><div style="height:1px; background:#ccc; margin:6px 0;"></div><img src="https://github.com/user-attachments/assets/2d66f7c7-db4c-4310-8438-3ebaefab4578" width="220"></td>
<td align="center"><b>Home Page</b><div style="height:1px; background:#ccc; margin:6px 0;"></div><img src="https://github.com/user-attachments/assets/900032a7-32f6-4db6-ae4d-7dab0be0b4af" width="220"></td>
</tr>
</table>


**Note:** You can replace the paths with your actual assets or GitHub image URLs.


# 📁 Folder Structure

A clean, scalable structure based on **Feature-First + Clean Architecture**:
```text
lib/
│
├── config/                      # Global app-level configuration
│   ├── di/                      # Dependency injection (GetIt)
│   ├── localization/            # ARB, localization cubit, delegates
│   ├── router/                  # AppRouter + route definitions
│   └── shared_prefs/            # Persistence (.gitkeep only)
│
├── theme/                       # Material 3 themes, color schemes, theme cubit
│
├── core/                        # Shared utilities across features
│   ├── constants/
│   ├── error/
│   ├── services/
│   ├── usecase/
│   ├── utils/
│   ├── extensions/              # Spacing extension lives here
│   └── widgets/                 # AppWrapper, global widgets
│
├── features/                    # Main feature modules
│   ├── feature_home/
│   ├── feature_explore/
│   └── feature_settings/
│
├── feature_shell/               # Bottom navigation + tab layout
│
└── main.dart                    # Entry point
```

**Key ideas:**

* Each feature has its own **presentation/data/domain** layers (expandable later)
* All shared logic stays under core/
* Clean separation of **UI, business logic, DI**, and **system services**

# 📦 Getting Started

**Clone the repository**

```bash
git clone https://github.com/zfarzaneh/flutter-clean-app-base.git
cd flutter-clean-app-base
```
**Install dependencies**

```bash
flutter pub get
```

**Run code generation (localization)**
```bash
flutter gen-l10n
```

**Setup DI (GetIt)**
The project uses a simple service locator.
All dependencies are registered in:
```bash
lib/config/di/locator.dart
```

Make sure **setupLocator()** is called before **runApp()**:

```bash
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const AppWrapper());
}
```
**Run the app**

```bash
flutter run
```
# 🚀 Running & Building

**📱 Run the app in debug mode**
```bash
flutter run
```

**▶️ Run with a specific device**

```bash
flutter run -d chrome
# or
flutter run -d emulator-5554
```
**🧪 Run unit & widget tests**
```bash
flutter test
```

**📦 Build release APK**
```bash
flutter build apk --release
```

**🍎 Build for iOS (requires macOS)**
```bash
flutter build ios --release
```

**🌐 Build web release**
```bash
flutter build web --release
```
## 🧱 Architecture Overview

This project follows a **Clean Architecture + Feature-First** structure, designed for scalability, readability, and long-term maintainability.

The architecture is based on four core principles:

1. **Separation of concerns**  
2. **UI independent from business logic**  
3. **Testability and clean boundaries**  
4. **Feature isolation** (modular development)

Below is an overview of each major layer:

---

### 1️⃣ Presentation Layer (UI + State Management)

Located inside:
```text
lib/features/**/presentation
```

This layer contains:

- **Pages / Screens**
- **Widgets**
- **Cubit / Bloc (application state)**
- **Localization text usage**
- **Theme-aware UI components**

The presentation layer communicates only with the **Domain layer** through UseCases or Cubits.

---

### 2️⃣ Domain Layer (Business Rules)

Located inside:
```text
lib/features/**/domain
```

This layer contains:

- **Entities**  
- **Repositories (abstract interfaces)**  
- **Use Cases** (business logic)

The domain layer is **pure Dart** — it has no dependency on Flutter or any external package.  
This allows easy testing and makes the business logic reusable.

---

### 3️⃣ Data Layer (External Sources)

Located inside:
```text
lib/features/**/data
```

It provides implementations for:

- Repository interfaces
- API clients (Dio / HTTP)
- Local storage
- Mappers & DTOs

This layer converts external data formats (JSON, responses, prefs) into **domain entities**.

---

### 4️⃣ Core Layer (Shared Code Across the App)

Located inside:
```text
lib/core
```

This contains:

- Common widgets
- Extensions (spacing, context helpers, etc.)
- Shared utilities
- Base Cubit/State classes
- App-wide wrapper (themes, localization, navigation)

Core contains everything that multiple features may reuse.

---

### 5️⃣ Config Layer (App-Wide Configuration)

Located inside:
```text
lib/config
```

This layer manages:

- **Dependency Injection (GetIt)**
- **Theme system (light/dark)**
- **Localization system (ARB + gen-l10n)**
- **Routing**
- **App color schemes**
- **Global settings**

This is where global systems live — not feature-specific logic.

---

## 🧩 Why Feature-First?

The project uses a **feature-first structure**, meaning each app module (Home, Explore, Settings, Auth, etc.) has its own:

data/
domain/
presentation/

Advantages:

- No huge “screens” folder
- Each feature is isolated and easy to maintain
- Easier onboarding for new developers
- Better testability
- Perfect for medium-to-large Flutter apps

---

## 🛠 How State Management Fits In

The project uses:

Cubit (via flutter_bloc)

- UI listens to Cubit state streams
- Cubits call repositories or use-cases
- Repositories fetch data from remote/local sources

This ensures UI stays clean and reactive.

---

## 🔌 Dependency Injection (GetIt)

All repositories, services, and cubits register in:
```text
lib/config/di/locator.dart
```

and are resolved throughout the app using:

```dart
sl<MyService>();
```
This completely removes the need for instantiating classes manually and makes unit testing easier.
### 🏁 Summary Diagram

```text
Presentation (UI, Cubit)
        ↓
     Domain (UseCases, Entities)
        ↓
       Data (API, Local)
        ↓
      External (HTTP, Prefs)
```
Each layer depends only on the layer below it — never upward.

Clean, predictable, maintainable.

### 🧪 Tests

This template currently does **not** include test files.  
A testing setup (unit, widget, and integration tests) will be added in future updates.
### 📄 License

This project is licensed under the **MIT License** – feel free to use, modify, and distribute it.

See the `LICENSE` file for details.

