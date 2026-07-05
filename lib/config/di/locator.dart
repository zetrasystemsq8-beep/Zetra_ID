/// Dependency injection configuration using GetIt.
///
/// This file exposes a global [locator] instance and a [setupLocator] function
/// that must be called before `runApp` in `main.dart`.
///
/// All application-wide services and state managers (such as [ThemeCubit]
/// and [LocalizationCubit]) are registered here in a centralized and
/// testable manner.

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/prefs_operator.dart';
import '../router/app_router.dart';
import '../theme/theme_cubit.dart';
import '../localization/localization_cubit.dart';

/// Global service locator instance.
///
/// This instance provides dependency resolution across the entire
/// application. Avoid creating additional [GetIt] instances.
final GetIt locator = GetIt.instance;

/// Configures and registers all global dependencies for the application.
///
/// This function is responsible for:
/// - Instantiating and registering [SharedPreferences] as a singleton.
/// - Registering a [PrefsOperator] wrapper for typed access to preferences.
/// - Registering [ThemeCubit] and [LocalizationCubit] as lazy singletons,
///   so they are created only when first requested.
/// - Registering [AppRouter] as the central navigation/router object.
///
/// This method must be invoked exactly once, before calling `runApp()`.
/// A typical usage pattern in `main.dart` is:
///
/// ```dart
/// Future<void> main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await setupLocator();
///   runApp(const AppWrapper());
/// }
/// ```
Future<void> setupLocator() async {
  // SharedPreferences is an asynchronous dependency that must be
  // fully initialized before it can be used by other services.
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();

  // Register the SharedPreferences instance as a singleton so that
  // the same instance is reused across the entire application.
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register a high-level preferences operator that encapsulates
  // read/write operations and provides a more structured API on top
  // of raw SharedPreferences.
  locator.registerLazySingleton<PrefsOperator>(
        () => PrefsOperator(sharedPreferences),
  );

  // Register the ThemeCubit as a lazy singleton. It depends on
  // PrefsOperator to load and persist theme configuration (e.g. theme mode,
  // font scaling).
  locator.registerLazySingleton<ThemeCubit>(
        () => ThemeCubit(locator<PrefsOperator>()),
  );

  // Register the LocalizationCubit as a lazy singleton. It uses
  // PrefsOperator to persist the active locale and restore it on startup.
  locator.registerLazySingleton<LocalizationCubit>(
        () => LocalizationCubit(locator<PrefsOperator>()),
  );

  // Register the application router responsible for route generation
  // and navigation configuration.
  locator.registerLazySingleton<AppRouter>(
        () => AppRouter(),
  );
}
