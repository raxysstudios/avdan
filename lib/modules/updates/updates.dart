import 'package:avdan/modules/updates/models/deck_preview.dart';
import 'package:avdan/modules/updates/widgets/loading_chip.dart';
import 'package:avdan/shared/localizations.dart';
import 'package:avdan/shared/utils.dart';
import 'package:avdan/shared/widgets/card_button.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/loader.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({super.key});

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final loading = <DeckPreview>[];

  @override
  void initState() {
    super.initState();
    update(
      context,
      (d) => setState(() => loading.add(d)),
      (d) => setState(() {}),
      (d) => setState(() {}),
    ).then((_) => launch(context));
  }

  @override
  Widget build(BuildContext context) {
    final alt = context.watch<Store>().alt;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localize('updates')),
        centerTitle: true,
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
                  child: CardButton(d.cover),
                ),
              ),
              title: Text(capitalize(d.cover.caption.get(alt))),
              subtitle: d.translation == null
                  ? null
                  : Text(capitalize(d.translation!)),
              trailing: LoadingChip(d.loaded, d.length),
            ),
        ],
      ),
    );
  }
}
