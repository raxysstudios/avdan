import 'package:avdan/models/card.dart';
import 'package:avdan/shared/contents.dart';
import 'package:flutter_sound/flutter_sound.dart';

final _player = FlutterSoundPlayer();

Future<void> initPlayer() {
  return _player.openPlayer();
}

void playAsset(String key) async {
  try {
    _player.stopPlayer();
    _player.startPlayer(
      fromDataBuffer: getAsset(key),
    );
  } catch (e) {
    rethrow;
  }
}

void playCard(Card card) {
  final key = card.audioPath;
  if (key != null) playAsset(key);
}
