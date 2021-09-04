import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:just_audio/just_audio.dart';
import 'data/chapter.dart';

final _player = AudioPlayer();

void playItem(Chapter chapter, [Translation? item]) async {
  final path = [
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
    if (_player.playing) await _player.stop();
    await _player.setAsset(path);
    await _player.play();
  } catch (e) {
    print(e);
  }
}
