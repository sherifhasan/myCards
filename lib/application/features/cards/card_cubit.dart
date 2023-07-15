import 'package:challenge/domain/cards/card_repository.dart';
import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:challenge/infrastructure/cards/card_repository_imp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverbloc/riverbloc.dart';

part 'card_cubit.freezed.dart';

part 'card_state.dart';

final cardCubitProvider = BlocProvider.autoDispose<CardCubit, CardState>(
    (ref) => CardCubit(ref.watch(cardRepositoryProvider)));

class CardCubit extends Cubit<CardState> {
  final CardRepository _repository;

  CardCubit(this._repository) : super(const CardState.initial());

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
