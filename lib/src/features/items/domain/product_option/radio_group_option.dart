import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_group_option.freezed.dart';
part 'radio_group_option.g.dart';

@freezed
class RadioGroupOption with _$RadioGroupOption {
  factory RadioGroupOption({
    required int id,
    required String value,
  }) = _RadioGroupOption;

  factory RadioGroupOption.fromJson(Map<String, dynamic> json) =>
      _$RadioGroupOptionFromJson(json);
}
