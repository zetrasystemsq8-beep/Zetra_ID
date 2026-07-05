import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/di/locator.dart';
import '../../config/localization/localization_cubit.dart';
import '../../config/localization/localization_state.dart';
import '../../config/localization/l10n.dart';
import '../../config/router/app_router.dart';
import '../../config/theme/theme.dart';
import '../../config/theme/theme_cubit.dart';

/// Top-level application wrapper.
///
/// Responsibilities:
/// - Registers [ThemeCubit] and [LocalizationCubit] via [MultiBlocProvider].
/// - Listens to OS-level changes using [WidgetsBindingObserver]:
///   - System locale
///   - Text scale factor
///   - Platform brightness (light/dark)
/// - Applies theme, localization, and system UI (status/navigation bar) config.
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Subscribe to system-level changes (locale, brightness, etc.).
    WidgetsBinding.instance.addObserver(this);

    // Show only the top system bar (status bar), hide navigation bar.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay>[SystemUiOverlay.top],
    );
  }

  @override
  void dispose() {
    // Unsubscribe from system-level callbacks when widget is removed.
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // System locale changes
  // ---------------------------------------------------------------------------

  @override
  void didChangeLocales(List<Locale>? locales) {
    final Locale? loc =
    (locales != null && locales.isNotEmpty) ? locales.first : null;

    context.read<LocalizationCubit>().setLocale(loc);
    super.didChangeLocales(locales);
  }

  // ---------------------------------------------------------------------------
  // System text scale changes
  // ---------------------------------------------------------------------------

  @override
  void didChangeTextScaleFactor() {
    final double sysScale = MediaQuery.of(context).textScaleFactor;
    context.read<ThemeCubit>().setFontScale(sysScale);
    super.didChangeTextScaleFactor();
  }

  // ---------------------------------------------------------------------------
  // System dark / light mode changes
  // ---------------------------------------------------------------------------

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;

    context.read<ThemeCubit>().setThemeMode(
      brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    // Resolve cubits and router from the service locator.
    final ThemeCubit themeCubit = locator<ThemeCubit>();
    final LocalizationCubit localizationCubit = locator<LocalizationCubit>();
    final AppRouter appRouter = locator<AppRouter>();

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<LocalizationCubit>.value(value: localizationCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return BlocBuilder<LocalizationCubit, LocalizationState>(
            builder:
                (BuildContext context, LocalizationState localizationState) {
              return MaterialApp(
                title: 'Flutter Clean App Base',
                debugShowCheckedModeBanner: false,

                // Localization
                locale: localizationState.locale,
                supportedLocales: L10n.supportedLocales,
                localizationsDelegates: L10n.localizationsDelegates,

                // Theme configuration
                theme: AppThemes.light(),
                darkTheme: AppThemes.dark(),
                themeMode: themeState.themeMode,

                // Routing configuration
                onGenerateRoute: appRouter.onGenerateRoute,
                initialRoute: AppRoutes.splash,

                // Builder gives us access to proper context/theme for system bars.
                builder: (BuildContext context, Widget? child) {
                  final MediaQueryData mediaQuery = MediaQuery.of(context);
                  final ThemeData theme = Theme.of(context);

                  final bool isSystemDark =
                      theme.brightness == Brightness.dark;
                  final ThemeMode systemMode =
                  isSystemDark ? ThemeMode.dark : ThemeMode.light;

                  // Compute the effective theme mode:
                  // - If app is set to "system", follow systemMode
                  // - Otherwise, use the explicit themeMode from state
                  final ThemeMode effectiveMode =
                  themeState.themeMode == ThemeMode.system
                      ? systemMode
                      : themeState.themeMode;

                  // Use NavigationBar background color if provided,
                  // otherwise fallback to colorScheme.surface.
                  final Color navBarColor =
                      theme.navigationBarTheme.backgroundColor ??
                          theme.colorScheme.surface;

                  // Configure status bar and navigation bar to match the theme.
                  AppThemes.setSystemBars(
                    effectiveMode,
                    background: navBarColor,
                  );

                  // Apply global text scaling based on ThemeState.
                  return MediaQuery(
                    data: mediaQuery.copyWith(
                      textScaleFactor: themeState.fontScale,
                    ),
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
