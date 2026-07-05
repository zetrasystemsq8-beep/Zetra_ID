part of "theme_cubit.dart";

/// Immutable state container used by [ThemeCubit].
///
/// This class holds:
/// - [themeMode] — the currently selected ThemeMode (light / dark / system)
/// - [fontScale] — the global text scaling multiplier used throughout the UI
///
/// The state is fully immutable. To update values, use [copyWith].
class ThemeState extends Equatable {
  /// The active theme mode applied to the application.
  final ThemeMode themeMode;

  /// The global text scale multiplier (e.g., 1.0 = normal size).
  final double fontScale;

  /// Creates a new immutable ThemeState.
  const ThemeState({
    required this.themeMode,
    required this.fontScale,
  });

  /// Initial default state used when nothing is stored in preferences.
  ///
  /// - ThemeMode.system: follow the OS light/dark theme
  /// - fontScale = 1.0: default text size
  factory ThemeState.initial() {
    return const ThemeState(
      themeMode: ThemeMode.system,
      fontScale: 1.0,
    );
  }

  /// Creates a new ThemeState with selectively overridden values.
  ///
  /// Useful when updating only one field while preserving the rest.
  ThemeState copyWith({
    ThemeMode? themeMode,
    double? fontScale,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      fontScale: fontScale ?? this.fontScale,
    );
  }

  @override
  List<Object> get props => [themeMode, fontScale];
}
