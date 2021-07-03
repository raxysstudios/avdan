import 'package:avdan/data/translations.dart';
import 'package:avdan/widgets/label.dart';
import 'package:avdan/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    required this.translations,
    this.root = '',
    this.labeled = true,
    this.selected = false,
    this.onTap,
  });
  final Translations translations;
  final String root;
  final bool selected;
  final bool labeled;
  final Function()? onTap;

  String get image {
    var name = translations['english'] ?? '';
    if (root.isNotEmpty) name = root + '/' + name;
    return 'assets/images/$name.png';
  }

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      onTap: onTap,
      selected: selected,
      children: textOnly(translations)
          ? [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      learning(translations).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          : [
              Positioned.fill(
                top: labeled ? 32 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.bottomRight,
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
                  padding: const EdgeInsets.all(8),
                  child: Label(translations),
                ),
            ],
    );
  }
}
