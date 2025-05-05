import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/address.dart';

part 'delivery_trip.freezed.dart';
part 'delivery_trip.g.dart';

@freezed
class DeliveryTrip with _$DeliveryTrip {
  factory DeliveryTrip({
    required String status,
    required String driverName,
    required String driverCellNumber,
    required Address driverAddress,
  }) = _DeliveryTrip;

  factory DeliveryTrip.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTripFromJson(json);
}
