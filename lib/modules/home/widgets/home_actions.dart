import 'package:avdan/modules/languages/languages.dart';
import 'package:avdan/modules/news/news_screen.dart';
import 'package:avdan/modules/settings/settings.dart';
import 'package:avdan/modules/updates/services/loader.dart';
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
      padding: const EdgeInsets.all(8),
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
            label: Text('Языки'),
          ),
          if (hasUpdates)
            ElevatedButton(
              child: Icon(Icons.update_outlined),
              onPressed: () => launchUpdates(context),
            ),
          const Spacer(),
          if (hasNews)
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const NewsScreen(),
                ),
              ),
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
