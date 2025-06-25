// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get en => 'English';

  @override
  String get ru => 'Russian';

  @override
  String get tr => 'Turkish';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get appLangTitle => 'App language';

  @override
  String get appLangWarning =>
      'Changing the language will require re-downloading the materials.';
}
