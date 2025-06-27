import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/l10n/utils.dart';
import 'package:avdan/modules/languages/services/modals.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/language_avatar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/queries.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.t.langTitle),
          ),
          body: FirestoreListView(
            query: getLanguagesQuery().where('order', isGreaterThan: 0),
            itemBuilder: (context, doc) {
              final language = doc.data();
              final subtitle = language.translations[locale.languageCode];
              return ListTile(
                leading: LanguageAvatar(language.name),
                title: Text(language.caption.main.titled),
                subtitle: subtitle == null ? null : Text(subtitle),
                onTap: () async {
                  if (language.caption.alt == null) {
                    Prefs.altScript = false;
                  } else {
                    final isAlt = await selectAltScript(context, language);
                    if (isAlt == null) return;
                    Prefs.altScript = isAlt;
                  }
                  final reset = Prefs.learningLanguage != language;
                  Prefs.learningLanguage = language;

                  FirebaseAnalytics.instance.setUserProperty(
                    name: 'learning_language',
                    value: Prefs.learningLanguage?.name,
                  );
                  launchUpdates(context, reset: reset);
                },
              );
            },
          ),
        );
      },
    );
  }
}
