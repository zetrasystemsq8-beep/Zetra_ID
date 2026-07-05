// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Clean App Base';

  @override
  String get navHome => 'Home';

  @override
  String get navExplore => 'Explore';

  @override
  String get navSettings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionTheme => 'Theme';

  @override
  String get settingsSectionLanguage => 'Language';

  @override
  String get settingsSectionTextSize => 'Text size';

  @override
  String get themeSystem => 'Follow system';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get langSystem => 'Follow system';

  @override
  String get langEnglish => 'English';

  @override
  String get langPersian => 'Persian';

  @override
  String get textscaleDecrease => 'Decrease text size';

  @override
  String get textscaleIncrease => 'Increase text size';

  @override
  String textscaleCurrent(double value) {
    return 'Current scale: ${value}x';
  }
}
