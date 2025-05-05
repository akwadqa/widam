import 'package:freezed_annotation/freezed_annotation.dart';

part 'additional_image.freezed.dart';
part 'additional_image.g.dart';

@freezed
class AdditionalImage with _$AdditionalImage {
  const factory AdditionalImage({
    required String image,
    String? description,
    String? url,
  }) = _AdditionalImage;

  factory AdditionalImage.fromJson(Map<String, dynamic> json) =>
      _$AdditionalImageFromJson(json);
}
