import 'package:avdan/modules/updates/models/deck_preview.dart';
import 'package:avdan/modules/updates/widgets/status_icon.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/widgets/card_preview.dart';
import 'package:flutter/material.dart';

import 'services/loader.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final loading = <DeckPreview>[];
  int? total;
  int get loaded => loading.where((d) => d.status == DeckStatus.ready).length;

  @override
  void initState() {
    super.initState();
    update(
      context,
      (i) => setState(() {
        total = i;
      }),
      (d) => setState(() => loading.add(d)),
      setState,
    ).then((_) {
      if (loaded == total) launch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localize('updates')),
        actions: [
          if (total != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '$loaded / $total',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: LinearProgressIndicator(),
        ),
      ),
      body: ListView(
        children: [
          for (final d in loading)
            ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: Card(
                  color: d.pack.color?.withOpacity(.2),
                  margin: EdgeInsets.zero,
                  child: CardPreview(d.cover),
                ),
              ),
              title: Text(d.cover.caption.get.titled),
              subtitle: Text(
                [
                  d.pack.length,
                  if (d.translation != null) d.translation.titled,
                ].join(' • '),
              ),
              trailing: StatusIcon(d.status),
            ),
        ],
      ),
    );
  }
}
