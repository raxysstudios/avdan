import 'package:audioplayers/audio_cache.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final audioCache = AudioCache();
final audioPlayer = AudioPlayer();

playAsset(String path) async {
  try {
    if (kIsWeb) {
      if (audioPlayer.playing) await audioPlayer.stop();
      await audioPlayer.setAsset(path);
      audioPlayer.play();
    } else
      audioCache.play(path);
  } catch (e) {
    print(e);
  }
}
