import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinates.freezed.dart';
part 'coordinates.g.dart';

@freezed
class Coordinates with _$Coordinates {
  factory Coordinates({
    required String latitude,
    required String longitude,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}
