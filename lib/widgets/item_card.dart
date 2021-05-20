import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/label.dart';
import 'package:avdan/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {required this.translations,
      this.labeled = true,
      this.selected = false,
      this.onTap});
  final Translations translations;
  final bool selected;
  final bool labeled;
  final Function()? onTap;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      onTap: onTap,
      selected: selected,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              image,
              fit: BoxFit.fitHeight,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) =>
                  Container(),
            ),
          ),
        ),
        if (labeled)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Label(translations),
          ),
      ],
    );
  }
}