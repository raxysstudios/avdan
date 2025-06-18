import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/player.dart';
import 'package:avdan/shared/widgets/label.dart';
import 'package:flutter/material.dart';

class CardsViewer extends StatefulWidget {
  const CardsViewer(
    this.deck, {
    this.initial = 0,
    super.key,
  });

  final Deck deck;
  final int initial;

  @override
  State<CardsViewer> createState() => _CardsViewerState();
}

class _CardsViewerState extends State<CardsViewer> {
  late final pages = PageController(
    initialPage: widget.initial,
  );

  @override
  void initState() {
    super.initState();
    play(widget.initial);
  }

  void play(int i) {
    playCard(widget.deck.cards[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: () => play(
            pages.page?.round() ?? 0,
          ),
          child: PageView.builder(
            onPageChanged: play,
            controller: pages,
            itemCount: widget.deck.cards.length,
            itemBuilder: (context, i) {
              final card = widget.deck.cards[i];
              final caption = card.caption.get;
              final image = getAsset(card.imagePath);
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (image == null)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          [
                            caption.toUpperCase(),
                            caption.toLowerCase(),
                          ].join('\n'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 96,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
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
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 8,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => pages.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                ),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              IconButton(
                onPressed: () => pages.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                ),
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
