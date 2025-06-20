import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck_preview.freezed.dart';

@unfreezed
class DeckPreview with _$DeckPreview {
  DeckPreview({
    required this.pack,
    required this.cover,
    required this.length,
    this.isReady = false,
    this.translation,
  });

  @override
  final Pack pack;
  @override
  final Card cover;
  @override
  final int length;
  @override
  bool isReady;
  @override
  final String? translation;
}
