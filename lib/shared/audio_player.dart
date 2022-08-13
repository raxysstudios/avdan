import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';

final _player = FlutterSoundPlayer();

void playCard(BuildContext context, avd.Card card) async {
  try {
    if (!_player.isOpen()) await _player.openPlayer();
    _player.stopPlayer();
    _player.startPlayer(
      fromDataBuffer: context.read<Store>().media.get(card.audioPath),
    );
  } catch (e) {
    rethrow;
  }
}
