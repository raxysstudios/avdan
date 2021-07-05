import 'package:avdan/data/translation.dart';
import 'package:avdan/widgets/label.dart';
import 'package:avdan/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    required this.item,
    required this.image,
    this.labeled = true,
    this.selected = false,
    this.onTap,
  });
  final Translation item;
  final String image;
  final bool selected;
  final bool labeled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      onTap: onTap,
      selected: selected,
      children: item.global == null
          ? [
              Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item.learning!.toUpperCase(),
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
                  child: Label(item),
                ),
            ],
    );
  }
}
