import 'package:shared_preferences/shared_preferences.dart';

/// A collection of keys used for storing user preferences inside
/// [SharedPreferences].
///
/// Keeping all keys here ensures consistent usage across the entire app.
/// These keys map to values such as theme mode, font scaling, and locale.
class PrefsKeys {
  /// The currently selected theme mode.
  /// Possible values: "light", "dark", "system".
  static const String themeMode = 'settings_theme_mode';

  /// The globally applied text scale factor (double).
  static const String fontScale = 'settings_font_scale';

  /// The selected locale code, e.g., "en" or "fa".
  /// If empty or null, the app will follow system locale.
  static const String locale = 'settings_locale';
}

/// A strongly-typed wrapper around [SharedPreferences] used to read and write
/// user-configurable settings.
///
/// This avoids scattering SharedPreferences logic throughout the codebase
/// and centralizes all preference-management concerns.
class PrefsOperator {
  /// Underlying SharedPreferences instance.
  final SharedPreferences _prefs;

  /// Creates a new operator wrapping an existing SharedPreferences instance.
  PrefsOperator(this._prefs);

  // ---------------------------------------------------------------------------
  // THEME MODE
  // ---------------------------------------------------------------------------

  /// Returns the stored theme mode string (`"light"`, `"dark"`, `"system"`),
  /// or `null` if no value has been saved.
  String? getThemeMode() => _prefs.getString(PrefsKeys.themeMode);

  /// Persists the theme mode as a string.
  ///
  /// Returns `true` if the value was successfully written.
  Future<bool> setThemeMode(String value) {
    return _prefs.setString(PrefsKeys.themeMode, value);
  }

  // ---------------------------------------------------------------------------
  // FONT SCALE
  // ---------------------------------------------------------------------------

  /// Returns the globally applied text scale factor, or `null` if unset.
  double? getFontScale() => _prefs.getDouble(PrefsKeys.fontScale);

  /// Persists the global text scale factor.
  Future<bool> setFontScale(double value) {
    return _prefs.setDouble(PrefsKeys.fontScale, value);
  }

  // ---------------------------------------------------------------------------
  // LOCALE
  // ---------------------------------------------------------------------------

  /// Returns the stored locale code ("en", "fa"), or `null` if following system.
  String? getLocaleCode() => _prefs.getString(PrefsKeys.locale);

  /// Persists the locale code.
  ///
  /// Passing `null` or an empty string removes the preference, meaning the app
  /// should fallback to system locale.
  Future<bool> setLocaleCode(String? value) {
    if (value == null || value.isEmpty) {
      return _prefs.remove(PrefsKeys.locale);
    }
    return _prefs.setString(PrefsKeys.locale, value);
  }
}
