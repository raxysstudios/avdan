import 'package:avdan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => openLink('https://github.com/raxysstudios/avdan'),
      leading: const Icon(Icons.code_outlined),
      title: const Text('Avdan'),
      subtitle: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final p = snapshot.data;
          return Text(
            p == null ? '...' : 'v${p.version} (${p.buildNumber})',
            style: Theme.of(context).textTheme.bodySmall,
          );
        },
      ),
    );
  }
}
