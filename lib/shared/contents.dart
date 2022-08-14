import 'dart:convert';
import 'dart:typed_data';

import 'package:avdan/models/deck.dart';
import 'package:hive/hive.dart';

late final Box<String> _decks;
late final Box<Uint8List> _medias;

Future<void> initContents() async {
  _decks = await Hive.openBox<String>('decks');
  _medias = await Hive.openBox<Uint8List>('media');
}

bool get hasDecks => _decks.isNotEmpty;

Future<void> clearContents() async {
  await _decks.clear();
  await _medias.clear();
}

Future<void> putAsset(String? key, Uint8List? data) async {
  if (key != null && data != null) await _medias.put(key, data);
}

Uint8List? getAsset(String? key) {
  return _medias.get(key);
}

Future<void> putDeck(Deck deck) {
  return _decks.put(
    deck.pack.id,
    jsonEncode(deck.toJson()),
  );
}

Map<String, Deck> getAllDecks() {
  return {
    for (final k in _decks.keys)
      k as String: Deck.fromJson(
        jsonDecode(_decks.get(k)!) as Map<String, dynamic>,
      )
  };
}
