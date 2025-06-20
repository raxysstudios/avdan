import 'package:avdan/models/card.dart';
import 'package:avdan/models/pack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@freezed
@JsonSerializable()
class Deck with _$Deck {
  const Deck({
    required this.pack,
    required this.cover,
    required this.cards,
    this.translations = const {},
  });

  @override
  final Pack pack;
  @override
  final Card cover;
  @override
  final List<Card> cards;
  @override
  final Map<String, String?> translations;

  bool isOutdated(DateTime check) {
    return pack.lastUpdated.isBefore(check);
  }

  String translate(Card card) {
    return translations[card.id] ?? '';
  }

  factory Deck.fromJson(Map<String, Object?> json) => _$DeckFromJson(json);

  Map<String, Object?> toJson() => _$DeckToJson(this);
}
