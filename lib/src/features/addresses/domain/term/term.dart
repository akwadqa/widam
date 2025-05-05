import 'package:freezed_annotation/freezed_annotation.dart';

part 'term.freezed.dart';
part 'term.g.dart';

@freezed
class Term with _$Term {
  const factory Term({
    required int offset,
    required String value,
  }) = _Term;

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}
