import 'package:avdan/modules/news/news_screen.dart';
import 'package:avdan/modules/settings/widgets/version_tile.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/raxys.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localize('settings')),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: Raxys(),
          ),
          SizedBox(width: 4),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openLink('https://t.me/raxysstudios'),
        icon: const Icon(Icons.send_outlined),
        label: Text(localize('contact')),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            onTap: () => openLink('https://raxys.app'),
            leading: const Icon(Icons.landscape_outlined),
            title: const Text('Raxys Studios'),
            subtitle: Text(localize('honor', isTitled: false)),
          ),
          const VersionTile(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(
                localize('news'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
