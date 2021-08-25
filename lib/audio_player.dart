import 'package:avdan/data/translation.dart';
import 'package:avdan/store.dart';
import 'package:just_audio/just_audio.dart';
import 'data/chapter.dart';

final player = AudioPlayer();

Future<void> playAsset(String path) async {
  try {
    if (player.playing) await player.stop();
    await player.setAsset(path);
    player.play();
  } catch (e) {
    print(e);
  }
}

playItem(Chapter chapter, Translation item) {
  final path = [
    'assets',
    'audio',
    Store.learning.name.id,
    chapter.title.id,
    chapter.alphabet ? item.learning : item.id,
  ].join('/');
  playAsset(path + '.mp3');
}
