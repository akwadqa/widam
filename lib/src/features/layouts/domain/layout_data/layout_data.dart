import 'package:freezed_annotation/freezed_annotation.dart';
import '../block_data.dart';

part 'layout_data.freezed.dart';
part 'layout_data.g.dart';

@freezed
class LayoutData with _$LayoutData implements BlockData {
  const factory LayoutData({
    required String layoutId,
    required String layoutTitle,
  }) = _LayoutData;

  factory LayoutData.fromJson(Map<String, dynamic> json) =>
      _$LayoutDataFromJson(json);
}
