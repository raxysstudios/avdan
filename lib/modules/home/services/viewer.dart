import 'package:avdan/models/deck.dart';
import 'package:flutter/material.dart';

import '../widgets/cards_viewer.dart';

void openView(
  BuildContext context,
  Deck deck,
  int card,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color.alphaBlend(
      deck.color ?? Colors.transparent,
      Theme.of(context).colorScheme.surface,
    ),
    clipBehavior: Clip.antiAlias,
    useSafeArea: true,
    builder: (context) {
      return CardsViewer(deck, initial: card);
    },
  );
}
