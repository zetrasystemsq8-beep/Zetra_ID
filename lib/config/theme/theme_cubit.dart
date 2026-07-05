import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/utils/prefs_operator.dart';

part 'theme_state.dart';

/// ThemeCubit is responsible for managing the global theme configuration.
///
/// Responsibilities:
/// - Persisting theme mode (light / dark / system)
/// - Persisting font scale multiplier (text zoom)
/// - Restoring persisted values at startup
/// - Exposing methods for updating theme & font settings
///
/// The data is stored using [PrefsOperator], so values survive app restarts.
class ThemeCubit extends Cubit<ThemeState> {
  final PrefsOperator _prefsOperator;

  /// Creates a ThemeCubit with an initial state and loads
  /// saved preferences asynchronously.
  ThemeCubit(this._prefsOperator) : super(ThemeState.initial()) {
    _loadFromPrefs();
  }

  /// Loads theme mode and font scale from persistent storage.
  ///
  /// This is called automatically once when the cubit initializes.
  Future<void> _loadFromPrefs() async {
    // ---------------------------
    // Load ThemeMode from storage
    // ---------------------------
    final String? themeModeString = _prefsOperator.getThemeMode();
    ThemeMode themeMode = ThemeMode.system;

    switch (themeModeString) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.system;
    }

    // ---------------------------
    // Load font scale from storage
    // ---------------------------
    final double fontScaleValue =
        _prefsOperator.getFontScale() ?? 1.0; // default zoom: 1.0

    emit(
      ThemeState(
        themeMode: themeMode,
        fontScale: fontScaleValue,
      ),
    );
  }

  /// Updates the application's theme mode and persists it.
  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));

    final String value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };

    await _prefsOperator.setThemeMode(value);
  }

  /// Updates the global font scale.
  ///
  /// The value is clamped for accessibility between **0.8×** and **1.6×**
  /// to prevent extremely large or tiny text sizes.
  Future<void> setFontScale(double scale) async {
    final double clamped = scale.clamp(0.8, 1.6);
    emit(state.copyWith(fontScale: clamped));
    await _prefsOperator.setFontScale(clamped);
  }
}
