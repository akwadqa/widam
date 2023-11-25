import 'package:freezed_annotation/freezed_annotation.dart';

part 'complaint.freezed.dart';
part 'complaint.g.dart';

@freezed
class Complaint with _$Complaint {
  factory Complaint({
    required String issueId,
    required String raisedBy,
    required String customer,
    required String issueType,
    required String subject,
    required String description,
    required String priority,
    required String? resolutionDetails,
  }) = _Complaint;

  factory Complaint.fromJson(Map<String, dynamic> json) =>
      _$ComplaintFromJson(json);
}
