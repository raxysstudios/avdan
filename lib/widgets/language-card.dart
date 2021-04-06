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
      elevation: selected ? 8 : 2,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 256,
          child: ClipRect(
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
                Container(
                  alignment: Alignment.bottomRight,
                  // transform: Matrix4.identity()..scale(3),
                  child: Image.asset(
                    language.flag,
                    height: 32,
                    errorBuilder: (
                      BuildContext context,
                      Object exception,
                      StackTrace? stackTrace,
                    ) =>
                        Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
