import 'package:freezed_annotation/freezed_annotation.dart';

part 'mubadara_details.freezed.dart';
part 'mubadara_details.g.dart';

@freezed
class MubadaraDetails with _$MubadaraDetails {
  const factory MubadaraDetails({
    required String mubadaraId,
    required String mubadaraName,
    required double qtyPerQid,
    required double qtyPerUser,
    required int minAge,
    required String qidFieldLabel,
    required String qidFieldPlaceholder,
    required String qidCopyLabel,
    required String qidCopyPlaceholder,
    required String buttonLabel,
  }) = _MubadaraDetails;

  factory MubadaraDetails.fromJson(Map<String, dynamic> json) =>
      _$MubadaraDetailsFromJson(json);
}
