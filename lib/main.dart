import 'package:flutter/material.dart';
import 'config/di/locator.dart';
import 'core/widgets/app_wrapper.dart';

/// Entry point of the Flutter application.
///
/// This method is responsible for:
/// - Ensuring Flutter bindings are initialized
/// - Initializing global dependencies via `setupLocator()`
/// - Running the root widget (`AppWrapper`)
///
/// All dependency injections must be registered before calling `runApp()`.
Future<void> main() async {
  // Ensures that binding is ready for async operations before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Register all application-wide services and singletons.
  await setupLocator();

  // Start the application.
  runApp(const AppWrapper());
}
