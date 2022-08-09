import 'dart:io';

import 'package:avdan/models/card.dart';
import 'package:avdan/store.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) {
  launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
}

ImageProvider getCardImage(Card card) {
  if (cachePath == null) {
    return NetworkImage(card.imageUrl!);
  }
  return FileImage(
    File('$cachePath${card.id}.png'),
  );
}
