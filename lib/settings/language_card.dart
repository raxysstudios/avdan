import 'dart:math';
import 'package:avdan/data/language.dart';
import 'package:avdan/data/utils.dart';
import 'package:avdan/store.dart';
import 'package:avdan/widgets/language_flag.dart';
import 'package:avdan/widgets/selectable_card.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(
    this.language, {
    this.selected = false,
    this.alt,
    this.onTap,
  });
  final Language language;
  final bool selected;
  final bool? alt;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final iconSize = 24.0;
    final iconOffset = 6.0;
    return AspectRatio(
      aspectRatio: 1.75,
      child: SelectableCard(
        onTap: onTap,
        selected: selected,
        elevated: true,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: LanguageFlag(
              language,
              offset: Offset(-28, 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: capitalize(
                      Store.alt && Store.learning == language
                          ? language.name.learning
                          : language.name.map[language.name.global]!,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyText2?.color,
                    ),
                  ),
                  if (Store.interface != language)
                    TextSpan(
                      text: '\n' + capitalize(language.name.interface),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            left: alt != null ? iconSize - iconOffset : -iconSize - iconOffset,
            bottom: 0,
            duration: Duration(milliseconds: 250),
            curve: standardEasing,
            child: Container(
              width: iconSize + iconOffset,
              height: iconSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              padding: EdgeInsets.only(left: iconOffset),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: standardEasing,
                transformAlignment: Alignment.center,
                transform: Matrix4.rotationZ(alt != null && alt! ? 0 : pi),
                child: Icon(
                  Icons.swap_horiz_outlined,
                  size: iconSize - 2,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
