import 'models/card_model.dart';

abstract class CardRepository {
  List<CardModel> getCards();

  List<CardModel> addCard(CardModel cardModel);

  List<CardModel> editCard(CardModel cardModel);

  List<CardModel> removeCard(CardModel cardModel);
}
