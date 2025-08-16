import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/modules/home/widgets/attention_badge.dart';
import 'package:avdan/modules/languages/languages.dart';
import 'package:avdan/modules/news/services/openers.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({
    this.hasUpdates = false,
    this.hasNews = false,
    required this.onNewsOpen,
    super.key,
  });

  final bool hasUpdates;
  final bool hasNews;

  final VoidCallback onNewsOpen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Row(
        spacing: 8,
        children: [
          BlocBuilder<LocaleCubit, Locale>(
            builder: (context, state) {
              final translations = Prefs.learningLanguage?.translations;
              final language = translations?[state.languageCode].titled ?? '?';

              if (hasUpdates) {
                return AttentionBadge(
                  show: hasUpdates,
                  child: ElevatedButton.icon(
                    onPressed: () => launchUpdates(context),
                    label: Text(language),
                    icon: Icon(Icons.sync_rounded),
                  ),
                );
              }
              return ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const LanguagesScreen(),
                  ),
                ),
                label: Text(language),
                icon: Icon(Icons.language_rounded),
              );
            },
          ),
          const Spacer(),
          if (hasNews)
            AttentionBadge(
              child: ElevatedButton(
                onPressed: () async {
                  await openNews(context);
                  onNewsOpen();
                },
                child: Icon(Icons.notifications_active_rounded),
              ),
            )
          else
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsScreen(),
                ),
              ),
              child: Icon(Icons.settings_rounded),
            ),
        ],
      ),
    );
  }
}
