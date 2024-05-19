import 'package:freezed_annotation/freezed_annotation.dart';

import 'point.dart';

part 'pickup_points_details.freezed.dart';
part 'pickup_points_details.g.dart';

@freezed
class PickupPointsDetails with _$PickupPointsDetails {
  factory PickupPointsDetails({
    required String label,
    required List<Point> points,
  }) = _PickupPointsDetails;

  factory PickupPointsDetails.fromJson(Map<String, dynamic> json) =>
      _$PickupPointsDetailsFromJson(json);
}
