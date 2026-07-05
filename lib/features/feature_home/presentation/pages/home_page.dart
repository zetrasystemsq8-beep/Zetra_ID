import 'package:flutter/material.dart';
import '../../../../config/localization/app_localizations.dart';

/// A simple page representing the Home tab.
///
/// This widget is rendered inside the main application shell
/// (which provides AppBar, NavigationBar, and other scaffolding).
/// For now, it displays the localized "Home" label, but it can be
/// extended to include dashboards, summaries, or quick actions.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the localization instance for retrieving translated strings.
    final AppLocalizations t = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        t.navHome,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
