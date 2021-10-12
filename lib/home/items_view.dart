import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ItemsView extends StatefulWidget {
  final Chapter chapter;
  final int initialItem;
  final ValueSetter<int>? onChange;

  const ItemsView(
    this.chapter, {
    this.initialItem = 0,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  ItemsViewState createState() => ItemsViewState();
}

class ItemsViewState extends State<ItemsView> {
  late final PageController _pageController;
  List<Translation> get items => widget.chapter.items;
  // late Translation item = widget.items[widget.initialItem];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialItem,
    );
    // _pageController.addListener(() {
    //   final item = widget.chapter.items[_pageController.page?.round() ?? 0];
    //   if (this.item != item) {
    //     setState(() {
    //       this.item = item;
    //     });
    //     widget.onChange?.call(item);
    //   }
    // });
    widget.onChange?.call(widget.initialItem);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChange?.call(
        _pageController.page?.round() ?? 0,
      ),
      child: PageView.builder(
        onPageChanged: widget.onChange,
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return Stack(
            alignment: Alignment.center,
            children: [
              if (widget.chapter.alphabet)
                FittedBox(
                  fit: BoxFit.contain,
                  child: Consumer<Store>(
                    builder: (content, store, child) {
                      final text = item.text(store.learning, store.alt);
                      return Text(
                        '${text.toUpperCase()}\n$text',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 96,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                )
              else ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 32),
                  child: Consumer<Store>(
                    builder: (context, store, child) {
                      return Image(
                        image: item.image(),
                      );
                    },
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
