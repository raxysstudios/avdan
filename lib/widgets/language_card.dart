import 'package:avdan/data/language.dart';
import 'package:avdan/widgets/check_mark.dart';
import 'package:avdan/widgets/language_flag.dart';
import 'package:avdan/widgets/language_title.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(this.language, {this.selected = false, this.onTap});
  final Language language;
  final bool selected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 192,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: LanguageFlag(
                  language,
                  offset: Offset(-24, 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LanguageTitle(language),
              ),
              CheckMark(selected),
            ],
          ),
        ),
      ),
    );
  }
}
