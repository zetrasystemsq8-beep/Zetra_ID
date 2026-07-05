import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

/// Provides centralized configuration for application localization.
///
/// This class exposes:
/// - A fallback locale used when system locale is unsupported.
/// - A list of supported locales.
/// - A list of localization delegates that must be supplied to `MaterialApp`.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   supportedLocales: L10n.supportedLocales,
///   localizationsDelegates: L10n.localizationsDelegates,
///   locale: mySelectedLocale,
/// );
/// ```
class L10n {
  /// Private constructor to prevent instantiation.
  L10n._();

  /// Default locale used when the system locale is not supported.
  static const Locale fallbackLocale = Locale('en');

  /// Set of supported locales for the application.
  ///
  /// Make sure that for every locale listed here,
  /// there is a corresponding ARB file and generated localization class.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// Collection of localization delegates required by the framework,
  /// combined with the generated [AppLocalizations] delegate.
  ///
  /// This list should typically be passed directly into `MaterialApp`.
  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }
}
