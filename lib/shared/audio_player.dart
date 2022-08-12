import 'dart:typed_data';

import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

var _player = AudioPlayer();

void playCard(BuildContext context, avd.Card card) async {
  try {
    await _player.dispose();
    final player = AudioPlayer();
    _player = player;

    final audio = context.read<Store>().media.get('{card.id}.mp3');
    if (audio != null) {
      await player.setAudioSource(_BytesSource(audio));
      await player.play();
    }
  } catch (e) {
    rethrow;
  }
}

class _BytesSource extends StreamAudioSource {
  final Uint8List _buffer;

  _BytesSource(this._buffer) : super(tag: 'BytesSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: _buffer.length,
      contentLength: (start ?? 0) - (end ?? _buffer.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([_buffer.sublist(start ?? 0, end)]),
      contentType: 'audio/mpeg',
    );
  }
}
