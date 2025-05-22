import 'package:freezed_annotation/freezed_annotation.dart';
import '../matched_substring/matched_substring.dart';
import '../structured_formatting/structured_formatting.dart';
import '../term/term.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@freezed
class Place with _$Place {
  const factory Place({
    required String description,
    required List<MatchedSubstring> matchedSubstrings,
    required String placeId,
    required String reference,
    required StructuredFormatting structuredFormatting,
    required List<Term> terms,
    required List<String> types,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}
