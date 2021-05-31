import 'package:assets_audio_player/assets_audio_player.dart';

final player = AssetsAudioPlayer();

playAsset(String path) async {
  try {
    player.open(Audio(path));
  } catch (e) {
    print(e);
  }
}
