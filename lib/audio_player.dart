import 'package:avdan/data/translation.dart';
import 'package:just_audio/just_audio.dart';
import 'data/chapter.dart';
import 'data/language.dart';

var _player = AudioPlayer();

void playItem(
  Language language,
  Chapter chapter, [
  Translation? item,
]) async {
  final name = item == null
      ? chapter.id
      : chapter.alphabet
          ? item.get(language.alt) ?? item.get(language.id)
          : item.id;
  final url = [
    'assets',
    'audio',
    language.id,
    chapter.title.id,
    '$name.mp3',
  ].join('/');

  try {
    await _player.dispose();
    final player = AudioPlayer();
    _player = player;

    await player.setAsset(url);
    await player.play();
  } catch (e) {
    rethrow;
  }
}
