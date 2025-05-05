import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_date.freezed.dart';
part 'delivery_date.g.dart';

@freezed
class DeliveryDate with _$DeliveryDate {
  factory DeliveryDate({
    required String date,
    required String dateFormatted,
  }) = _DeliveryDate;

  factory DeliveryDate.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDateFromJson(json);
}
