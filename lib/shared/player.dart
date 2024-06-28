import 'package:avdan/models/card.dart';
import 'package:avdan/shared/contents.dart';
import 'package:soundpool/soundpool.dart';

final _player = Soundpool.fromOptions();
final _keys = <String, int>{};
int? _curr;

Future<void> resetPlayer() {
  _keys.clear();
  return _player.release();
}

void playAsset(String key) async {
  try {
    if (_curr != null) await _player.stop(_curr!);
    if (_keys.containsKey(key)) {
      _curr = _keys[key]!;
      await _player.play(_curr!);
    } else {
      final file = getAsset(key);
      if (file != null) {
        _curr = await _player.loadAndPlayUint8List(file);
        _keys[key] = _curr!;
      }
    }
  } catch (e) {
    rethrow;
  }
}

void playCard(Card card) {
  final key = card.audioPath;
  if (key != null) playAsset(key);
}
