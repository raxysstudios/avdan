import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/shared/utils.dart';
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsView extends StatefulWidget {
  const CardsView(
    this.cards, {
    this.initial = 0,
    this.onChange,
    super.key,
  });

  final List<avd.Card> cards;
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChange?.call(
        _paging.page?.round() ?? 0,
      ),
      child: PageView.builder(
        onPageChanged: widget.onChange,
        controller: _paging,
        itemCount: widget.cards.length,
        itemBuilder: (context, i) {
          final card = widget.cards[i];
          final caption = card.caption.get(context.read<Store>().alt);
          return Stack(
            alignment: Alignment.center,
            children: [
              if (card.imageUrl == null)
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
                  child: Image(
                    image: getCardImage(card),
                  ),
                ),
                // TODO translate
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 24),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Label(item, titleSize: 36, subtitleSize: 30),
                //   ),
                // ),
              ],
            ],
          );
        },
      ),
    );
  }
}