import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.freezed.dart';

part 'card_model.g.dart';

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String iban,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
}
