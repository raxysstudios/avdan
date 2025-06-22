import 'package:avdan/modules/languages/interface_languages.dart';
import 'package:avdan/modules/news/services/openers.dart';
import 'package:avdan/modules/settings/widgets/section_label.dart';
// import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Настройки'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const Icon(Icons.translate_rounded),
            title: Text('Интерфейс'),
            subtitle: Text('Русский'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InterfaceLanguagesScreen(),
              ),
            ),
          ),
          const Divider(),
          SectionLabel('Обратная связь'),
          ListTile(
            leading: const Icon(Icons.mail_rounded),
            title: Text('Написать разработчику'),
            subtitle: Text('Предложения, пожелания, технические проблемы'),
            onTap: () => openLink('https://t.me/alixandzinadAX'),
          ),
          ListTile(
            leading: const Icon(Icons.report_rounded),
            title: Text('Сообщить об ошибке в материале'),
            subtitle: Text('Неверный перевод, опечатка в тексте, и т.п.'),
            onTap: () => openLink('https://forms.gle/P7YvwLxxnzfU2beG8'),
          ),
          const Divider(),
          SectionLabel('О приложении'),
          ListTile(
            leading: const Icon(Icons.notifications_rounded),
            title: Text('Новости проекта'),
            onTap: () => openNews(context),
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final p = snapshot.data;
              return ListTile(
                onTap: () => openLink('https://raxys.app'),
                leading: const Icon(Icons.landscape_rounded),
                title: Text('Avdan ${p?.version}'),
                subtitle: Text('Сделано на Северном Кавказе'),
              );
            },
          ),
        ],
      ),
    );
  }
}
