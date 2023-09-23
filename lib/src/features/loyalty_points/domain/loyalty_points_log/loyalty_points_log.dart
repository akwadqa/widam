import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_points_log.freezed.dart';
part 'loyalty_points_log.g.dart';

@freezed
class LoyaltyPointsLog with _$LoyaltyPointsLog {
  factory LoyaltyPointsLog({
    required String invoiceType,
    required String invoice,
    required String? redeemAgainst,
    required double loyaltyPoints,
    required double purchaseAmount,
    required String expiryDate,
    required String postingDate,
  }) = _LoyaltyPointsLog;

  factory LoyaltyPointsLog.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyPointsLogFromJson(json);
}
