import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/zone.dart';

part 'area.freezed.dart';
part 'area.g.dart';

@freezed
class Area with _$Area {
  factory Area({
    required String areaId,
    required String areaName,
    required List<Zone>? zones,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}
