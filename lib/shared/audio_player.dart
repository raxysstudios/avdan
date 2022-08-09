import 'package:avdan/models/card.dart';
import 'package:avdan/store.dart';
import 'package:just_audio/just_audio.dart';

var _player = AudioPlayer();

void playCard(Card card) async {
  try {
    await _player.dispose();
    final player = AudioPlayer();
    _player = player;

    if (cachePath == null) {
      if (card.audioUrl == null) return;
      await player.setUrl(card.audioUrl!);
    } else {
      await player.setFilePath('$cachePath${card.id}.mp3');
    }
    await player.play();
  } catch (e) {
    rethrow;
  }
}
