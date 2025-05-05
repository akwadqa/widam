import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'slotter_fees_controller.g.dart';

@riverpod
class SlotterFeesController extends _$SlotterFeesController {
  @override
  bool build() => false;

  void setIsCheckedSoltterFees(bool value) {
    state = value;
  }
}
