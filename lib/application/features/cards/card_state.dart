part of 'card_cubit.dart';

@freezed
class CardState with _$CardState {
  const factory CardState.initial() = _Initial;

  const factory CardState.loading() = _Loading;

  const factory CardState.data(List<CardModel> cards) = _Data;
}
