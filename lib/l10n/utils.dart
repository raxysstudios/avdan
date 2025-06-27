import 'package:avdan/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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

extension Translate on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this)!;
}
