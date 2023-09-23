import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coordinates_controller.g.dart';

@riverpod
class CoordinatesController extends _$CoordinatesController {
  @override
  ({String lat, String long})? build() => null;

  void setCoordinates(({String lat, String long}) coordinates) {
    state = coordinates;
  }
}
