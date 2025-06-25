// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get en => 'İngilizce';

  @override
  String get ru => 'Rusça';

  @override
  String get tr => 'Türkçe';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get appLangTitle => 'Uygulama dili';

  @override
  String get appLangWarning =>
      'Dilin değiştirilmesi materyallerin yeniden indirilmesini gerektirecektir.';
}
