import 'package:avdan/models/deck.dart';
import 'package:avdan/shared/contents.dart';
import 'package:avdan/shared/extensions.dart';
import 'package:avdan/shared/widgets/label.dart';
import 'package:flutter/material.dart';

class CardsView extends StatefulWidget {
  const CardsView(
    this.deck, {
    this.initial = 0,
    this.onChange,
    this.leading,
    super.key,
  });

  final Deck deck;
  final int initial;
  final ValueSetter<int>? onChange;
  final Widget? leading;

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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        InkWell(
          onTap: () => widget.onChange?.call(
            _paging.page?.round() ?? 0,
          ),
          child: PageView.builder(
            onPageChanged: widget.onChange,
            controller: _paging,
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
            children: [
              if (widget.leading != null) widget.leading!,
              const Spacer(),
              IconButton(
                onPressed: () => _paging.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                ),
                icon: const Icon(Icons.arrow_back_outlined),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _paging.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOutCubic,
                ),
                icon: const Icon(Icons.arrow_forward_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
