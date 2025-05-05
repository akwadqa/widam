import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/addresses/domain/address/area.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  factory City(
      {required String cityId,
      required String cityName,
      required List<Area>? areas}) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
