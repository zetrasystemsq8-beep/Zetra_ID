import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_schemes.dart';

/// Central theme configuration for the application.
///
/// This class exposes two static factory methods:
/// - [light] for the light theme.
/// - [dark] for the dark theme.
///
/// It also provides [setSystemBars] to update Android/iOS system bar colors
/// and icon brightness based on the selected [ThemeMode].
class AppThemes {
  AppThemes._();

  /// Primary font family used across the application.
  static const String _font = 'IRANSans';

  /// Configures system status bar and navigation bar colors and icon styles.
  ///
  /// This method should be called whenever the theme mode changes so that
  /// system UI elements match the active theme.
  ///
  /// [mode] is the currently active [ThemeMode].
  /// [background] can be used to override the navigation bar background color.
  static void setSystemBars(
      ThemeMode mode, {
        Color? background,
      }) {
    final bool isLight = mode == ThemeMode.light;
    final ColorScheme schemeLight = AppColorSchemes.light();
    final ColorScheme schemeDark = AppColorSchemes.dark();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // Status bar color (top)
        statusBarColor:
        isLight ? schemeLight.background : schemeDark.surfaceVariant,
        statusBarIconBrightness:
        isLight ? Brightness.dark : Brightness.light,
        statusBarBrightness:
        isLight ? Brightness.light : Brightness.dark,

        // Navigation bar color (bottom)
        systemNavigationBarColor: background ??
            (isLight
                ? schemeLight.surfaceVariant
                : schemeDark.surfaceVariant),
        systemNavigationBarIconBrightness:
        isLight ? Brightness.dark : Brightness.light,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }

  /// Base text theme applied to both light and dark themes.
  ///
  /// All text styles use the [_font] family to keep typography consistent.
  static TextTheme _textTheme() {
    const TextStyle base = TextStyle(fontFamily: _font);

    return const TextTheme().copyWith(
      titleLarge: base.copyWith(fontWeight: FontWeight.w700),
      titleMedium: base,
      titleSmall: base,
      bodyLarge: base,
      bodyMedium: base,
      bodySmall: base,
      labelLarge: base,
      labelSmall: base,
    );
  }

  /// Creates the light [ThemeData] instance.
  ///
  /// [textScale] can be used to globally scale text sizes. This is useful
  /// when you want to apply a user-defined font scale to the entire app.
  static ThemeData light({double textScale = 1.0}) {
    final ColorScheme scheme = AppColorSchemes.light();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: _textTheme().apply(fontSizeFactor: textScale),

      /// Global background for Scaffold widgets.
      scaffoldBackgroundColor: scheme.background,

      // AppBar configuration for light theme.
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: scheme.background,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),

      // Switch styling for light theme.
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.primary.withOpacity(0.5);
            }
            return Colors.transparent;
          },
        ),
        trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.surface;
            }
            return scheme.primary;
          },
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.primary;
            }
            return scheme.primary;
          },
        ),
      ),

      // Navigation bar styling for light theme (Material 3 NavigationBar).
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceVariant.withOpacity(0.5),
        indicatorColor: scheme.secondary.withOpacity(0.8),
        elevation: 8,
        height: 80,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
              (Set<WidgetState> states) {
            final bool isActive = states.contains(WidgetState.selected);
            return IconThemeData(
              color: isActive
                  ? scheme.primary
                  : scheme.onSurface.withOpacity(0.6),
            );
          },
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
            final bool isActive = states.contains(WidgetState.selected);
            return TextStyle(
              fontWeight: FontWeight.w600,
              color: isActive
                  ? scheme.primary
                  : scheme.onSurface.withOpacity(0.7),
            );
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return scheme.primary.withOpacity(0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return scheme.primary.withOpacity(0.1);
            }
            if (states.contains(WidgetState.focused)) {
              return scheme.secondary.withOpacity(0.2);
            }
            return null;
          },
        ),
      ),

      // Card styling for light theme.
      cardTheme: CardThemeData(
        color: scheme.surfaceBright,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: scheme.surfaceVariant, // Border color
            width: 1.0, // Border width
          ),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(8),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
    );
  }

  /// Creates the dark [ThemeData] instance.
  ///
  /// [textScale] can be used to globally scale text sizes. Same idea as in
  /// [light], but applied to the dark theme.
  static ThemeData dark({double textScale = 1.0}) {
    final ColorScheme scheme = AppColorSchemes.dark();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      dividerColor: Colors.white,
      textTheme: _textTheme().apply(fontSizeFactor: textScale),

      // AppBar configuration for dark theme.
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: scheme.surfaceVariant,
        foregroundColor: scheme.onBackground,
        surfaceTintColor: Colors.transparent,
      ),

      /// Global background for Scaffold widgets in dark mode.
      scaffoldBackgroundColor: scheme.surfaceVariant,

      // Input decoration styling for dark theme.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: scheme.outlineVariant,
            width: 1.5,
          ),
        ),
        hintStyle: const TextStyle(color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
      ),

      // Switch styling for dark theme.
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.primary.withOpacity(0.5);
            }
            return scheme.surface;
          },
        ),
        trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.surface;
            }
            return Colors.white;
          },
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return scheme.primary;
            }
            return Colors.white;
          },
        ),
      ),

      // Navigation bar styling for dark theme.
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withOpacity(0.5),
        elevation: 8,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
              (Set<WidgetState> states) {
            final bool isActive = states.contains(WidgetState.selected);
            return IconThemeData(
              color: isActive
                  ? scheme.inversePrimary
                  : scheme.onSurface.withOpacity(0.75),
            );
          },
        ),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
            final bool isActive = states.contains(WidgetState.selected);
            return TextStyle(
              fontWeight: FontWeight.w600,
              color: isActive
                  ? scheme.inversePrimary
                  : scheme.onSurface.withOpacity(0.85),
            );
          },
        ),
      ),

      // Card styling for dark theme.
      cardTheme: CardThemeData(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: scheme.surfaceVariant, // Border color
            width: 1.0, // Border width
          ),
        ),
        elevation: 8,
        margin: const EdgeInsets.all(8),
      ),
    );
  }
}
