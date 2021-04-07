import 'dart:async';
import 'dart:math';

import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/language_card.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LanguageList extends StatefulWidget {
  LanguageList(this.languages, {this.selected, this.onSelect});
  final List<Language> languages;
  final ValueSetter<Language>? onSelect;
  final Language? selected;

  @override
  _LanguageListState createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  final ItemScrollController _scrollController = new ItemScrollController();

  @override
  initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () => scroll());
  }

  scroll() {
    var i = -1;
    if (widget.selected != null)
      i = widget.languages.indexOf(widget.selected as Language);
    _scrollController.jumpTo(index: max(i, 0));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      child: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.languages.length,
        itemBuilder: (context, index) {
          var lang = widget.languages[index];
          return LanguageCard(
            lang,
            selected: widget.selected == lang,
            onTap: () => widget.onSelect?.call(lang),
          );
        },
      ),
    );
  }
}
