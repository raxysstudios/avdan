import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../widgets/cards_viewer.dart';

void openHome(BuildContext context) async {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute<void>(
      builder: (context) => HomeScreen(),
    ),
  );
}

void openCardsView(
  BuildContext context,
  Deck deck,
  int card,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color.alphaBlend(
      deck.pack.color?.bg ?? Colors.transparent,
      Theme.of(context).colorScheme.surface,
    ),
    clipBehavior: Clip.antiAlias,
    useSafeArea: true,
    builder: (context) {
      return CardsViewer(deck, initial: card);
    },
  );
}
