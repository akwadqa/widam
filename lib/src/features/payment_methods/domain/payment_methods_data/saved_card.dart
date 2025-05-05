import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_card.freezed.dart';
part 'saved_card.g.dart';

@freezed
class SavedCard with _$SavedCard {
  factory SavedCard({
    required String paymentTokenId,
    required String cardNumber,
    required String cardExpiryDate,
    required String cardType,
    required String icon,
  }) = _SavedCard;

  factory SavedCard.fromJson(Map<String, dynamic> json) =>
      _$SavedCardFromJson(json);
}
