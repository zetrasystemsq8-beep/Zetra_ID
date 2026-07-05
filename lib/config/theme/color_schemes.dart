import 'package:flutter/material.dart';

/// Defines the brand’s core color palette used across the application.
///
/// These colors are static constants to ensure consistency in:
/// - UI components
/// - Themes (light & dark)
/// - Illustrations or custom widgets
///
/// Naming follows a semantic approach rather than purely visual names.
class BrandColors {
  BrandColors._();

  /// Primary brand color (deep navy blue).
  static const navy = Color(0xFF2E6E8D);

  /// Accent brand color (strong orange).
  static const orange = Color(0xFFFB9F2D);

  /// Light blue used for highlights or tertiary accents.
  static const sky = Color(0xFF64B5D1);

  /// Soft teal variant used in gradients or supporting UI.
  static const teal = Color(0xFF80D8DA);

  /// Light background color for subtle containers and app surfaces.
  static const bgSoft = Color(0xFFF7F9FA);
}

/// Provides strongly-typed `ColorScheme` definitions for both
/// light and dark themes used in Material 3.
///
/// These schemes feed directly into `ThemeData.colorScheme` to ensure
/// consistent coloring across:
/// - AppBar
/// - NavigationBar
/// - Cards
/// - Buttons
/// - Surfaces & backgrounds
///
/// The color choices are aligned with the brand identity.
class AppColorSchemes {
  AppColorSchemes._();

  /// Returns the light color scheme for the application UI.
  ///
  /// All colors are carefully selected to maintain accessibility,
  /// high contrast, and a clean modern appearance.
  static ColorScheme light() => const ColorScheme(
    brightness: Brightness.light,
    primary: BrandColors.navy,
    onPrimary: Colors.white,
    secondary: BrandColors.orange,
    onSecondary: BrandColors.navy,
    tertiary: BrandColors.sky,
    onTertiary: Colors.white,
    surface: Colors.white,
    surfaceBright: BrandColors.bgSoft,
    onSurface: Color(0xFF1A1F24),
    background: BrandColors.bgSoft,
    onBackground: Color(0xFF1A1F24),
    error: Color(0xFFBA1A1A),
    onError: Colors.white,
    surfaceVariant: Color(0xFFE7EEF2),
    onSurfaceVariant: Color(0xFF3B4A55),
    outline: Color(0xFFD9E3E8),
    shadow: Colors.black12,
    scrim: Colors.black54,
    inverseSurface: Color(0xFF2A2F33),
    onInverseSurface: Colors.white,
    inversePrimary: BrandColors.sky,
  );

  /// Returns the dark color scheme tailored for low-light environments.
  ///
  /// The palette focuses on improved readability and balanced contrast.
  static ColorScheme dark() => const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF6CBED0),
    onPrimary: Colors.black,
    secondary: Color(0xFFFFC071),
    onSecondary: Colors.black,
    tertiary: Color(0xFF7FD0E6),
    onTertiary: Colors.black,
    surface: Color(0xFF022535),
    onSurface: Colors.white,
    background: Color(0xFF181A1B),
    onBackground: Colors.white,
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surfaceVariant: Color(0xFF022B3E),
    onSurfaceVariant: Color(0xFFBAC7D0),
    outline: Color(0xFF3A454D),
    shadow: Colors.black54,
    scrim: Colors.black87,
    inverseSurface: Colors.white,
    onInverseSurface: Color(0xFF1A1F24),
    inversePrimary: Color(0xFFF6A23A),
  );
}

/// Adds common gradient utilities to the app's ColorScheme.
///
/// This extension enables calling:
/// ```dart
/// theme.colorScheme.mainGradient
/// ```
/// to access consistent global gradients.
extension AppGradients on ColorScheme {
  /// Main vertical gradient used in surfaces or backgrounds.
  ///
  /// Creates a subtle transition between the surface and background colors.
  LinearGradient get mainGradient => LinearGradient(
    colors: [surface, background],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
