import 'package:freezed_annotation/freezed_annotation.dart';
import '../matched_substring/matched_substring.dart';

part 'structured_formatting.freezed.dart';
part 'structured_formatting.g.dart';

@freezed
class StructuredFormatting with _$StructuredFormatting {
  const factory StructuredFormatting({
    required String mainText,
    required List<MatchedSubstring> mainTextMatchedSubstrings,
    String? secondaryText,
  }) = _StructuredFormatting;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);
}
