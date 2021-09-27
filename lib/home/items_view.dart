import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemsView extends StatefulWidget {
  final Chapter chapter;
  final Translation item;

  const ItemsView({
    Key? key,
    required this.chapter,
    required this.item,
  }) : super(key: key);

  @override
  ItemsViewState createState() => ItemsViewState();
}

class ItemsViewState extends State<ItemsView> {
  late final PageController _pageController;
  late Translation item = widget.item;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.chapter.items.indexOf(widget.item),
    );
    _pageController.addListener(() {
      final item = widget.chapter.items[_pageController.page?.round() ?? 0];
      if (this.item != item) {
        setState(() {
          this.item = item;
          playItem(widget.chapter, item);
        });
      }
    });
    playItem(widget.chapter, item);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playItem(widget.chapter, item),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.chapter.items.length,
        itemBuilder: (_, i) {
          final item = widget.chapter.items[i];
          return Stack(
            alignment: Alignment.center,
            children: [
              if (item.id == null)
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    item.learning!.toUpperCase() + '\n' + item.learning!,
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
                  child: Image.asset(
                    widget.chapter.getImageURL(item),
                    errorBuilder: (_, __, ___) {
                      return const Center(
                        child: Text('?'),
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
