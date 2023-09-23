import 'package:freezed_annotation/freezed_annotation.dart';
import '../block_data.dart';

part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
class Banner with _$Banner implements BlockData {
  const factory Banner({
    required String bannerType,
    required String bannerLink,
    required String bannerImage,
  }) = _Banner;

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
}
