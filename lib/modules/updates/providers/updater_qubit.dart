import 'package:avdan/modules/updates/providers/deck_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdaterCubit extends Cubit<List<DeckPreview>> {
  UpdaterCubit() : super([]);

  Future<void> addDeck(DeckPreview deck) async {
    emit([...state, deck]);
  }

  void markDeckReady(DeckPreview deck) {
    final index = state.indexOf(deck);
    if (index < 0) return;

    final state_ = [...state];
    state_[index] = deck.copyWith(isReady: true);
    emit(state_);
  }
}
