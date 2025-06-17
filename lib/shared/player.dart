import 'package:audioplayers/audioplayers.dart';
import 'package:avdan/models/card.dart';
import 'package:avdan/shared/contents.dart';
import 'package:flutter/foundation.dart';

final _player = AudioPlayer();

Future<void> stopPlayer() async {
  await _player.stop();
}

Future<void> playAsset(String key) async {
  try {
    await stopPlayer();
    final assetBytes = getAsset(key);
    if (assetBytes != null) {
      await _player.play(BytesSource(assetBytes));
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

void playCard(Card card) {
  final key = card.audioPath;
  if (key != null) {
    playAsset(key);
  }
}
