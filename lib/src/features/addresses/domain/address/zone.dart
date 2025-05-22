import 'package:freezed_annotation/freezed_annotation.dart';

part 'zone.freezed.dart';
part 'zone.g.dart';

@freezed
class Zone with _$Zone {
  factory Zone({
    required String zoneId,
    required String zoneNumber,
  }) = _Zone;

  factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
}
