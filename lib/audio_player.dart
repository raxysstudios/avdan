import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:just_audio/just_audio.dart';
import 'data/chapter.dart';

var _player = AudioPlayer();

void playItem(Chapter chapter, [Translation? item]) async {
  final url = [
        'assets',
        'audio',
        Store.learning.name.id,
        chapter.title.id,
        item == null
            ? chapter.title.id
            : chapter.alphabet
                ? item.map[Store.learning.alt]
                : item.id,
      ].join('/') +
      '.mp3';

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
