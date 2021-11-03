import 'package:avdan/data/chapter.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ItemsView extends StatelessWidget {
  ItemsView(
    this.chapter, {
    int initialItem = 0,
    this.onChange,
    Key? key,
  }) : super(key: key) {
    _pageController = PageController(
      initialPage: initialItem,
    );
  }

  final Chapter chapter;
  final ValueSetter<int>? onChange;
  late final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChange?.call(
        _pageController.page?.round() ?? 0,
      ),
      child: PageView.builder(
        onPageChanged: onChange,
        controller: _pageController,
        itemCount: chapter.items.length,
        itemBuilder: (context, i) {
          final item = chapter.items[i];
          final store = context.watch<Store>();
          final text = item.text(store.learning, store.alt);
          return Stack(
            alignment: Alignment.center,
            children: [
              if (chapter.alphabet)
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '${text.toUpperCase()}\n${text.toLowerCase()}',
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
                    image: item.image(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Label(item, titleSize: 36, subtitleSize: 30),
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
