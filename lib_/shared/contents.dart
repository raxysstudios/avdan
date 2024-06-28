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

Future<void> clearDeck(Deck deck) async {
  await _decks.delete(deck.pack.id);
  for (final c in deck.cards) {
    await _medias.delete(c.audioPath);
    await _medias.delete(c.imagePath);
  }
}

Future<void> putAsset(String key, Uint8List? data) async {
  if (data != null) await _medias.put(key, data);
}

Uint8List? getAsset(String? key) {
  return key == null ? null : _medias.get(key);
}

Future<void> putDeck(Deck deck) {
  return _decks.put(
    deck.pack.id,
    jsonEncode(deck.toJson()),
  );
}

Map<String, Deck> getAllDecks() {
  final decks = _decks.values
      .map((j) => Deck.fromJson(
            jsonDecode(j) as Map<String, dynamic>,
          ))
      .toList();
  decks.sort((a, b) => a.pack.order - b.pack.order);
  return {
    for (final d in decks) d.pack.id: d,
  };
}
