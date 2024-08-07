import 'package:challenge/domain/cards/card_repository.dart';
import 'package:challenge/domain/cards/models/card_model.dart';

import 'datasource/local_data_source.dart';

class CardRepositoryImpl extends CardRepository {
  final LocalDataSource _localDataSource;

  CardRepositoryImpl(this._localDataSource);

  @override
  List<CardModel> addCard(CardModel cardModel) {
    return _localDataSource.addCard(cardModel);
  }

  @override
  List<CardModel> editCard(CardModel cardModel) {
    return _localDataSource.editCard(cardModel);
  }

  @override
  List<CardModel> getCards() {
    return _localDataSource.getCards();
  }

  @override
  List<CardModel> removeCard(CardModel cardModel) {
    return _localDataSource.removeCard(cardModel);
  }
}
