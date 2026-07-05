import 'package:flutter/material.dart';

import '../../core/widgets/splash_page.dart';
import '../../features/feature_shell/presentation/pages/app_shell_page.dart';

/// Defines all named routes used throughout the application.
///
/// Keeping route names in a central place:
/// - avoids string duplication,
/// - prevents typos,
/// - makes navigation easier to maintain.
class AppRoutes {
  /// Initial route of the application (splash screen).
  static const String splash = '/';

  /// The main shell that contains bottom navigation and feature modules.
  static const String shell = '/shell';

// Example future routes:
// static const String home = '/home';
// static const String explore = '/explore';
// static const String settings = '/settings';
}

/// Centralized router responsible for generating routes.
///
/// This class decouples navigation logic from UI components and ensures that
/// all route definitions remain consistent and easy to maintain.
class AppRouter {
  /// Generates a route based on the given [RouteSettings].
  ///
  /// This method is passed to `MaterialApp.onGenerateRoute` so that all
  /// navigation flows through a single, predictable place.
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.shell:
        return MaterialPageRoute(
          builder: (_) => const AppShellPage(),
          settings: settings,
        );

      default:
      // Fallback to the main shell if an unknown route is requested.
        return MaterialPageRoute(
          builder: (_) => const AppShellPage(),
          settings: settings,
        );
    }
  }
}
