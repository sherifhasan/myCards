import 'package:bloc/bloc.dart';
import 'package:challenge/domain/cards/card_repository.dart';
import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_cubit.freezed.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  final CardRepository _repository;

  CardCubit(this._repository) : super(const CardState.initial()) {
    getCards();
  }

  void getCards() {
    final cards = _repository.getCards();
    if (cards.isNotEmpty) {
      emit(CardState.data(cards));
    }
  }

  void addCard(CardModel card) {
    emit(CardState.data(_repository.addCard(card)));
  }

  void editCard(CardModel card) {
    emit(CardState.data(_repository.editCard(card)));
  }

  void removeCard(CardModel card) {
    emit(CardState.data(_repository.removeCard(card)));
  }
}
