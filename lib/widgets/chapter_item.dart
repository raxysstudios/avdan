import 'package:avdan/widgets/label.dart';
import 'package:flutter/material.dart';

class ChapterItem extends StatelessWidget {
  ChapterItem({required this.translations, this.selected = false, this.onTap});
  final Map<String, String> translations;
  final bool selected;
  final Function()? onTap;

  String get name => translations['english'] ?? '';
  String get image => 'assets/images/$name.png';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? Colors.blue[50] : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) =>
                      Container(),
                ),
              ),
              Label(translations: translations),
            ],
          ),
        ),
      ),
    );
  }
}
