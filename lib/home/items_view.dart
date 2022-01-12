import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsView extends StatelessWidget {
  ItemsView(
    this.items, {
    Translation? initialItem,
    this.onChange,
    this.isAlphabet = false,
    Key? key,
  }) : super(key: key) {
    _pageController = PageController(
      initialPage: initialItem == null ? 0 : items.indexOf(initialItem),
    );
  }

  final bool isAlphabet;
  final List<Translation> items;
  final ValueSetter<int>? onChange;
  late final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<Store>();

    return InkWell(
      onTap: () => onChange?.call(
        _pageController.page?.round() ?? 0,
      ),
      child: PageView.builder(
        onPageChanged: onChange,
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          final text = item.text(store.learning, store.alt);
          return Stack(
            alignment: Alignment.center,
            children: [
              if (isAlphabet)
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
