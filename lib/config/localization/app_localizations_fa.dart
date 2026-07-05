// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'Flutter Clean App Base';

  @override
  String get navHome => 'خانه';

  @override
  String get navExplore => 'کاوش';

  @override
  String get navSettings => 'تنظیمات';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsSectionTheme => 'تم';

  @override
  String get settingsSectionLanguage => 'زبان';

  @override
  String get settingsSectionTextSize => 'اندازه متن';

  @override
  String get themeSystem => 'مطابق تنظیمات سیستم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تاریک';

  @override
  String get langSystem => 'مطابق زبان سیستم';

  @override
  String get langEnglish => 'انگلیسی';

  @override
  String get langPersian => 'فارسی';

  @override
  String get textscaleDecrease => 'کوچک‌تر کردن متن';

  @override
  String get textscaleIncrease => 'بزرگ‌تر کردن متن';

  @override
  String textscaleCurrent(double value) {
    return 'بزرگ‌نمایی فعلی: $value برابر';
  }
}
