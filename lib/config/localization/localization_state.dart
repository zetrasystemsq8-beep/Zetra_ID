import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable state for [LocalizationCubit].
///
/// When [locale] is `null`, it indicates that the application should follow
/// the system locale instead of a user-selected language.
class LocalizationState extends Equatable {
  /// The active locale for the application.
  ///
  /// If `null`, the app is considered to be in "system locale" mode.
  final Locale? locale;

  /// Creates a new [LocalizationState] with the given [locale].
  const LocalizationState({required this.locale});

  /// Factory constructor that returns a state representing
  /// "follow system locale" mode.
  factory LocalizationState.system() => const LocalizationState(locale: null);

  /// Returns a new [LocalizationState] instance with the provided [locale].
  ///
  /// Note: this implementation always uses the [locale] argument directly
  /// and does not fall back to the previous value. This is intentional to
  /// keep the behavior explicit and predictable.
  LocalizationState copyWith({Locale? locale}) {
    return LocalizationState(locale: locale);
  }

  /// Properties used by [Equatable] to determine state equality.
  ///
  /// Only the language code is compared, which is typically sufficient for
  /// most app-level localization scenarios.
  @override
  List<Object?> get props => <Object?>[locale?.languageCode];
}
