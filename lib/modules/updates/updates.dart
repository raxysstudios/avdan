import 'package:avdan/l10n/utils.dart';
import 'package:avdan/models/pack.dart';
import 'package:avdan/modules/home/services/openers.dart';
import 'package:avdan/modules/updates/providers/deck_preview.dart';
import 'package:avdan/modules/updates/providers/updater_qubit.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/prefs.dart';
import 'package:avdan/shared/widgets/card_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/decks.dart';
import 'services/packs.dart';

class UpdatesScreen extends StatefulWidget {
  const UpdatesScreen({
    super.key,
    this.reset = false,
  });

  final bool reset;

  @override
  State<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends State<UpdatesScreen> {
  final updater = UpdaterCubit();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    updater.close();
    super.dispose();
  }

  void init() async {
    Future<void> downloadDeck(Pack p) async {
      final deck = await fetchDeckPreview(
        Prefs.learningLanguage!.name,
        Prefs.interfaceLanguage,
        p,
      );
      updater.addDeck(deck);
      await fetchDeck(p.id);
      updater.markDeckReady(deck);
    }

    final language = Prefs.learningLanguage;
    if (language == null) return;

    if (widget.reset) {
      await clearContents();
    }

    final pending = await refreshPacksList();
    await Future.wait(
      [for (final p in pending) downloadDeck(p)],
    );
    openHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: updater,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: BlocBuilder<UpdaterCubit, List<DeckPreview>>(
              builder: (context, decks) {
                final ready = decks.where((d) => d.isReady).length;
                final total = decks.length;
                return Text('${context.t.updates} $ready/$total');
              },
            ),
          ),
          body: BlocBuilder<UpdaterCubit, List<DeckPreview>>(
            builder: (context, decks) {
              return ListView(
                children: [
                  for (final d in decks)
                    ListTile(
                      leading: AspectRatio(
                        aspectRatio: 1,
                        child: Card(
                          elevation: 0,
                          color: d.pack.color?.bg,
                          margin: EdgeInsets.zero,
                          child: CardPreview(d.cover),
                        ),
                      ),
                      title: Text(d.cover.caption.get.titled),
                      subtitle: Text(d.translation.titled),
                      trailing: d.isReady
                          ? Icon(Icons.check_rounded)
                          : CircularProgressIndicator(
                              constraints: BoxConstraints.tight(
                                Size.square(24),
                              ),
                            ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
