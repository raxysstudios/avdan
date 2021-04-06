import 'package:avdan/data/language.dart';
import 'package:avdan/data/store.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard(this.language, {this.selected = false, this.onTap});
  final Language language;
  final bool selected;
  final Function()? onTap;

  String get translatedName =>
      language.translations[interfaceLanguage.name] ?? 'null';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 6 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 256,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalize(language.nativeName),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: selected ? Colors.blue : Colors.black,
                      ),
                    ),
                    Text(
                      capitalize(translatedName),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Transform(
                  transform: Matrix4.identity()
                    ..scale(1.25)
                    ..translate(6, 68)
                    ..rotateZ(-0.785),
                  child: Image.asset(
                    language.flag,
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
            ],
          ),
        ),
      ),
    );
  }
}
