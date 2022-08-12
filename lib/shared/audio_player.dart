import 'dart:typed_data';

// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:avdan/models/card.dart' as avd;
import 'package:avdan/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

var _player = AudioPlayer();

void playCard(BuildContext context, avd.Card card) async {
  try {
    await _player.dispose();
    final player = AudioPlayer();
    _player = player;

    final audio = context.read<Store>().media.get(card.audioPath);
    // final p = AssetsAudioPlayer();
    // p.open(Audio.liveStream(path))
    final p = FlutterSoundPlayer();
    await p.openPlayer();
    p.startPlayer(fromDataBuffer: audio);

    // if (audio != null) {
    //   await player.setAudioSource(BufferAudioSource(audio));
    //   await player.play();
    // }
  } catch (e) {
    rethrow;
  }
}

class BufferAudioSource extends StreamAudioSource {
  BufferAudioSource(this._buffer) : super(tag: 'Bla');
  final Uint8List _buffer;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) {
    start = start ?? 0;
    end = end ?? _buffer.length;
    return Future.value(
      StreamAudioResponse(
        sourceLength: _buffer.length,
        contentLength: end - start,
        offset: start,
        contentType: 'audio/mpeg',
        stream: Stream.value(
          List<int>.from(
            _buffer.skip(start).take(end - start),
          ),
        ),
      ),
    );
  }
}
