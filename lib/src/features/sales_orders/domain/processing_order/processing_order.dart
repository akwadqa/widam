import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_order.freezed.dart';
part 'processing_order.g.dart';

@freezed
class ProcessingOrder with _$ProcessingOrder {
  factory ProcessingOrder({
    bool? hasProcessingOrders,
    String? reviewingOrders,
  }) = _ProcessingOrder;

  factory ProcessingOrder.fromJson(Map<String, dynamic> json) =>
      _$ProcessingOrderFromJson(json);
}
