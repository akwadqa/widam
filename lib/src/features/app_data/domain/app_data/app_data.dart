import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:widam/src/features/app_data/domain/delivery_date/delivery_date.dart';

import '../../../addresses/domain/address/address.dart';
import '../../../addresses/domain/geofence.dart';
import '../../../time_slots/domain/geofence_details/time_slot.dart';
part 'app_data.freezed.dart';
part 'app_data.g.dart';

@freezed
class AppData with _$AppData {
  factory AppData({
    required Geofence geofence,
    required TimeSlot timeSlot,
    required String homeLayout,
    required String featuredLayout,
    required DeliveryDate deliveryDate,
    required Address? address,
    required int mandatoryToUpdate,
    required String androidApiVersion,
    required String iosApiVersion,
    required String appUpdateMessage,
    required String? corporateVideo,
    required int? showVideoOncePerSession,
    required dynamic walletBalance,
  }) = _AppData;

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);
}
