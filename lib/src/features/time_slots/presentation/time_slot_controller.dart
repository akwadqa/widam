import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app_data/application/app_data_controller.dart';
import '../../app_data/domain/app_data/app_data.dart';

part 'time_slot_controller.g.dart';

@riverpod
class TimeSlotController extends _$TimeSlotController {
  @override
  ({String formattedDate, String formattedTime}) build() {
    AppData? appData = ref.watch(appDataControllerProvider).asData?.value;
    return (
      formattedDate: appData?.deliveryDate.dateFormatted ?? '',
      formattedTime: appData?.timeSlot.timeFormatted ?? ''
    );
  }
}
