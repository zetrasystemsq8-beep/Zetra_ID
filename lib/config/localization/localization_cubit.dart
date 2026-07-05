import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../core/utils/prefs_operator.dart';
import 'localization_state.dart';

/// A Cubit responsible for managing the app's locale.
///
/// This class:
/// - Loads the persisted locale from [PrefsOperator] on initialization.
/// - Emits [LocalizationState] based on the user-selected or system locale.
/// - Persists the selected locale code for future app launches.
///
/// When no locale is selected (null), the application follows the system locale.
class LocalizationCubit extends Cubit<LocalizationState> {
  /// Operator used to read/write locale preferences.
  final PrefsOperator _prefsOperator;

  /// Creates a new [LocalizationCubit] with the provided [PrefsOperator].
  ///
  /// Automatically loads the persisted locale on startup.
  LocalizationCubit(this._prefsOperator) : super(LocalizationState.system()) {
    _loadFromPrefs();
  }

  /// Loads the saved locale code from preferences and updates the state.
  ///
  /// If no saved locale exists, the app defaults to system locale mode.
  Future<void> _loadFromPrefs() async {
    final String? code = _prefsOperator.getLocaleCode();

    if (code == null || code.isEmpty) {
      emit(LocalizationState.system());
      return;
    }

    emit(LocalizationState(locale: Locale(code)));
  }

  /// Sets the current locale.
  ///
  /// If [locale] is null:
  /// - The state is updated to system-following mode.
  /// - The saved locale is cleared from preferences.
  ///
  /// Otherwise:
  /// - The state updates to the provided locale.
  /// - The locale code is persisted for future app launches.
  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      emit(LocalizationState.system());
      await _prefsOperator.setLocaleCode(null);
      return;
    }

    emit(LocalizationState(locale: locale));
    await _prefsOperator.setLocaleCode(locale.languageCode);
  }
}
