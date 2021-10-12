import 'package:avdan/data/language.dart';

import 'data/chapter.dart';
import 'data/translation.dart';

String capitalize(String? value) {
  if (value == null) return '';
  return value
      .split(' ')
      .where((w) => w.isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

String getImageUrl(
  Chapter chapter, [
  Translation? item,
]) {
  final root = 'assets/images/${chapter.title.id}';
  final name = (item ?? chapter.items.first).id;
  return '$root/$name.png';
}

String getText(
  Translation item,
  Language language, [
  bool alt = false,
]) {
  final text = item.get(language.name.id) ?? '';
  if (!alt) return text;
  return item.get(language.alt) ?? text;
}
