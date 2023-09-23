import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_center.freezed.dart';
part 'delivery_center.g.dart';

@freezed
class DeliveryCenter with _$DeliveryCenter {
  const factory DeliveryCenter({
    required String deliveryCenterId,
    required String deliveryCenterTitle,
    required String warehouseId,
    required String warehouseName,
  }) = _DeliveryCenter;

  factory DeliveryCenter.fromJson(Map<String, dynamic> json) =>
      _$DeliveryCenterFromJson(json);
}
