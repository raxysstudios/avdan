import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck_preview.freezed.dart';

enum DeckStatus { pending, downloading, unpacking, ready }

@unfreezed
class DeckPreview with _$DeckPreview {
  DeckPreview({
    required this.pack,
    required this.cover,
    required this.length,
    this.status = DeckStatus.pending,
    this.translation,
  });

  @override
  final Pack pack;
  @override
  final Card cover;
  @override
  final int length;
  @override
  DeckStatus status;
  @override
  final String? translation;
}
