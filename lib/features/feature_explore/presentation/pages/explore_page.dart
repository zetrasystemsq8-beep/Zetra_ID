import 'package:flutter/material.dart';
import '../../../../config/localization/app_localizations.dart';

/// A simple page representing the Explore tab.
///
/// This widget is displayed inside the AppShell's navigation structure.
/// It only shows a localized title for now, but can later be expanded with
/// content such as discoverable items, cards, or search features.
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain localized text instance.
    final AppLocalizations t = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        t.navExplore,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
