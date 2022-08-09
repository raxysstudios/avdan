import 'package:just_audio/just_audio.dart';

var _player = AudioPlayer();

void play(String url) async {
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
