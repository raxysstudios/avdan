import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LanguageAvatar extends StatelessWidget {
  const LanguageAvatar(
    this.language, {
    super.key,
  });
  final String? language;

  static const baseUrl =
      'https://firebasestorage.googleapis.com/v0/b/avzagapp.appspot.com/o/flags%2F';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: CachedNetworkImageProvider(
        '$baseUrl$language.png?alt=media',
      ),
    );
  }
}
