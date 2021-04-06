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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Label(translations: translations),
            ),
            if (selected)
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
