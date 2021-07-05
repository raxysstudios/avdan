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
  final root = chapter.title.global!;
  final name = item.learning;
  final path = 'assets/audio/${learningLanguage.name}/$root/$name.mp3';
  playAsset(path);
}
