import 'package:freezed_annotation/freezed_annotation.dart';

part 'nationality.freezed.dart';
part 'nationality.g.dart';

@freezed
class Nationality with _$Nationality {
  factory Nationality({
    required String countryId,
    required String countryName,
  }) = _Nationality;

  factory Nationality.fromJson(Map<String, dynamic> json) =>
      _$NationalityFromJson(json);
}
