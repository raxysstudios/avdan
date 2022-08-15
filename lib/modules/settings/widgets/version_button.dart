import 'package:avdan/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionButton extends StatelessWidget {
  const VersionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => openLink('https://github.com/raxysstudios/avdan'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              final p = snapshot.data;
              return Text(
                p == null ? '...' : 'v${p.version} (${p.buildNumber})',
                style: Theme.of(context).textTheme.caption,
              );
            },
          ),
        ),
      ),
    );
  }
}
