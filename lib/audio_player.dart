import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avdan/data/translations.dart';
import 'package:avdan/store.dart';
import 'data/chapter.dart';

final player = AssetsAudioPlayer();

playAsset(String path) async {
  try {
    player.open(Audio(path));
  } catch (e) {
    print(e);
  }
}

playItem(Chapter chapter, Translations? item) {
  final root = chapter.translations['english']!;
  if (item == null) item = chapter.translations;
  final name = item['english'] ?? learning(item);
  final path = 'assets/audio/${learningLanguage.name}/$root/$name.mp3';
  playAsset(path);
}
