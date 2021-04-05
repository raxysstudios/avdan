import 'package:audioplayers/audio_cache.dart';

final audioPlayer = AudioCache();

playAsset(String path) async {
  try {
    audioPlayer.play(path);
  } catch (e) {
    print(e);
  }
}
