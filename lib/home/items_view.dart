import 'package:avdan/data/chapter.dart';
import 'package:avdan/data/translation.dart';
import 'package:avdan/audio_player.dart';
import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemsView extends StatefulWidget {
  final Chapter chapter;
  final Translation item;

  ItemsView({
    required this.chapter,
    required this.item,
  });

  @override
  ItemsViewState createState() => ItemsViewState();
}

class ItemsViewState extends State<ItemsView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.chapter.items.indexOf(widget.item),
    );
    playItem(
      widget.chapter,
      widget.item,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => playItem(
        widget.chapter,
        widget.chapter.items[_pageController.page?.round() ?? 0],
      ),
      child: Container(
        color: widget.chapter.color,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.chapter.items.length,
          itemBuilder: (_, i) {
            final item = widget.chapter.items[i];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  if (item.global == null)
                    Center(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          item.learning!.toUpperCase() + '\n' + item.learning!,
                          style: TextStyle(
                            fontSize: 96,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else ...[
                    Center(
                      child: Positioned.fill(
                        child: Image.asset(
                          widget.chapter.getImageURL(item),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                          errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) =>
                              Container(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Label(
                          item,
                          titleSize: 36,
                          subtitleSize: 30,
                          textAlign: TextAlign.center,
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
    );
  }
}
