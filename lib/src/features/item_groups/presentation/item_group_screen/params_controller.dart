import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'params_controller.g.dart';

@riverpod
class ParamsController extends _$ParamsController {
  @override
  String? build() {
    return null;
  }

  void set(String? parameters) {
    state = parameters;
  }
}