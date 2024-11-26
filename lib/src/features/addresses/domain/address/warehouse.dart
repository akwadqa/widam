import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse.freezed.dart';
part 'warehouse.g.dart';

@freezed
class Warehouse with _$Warehouse {
  factory Warehouse({
    required String warehouseId,
    required String warehouseName,
  }) = _Warehouse;

  factory Warehouse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseFromJson(json);
}
