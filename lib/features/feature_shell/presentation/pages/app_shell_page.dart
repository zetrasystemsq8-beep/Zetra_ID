import 'package:flutter/material.dart';

import '../../../../config/localization/app_localizations.dart';
import '../../../feature_home/presentation/pages/home_page.dart';
import '../../../feature_explore/presentation/pages/explore_page.dart';
import '../../../feature_settings/presentation/pages/settings_page.dart';

/// Root shell of the application.
///
/// This page holds the global scaffold that includes:
/// - AppBar
/// - Bottom Navigation Bar (Material 3 NavigationBar)
/// - Three tabs (Home, Explore, Settings)
///
/// It uses an [IndexedStack] to preserve the state of each tab.
class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends State<AppShellPage> {
  /// Current active tab index.
  int _currentIndex = 0;

  /// Pages assigned to bottom navigation destinations.
  ///
  /// These widgets remain alive thanks to IndexedStack.
  final List<Widget> _pages = const <Widget>[
    HomePage(),
    ExplorePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    /// Localized titles for AppBar.
    final List<String> titles = <String>[
      t.navHome,
      t.navExplore,
      t.navSettings,
    ];

    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[_currentIndex]),
        ),

        /// Keeps the state of each tab alive.
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),

        /// Material 3 Bottom Navigation Bar.
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: t.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.search),
              selectedIcon: const Icon(Icons.search_rounded),
              label: t.navExplore,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: t.navSettings,
            ),
          ],
        ),
      ),
    );
  }
}
