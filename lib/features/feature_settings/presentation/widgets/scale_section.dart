import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zetra_id/core/extensions/spacing.dart';

import '../../../../config/localization/app_localizations.dart';
import '../../../../config/theme/theme_cubit.dart';

/// A settings panel widget that allows the user to adjust the global
/// text scale factor of the application.
///
/// This widget communicates with [ThemeCubit], which stores the current
/// `fontScale` and persists it through `PrefsOperator`.
///
/// The updated scale is applied globally inside `MaterialApp.builder`,
/// ensuring that all text in the app reflects the selected zoom level.
class ScaleSection extends StatelessWidget {
  const ScaleSection({super.key});

  /// Minimum allowed global text scale.
  static const double _minScale = 0.8;

  /// Maximum allowed global text scale.
  static const double _maxScale = 1.6;

  /// Amount of change per increment/decrement step.
  static const double _step = 0.1;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context)!;

    return BlocBuilder<ThemeCubit, ThemeState>(
      // Only rebuild if the font scale value changes.
      buildWhen: (ThemeState previous, ThemeState current) =>
      previous.fontScale != current.fontScale,
      builder: (BuildContext context, ThemeState state) {
        final double scale = state.fontScale;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section title
                Text(
                  t.settingsSectionTextSize,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                8.ph,

                // Main text scale control row
                Row(
                  children: [
                    /// Decrease text scale button
                    IconButton(
                      tooltip: t.textscaleDecrease,
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        final double next = (scale - _step)
                            .clamp(_minScale, _maxScale)
                            .toDouble();
                        context.read<ThemeCubit>().setFontScale(next);
                      },
                    ),

                    /// Slider for smooth text scale control
                    Expanded(
                      child: Slider(
                        value: scale.clamp(_minScale, _maxScale),
                        min: _minScale,
                        max: _maxScale,
                        divisions:
                        ((_maxScale - _minScale) / _step).round(),
                        label: scale.toStringAsFixed(1),
                        onChanged: (double value) {
                          context.read<ThemeCubit>().setFontScale(value);
                        },
                      ),
                    ),

                    /// Increase text scale button
                    IconButton(
                      tooltip: t.textscaleIncrease,
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final double next = (scale + _step)
                            .clamp(_minScale, _maxScale)
                            .toDouble();
                        context.read<ThemeCubit>().setFontScale(next);
                      },
                    ),
                  ],
                ),
                4.ph,
                /// Display the current zoom level to the user
                Text(
                  t.textscaleCurrent(scale),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
