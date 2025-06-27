import 'dart:ui';

import 'package:avdan/l10n/app_localizations.dart';

String translateCode(String code, AppLocalizations l10n) {
  return switch (code) {
    'en' => l10n.en,
    'ru' => l10n.ru,
    'tr' => l10n.tr,
    _ => code
  };
}

String codeToName(String code) {
  return switch (code) {
    'ru' => 'russian',
    'tr' => 'turkish',
    _ => 'english',
  };
}

Locale resolveLocale(List<Locale> locales) {
  final supportedLocales = AppLocalizations.supportedLocales;
  var locale = supportedLocales.first;
  for (final l in locales) {
    if (supportedLocales.contains(l)) {
      locale = l;
      break;
    }
  }
  return locale;
}
