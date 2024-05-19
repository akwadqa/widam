import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_pickup_point_controller.g.dart';

@riverpod
class SelectedPickupPointController extends _$SelectedPickupPointController {
  @override
  String? build() => null;

  void setPickupPoint(String value) {
    state = value;
  }
}
