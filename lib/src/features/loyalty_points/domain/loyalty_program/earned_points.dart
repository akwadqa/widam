import 'package:freezed_annotation/freezed_annotation.dart';

part 'earned_points.freezed.dart';
part 'earned_points.g.dart';

@freezed
class EarnedPoints with _$EarnedPoints {
  factory EarnedPoints(
      {required double pointsBalance,
      required double totalEarned,
      required double totalRedeemed,
      required double totalValue,
      required double value}) = _EarnedPoints;

  factory EarnedPoints.fromJson(Map<String, dynamic> json) =>
      _$EarnedPointsFromJson(json);
}
