import 'package:freezed_annotation/freezed_annotation.dart';

import 'tier.dart';
import 'earned_points.dart';
import 'expiring_points.dart';

part 'loyalty_program.freezed.dart';
part 'loyalty_program.g.dart';

@freezed
class LoyaltyProgram with _$LoyaltyProgram {
  factory LoyaltyProgram({
    required String loyaltyProgramName,
    required double conversionFactor,
    required Tier activeTier,
    required EarnedPoints earnedPoints,
    required ExpiringPoints expiringPoints,
    required Tier? nextTier,
  }) = _LoyaltyProgram;

  factory LoyaltyProgram.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyProgramFromJson(json);
}
