import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qid_number_controller.g.dart';

@riverpod
class QidNumberController extends _$QidNumberController {
  @override
  String build() {
    return '';
  }

  void setQidNumber(String value) => state = value;
}