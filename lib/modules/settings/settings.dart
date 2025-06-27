import 'package:avdan/l10n/locale_cubit.dart';
import 'package:avdan/l10n/utils.dart';
import 'package:avdan/modules/languages/services/modals.dart';
import 'package:avdan/modules/news/services/openers.dart';
import 'package:avdan/modules/settings/widgets/section_label.dart';
import 'package:avdan/modules/updates/services/loader.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 76),
        children: [
          ListTile(
            leading: const Icon(Icons.translate_rounded),
            title: Text(context.t.settingsLang),
            subtitle: Text(
              translateCode(
                context.watch<LocaleCubit>().state.languageCode,
                context.t,
              ),
            ),
            onTap: () async {
              final locale = await selectAppLanguage(context);
              if (locale == null) return;

              final code = locale.languageCode;
              final name = codeToName(code);
              final localeCubit = context.read<LocaleCubit>();
              if (code == localeCubit.state.languageCode) {
                return Navigator.pop(context);
              }

              localeCubit.update(code);
              final reset = Prefs.interfaceLanguage != name;
              Prefs.interfaceLanguage = name;
              FirebaseAnalytics.instance.setUserProperty(
                name: 'interface_language',
                value: Prefs.interfaceLanguage,
              );
              launchUpdates(context, reset: reset);
            },
          ),
          const Divider(),
          SectionLabel(context.t.settingsFeedback),
          ListTile(
            leading: const Icon(Icons.mail_rounded),
            title: Text(context.t.settingsContact),
            subtitle: Text(context.t.settingsContactSub),
            onTap: () => openLink('https://t.me/alixandzinadAX'),
          ),
          ListTile(
            leading: const Icon(Icons.report_rounded),
            title: Text(context.t.settingsReport),
            subtitle: Text(context.t.settingsReportSub),
            onTap: () => openLink('https://forms.gle/P7YvwLxxnzfU2beG8'),
          ),
          const Divider(),
          SectionLabel(context.t.settingsAbout),
          ListTile(
            leading: const Icon(Icons.notifications_rounded),
            title: Text(context.t.settingsNews),
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
                subtitle: Text(context.t.settingsRaxys),
              );
            },
          ),
        ],
      ),
    );
  }
}
