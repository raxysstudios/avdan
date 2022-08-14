import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/contents_store.dart';
import 'package:avdan/shared/widgets/label.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsView extends StatefulWidget {
  const CardsView(
    this.deck, {
    this.initial = 0,
    this.onChange,
    super.key,
  });

  final Deck deck;
  final int initial;
  final ValueSetter<int>? onChange;

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  late final _paging = PageController(
    initialPage: widget.initial,
  );

  @override
  void initState() {
    super.initState();
    widget.onChange?.call(widget.initial);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChange?.call(
        _paging.page?.round() ?? 0,
      ),
      child: PageView.builder(
        onPageChanged: widget.onChange,
        controller: _paging,
        itemCount: widget.deck.cards.length,
        itemBuilder: (context, i) {
          final card = widget.deck.cards[i];
          final caption = card.caption.get(context.read<Store>().alt);
          final image = getAsset(card.imagePath);
          return Stack(
            alignment: Alignment.center,
            children: [
              if (image == null)
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    [caption.toUpperCase(), caption.toLowerCase()].join('\n'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 96,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
                  child: Image.memory(image),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Label(
                      caption,
                      widget.deck.translate(card),
                      titleSize: 36,
                      subtitleSize: 30,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
