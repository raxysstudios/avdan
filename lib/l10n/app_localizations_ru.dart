// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get en => 'английский';

  @override
  String get ru => 'русский';

  @override
  String get tr => 'турецкий';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get appLangTitle => 'Язык';

  @override
  String get appLangWarning =>
      'Смена языка потребует повторного скачивания материалов.';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLang => 'Язык приложения';

  @override
  String get settingsFeedback => 'Обратная связь';

  @override
  String get settingsContact => 'Написать разработчику';

  @override
  String get settingsContactSub => 'Предложения, технические проблемы';

  @override
  String get settingsReport => 'Сообщить об ошибке';

  @override
  String get settingsReportSub => 'Неверный перевод, опечатка, и т.п.';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsNews => 'Новости проекта';

  @override
  String get settingsRaxys => 'Сделано на Кавказе';

  @override
  String get newsTitle => 'Новости';

  @override
  String get langTitle => 'Выберите ваш язык';

  @override
  String get langScript => 'Выберите письменность';

  @override
  String get updates => 'Загрузка';
}
