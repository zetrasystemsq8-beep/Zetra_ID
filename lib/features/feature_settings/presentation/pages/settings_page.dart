import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zetra_id/core/extensions/spacing.dart';

import '../../../../config/localization/app_localizations.dart';
import '../../../../config/localization/localization_cubit.dart';
import '../../../../config/localization/localization_state.dart';
import '../../../../config/theme/theme_cubit.dart';
import '../widgets/scale_section.dart';

/// Settings tab content.
///
/// This page exposes three main sections:
/// - Theme mode (System / Light / Dark)
/// - Language (System / English / Persian)
/// - Text size (font scale via [ScaleSection])
///
/// It is intended to be used as one of the tabs in the shell/navigation layout.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations t = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------
          // Theme section
          // -------------------
          Text(
            t.settingsSectionTheme,
            style: theme.textTheme.titleLarge,
          ),
          8.ph,
          Card(
            child: BlocBuilder<ThemeCubit, ThemeState>(
              // Only rebuild when theme mode changes.
              buildWhen: (ThemeState previous, ThemeState current) =>
              previous.themeMode != current.themeMode,
              builder: (BuildContext context, ThemeState state) {
                final ThemeMode mode = state.themeMode;

                return Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text(t.themeSystem),
                      value: ThemeMode.system,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          context.read<ThemeCubit>().setThemeMode(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(t.themeLight),
                      value: ThemeMode.light,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          context.read<ThemeCubit>().setThemeMode(value);
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text(t.themeDark),
                      value: ThemeMode.dark,
                      groupValue: mode,
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          context.read<ThemeCubit>().setThemeMode(value);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // -------------------
          // Language section
          // -------------------
          Text(
            t.settingsSectionLanguage,
            style: theme.textTheme.titleLarge,
          ),
          8.ph,
          Card(
            child: BlocBuilder<LocalizationCubit, LocalizationState>(
              // Only rebuild when locale changes.
              buildWhen:
                  (LocalizationState previous, LocalizationState current) =>
              previous.locale != current.locale,
              builder: (BuildContext context, LocalizationState state) {
                final String? code = state.locale?.languageCode;

                return Column(
                  children: [
                    RadioListTile<String?>(
                      title: Text(t.langSystem),
                      value: null,
                      groupValue: code,
                      onChanged: (String? _) {
                        // Null means: follow system locale.
                        context.read<LocalizationCubit>().setLocale(null);
                      },
                    ),
                    RadioListTile<String?>(
                      title: Text(t.langEnglish),
                      value: 'en',
                      groupValue: code,
                      onChanged: (String? _) {
                        context
                            .read<LocalizationCubit>()
                            .setLocale(const Locale('en'));
                      },
                    ),
                    RadioListTile<String?>(
                      title: Text(t.langPersian),
                      value: 'fa',
                      groupValue: code,
                      onChanged: (String? _) {
                        context
                            .read<LocalizationCubit>()
                            .setLocale(const Locale('fa'));
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // -------------------
          // Text scale section
          // -------------------
          Text(
            t.settingsSectionTextSize,
            style: theme.textTheme.titleLarge,
          ),
          8.ph,

          // Handles font scale changes (zoom in/out) using ThemeCubit.
          const ScaleSection(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
