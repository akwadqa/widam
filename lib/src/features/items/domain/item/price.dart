import 'package:freezed_annotation/freezed_annotation.dart';

part 'price.freezed.dart';
part 'price.g.dart';

@freezed
class Price with _$Price {
  factory Price({
    required double websiteItemPrice,
    required String? discountTitle,
    required double discountPercent,
    required double discountAmount,
    required double discountedPrice,
    required String currency,
  }) = _Price;

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
}
