import 'package:freezed_annotation/freezed_annotation.dart';

part 'expiring_points.freezed.dart';
part 'expiring_points.g.dart';

@freezed
class ExpiringPoints with _$ExpiringPoints {
  factory ExpiringPoints({
    required double expiringPointsTotal,
    required String window,
  }) = _ExpiringPoints;

  factory ExpiringPoints.fromJson(Map<String, dynamic> json) =>
      _$ExpiringPointsFromJson(json);
}
