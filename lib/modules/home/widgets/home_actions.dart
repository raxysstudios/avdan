import 'package:avdan/modules/languages/languages.dart';
import 'package:avdan/modules/news/services/openers.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:flutter/material.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({
    this.hasUpdates = false,
    this.hasNews = false,
    super.key,
  });

  final bool hasUpdates;
  final bool hasNews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: Row(
        spacing: 8,
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const LanguagesScreen(),
              ),
            ),
            icon: Icon(Icons.language_rounded),
            label: Text(Prefs.learningLanguage?.caption.get ?? '?'),
          ),
          if (hasUpdates)
            ElevatedButton(
              onPressed: () => launchUpdates(context),
              child: Icon(Icons.update_outlined),
            ),
          const Spacer(),
          if (hasNews)
            ElevatedButton(
              onPressed: () => openNews(context),
              child: Icon(Icons.notifications_active_rounded),
            ),
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
