import 'package:avdan/data/chapter.dart';
import 'package:flutter/material.dart';
import 'item_card.dart';

class ChapterTabs extends StatefulWidget {
  final List<Chapter> chapters;
  final TabController controller;
  const ChapterTabs({
    required this.controller,
    required this.chapters,
  });

  @override
  _ChapterTabsState createState() => _ChapterTabsState();
}

class _ChapterTabsState extends State<ChapterTabs> {
  var color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    color = fixTransparent(color);
    widget.controller.animation?.addListener(() {
      final animation = widget.controller.animation?.value ?? 0;
      final colorA = fixTransparent(widget.chapters[animation.floor()].color);
      final colorB = fixTransparent(widget.chapters[animation.ceil()].color);
      setState(() {
        color = Color.lerp(
          colorA,
          colorB,
          animation.remainder(1),
        )!;
      });
    });
  }

  Color fixTransparent(Color color) {
    return color.opacity == 0 ? Theme.of(context).highlightColor : color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.25),
            blurRadius: 2,
          )
        ],
      ),
      height: 98,
      child: Offstage(),
      // child: TabBar(
      //   controller: widget.controller,
      //   isScrollable: true,
      //   labelPadding: EdgeInsets.zero,
      //   indicatorPadding: const EdgeInsets.symmetric(
      //     horizontal: 4,
      //     vertical: 6,
      //   ),
      //   indicator: ShapeDecoration(
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(4),
      //     ),
      //     color: color,
      //   ),
      //   tabs: [
      //     for (var i = 0; i < widget.chapters.length; i++)
      //       Builder(
      //         builder: (_) {
      //           final chapter = widget.chapters[i];
      //           return AspectRatio(
      //             aspectRatio: 1,
      //             child: Padding(
      //               padding: const EdgeInsets.only(top: 2),
      //               child: ItemCard(
      //                 color: fixTransparent(chapter.color),
      //                 item: chapter.alphabet ? chapter.items.first : null,
      //                 image: chapter.alphabet
      //                     ? null
      //                     : chapter.getImageURL(chapter.items.first),
      //                 onTap: () => widget.controller.animateTo(i),
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //   ],
      // ),
    );
  }
}
