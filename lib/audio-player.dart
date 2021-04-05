import 'package:just_audio/just_audio.dart';

final audioPlayer = AudioPlayer();

playAsset(String path) async {
  try {
    if (audioPlayer.playing) await audioPlayer.stop();
    await audioPlayer.setAsset(path);
    audioPlayer.play();
  } catch (e) {
    print(e);
  }
}
