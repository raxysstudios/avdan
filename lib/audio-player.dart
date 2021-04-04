import 'package:just_audio/just_audio.dart';

final audioPlayer = AudioPlayer();

playAsset(String path) async {
  if (audioPlayer.playing) audioPlayer.stop();
  try {
    await audioPlayer.setAsset(path);
    audioPlayer.play();
  } catch (e) {
    print(e);
  }
}
