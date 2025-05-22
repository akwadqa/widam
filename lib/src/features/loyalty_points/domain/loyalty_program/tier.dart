import 'package:freezed_annotation/freezed_annotation.dart';

part 'tier.freezed.dart';
part 'tier.g.dart';

@freezed
class Tier with _$Tier {
  factory Tier({
    required String tierName,
    required String tierColor,
    required double minimumTotalToQualify,
    required double collectionFactor,
  }) = _Tier;

  factory Tier.fromJson(Map<String, dynamic> json) => _$TierFromJson(json);
}
