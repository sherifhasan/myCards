import 'dart:convert';

import 'package:challenge/application/utils/app_constants.dart';
import 'package:challenge/domain/cards/models/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_source.dart';

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImpl(this._sharedPreferences);

  void saveCards(List<CardModel> cards) {
    _sharedPreferences.setStringList(AppConstants.cardsPrefsKey,
        cards.map((item) => jsonEncode(item.toJson())).toList());
  }

  @override
  List<CardModel> addCard(CardModel cardModel) {
    final cards = getCards();
    cards.add(cardModel);
    saveCards(cards);
    return cards;
  }

  @override
  List<CardModel> editCard(CardModel cardModel) {
    final cards = getCards();
    cards[cards.indexWhere((element) => element.iban == cardModel.iban)] =
        cardModel;
    saveCards(cards);
    return cards;
  }

  @override
  List<CardModel> getCards() {
    if (_sharedPreferences.containsKey(AppConstants.cardsPrefsKey)) {
      final cardsPrefsList =
          _sharedPreferences.getStringList(AppConstants.cardsPrefsKey);

      final cards = cardsPrefsList!
          .map((item) => CardModel.fromJson(json.decode(item)))
          .toList();

      return cards;
    } else {
      return <CardModel>[];
    }
  }

  @override
  List<CardModel> removeCard(CardModel cardModel) {
    final cards = getCards();
    cards.remove(cardModel);
    saveCards(cards);
    return cards;
  }
}
