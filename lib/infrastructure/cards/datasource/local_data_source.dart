import 'package:challenge/domain/cards/models/card_model.dart';

abstract class LocalDataSource {
  List<CardModel> getCards();

  List<CardModel> addCard(CardModel cardModel);

  List<CardModel> editCard(CardModel cardModel);

  List<CardModel> removeCard(CardModel cardModel);
}
