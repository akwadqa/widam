import 'dart:convert';

import 'package:widam/src/features/addresses/domain/address/address.dart';

import 'subscription_item.dart';
import '../presentation/subscription_screen/subscription_body/set_your_schedule/frequency_selector_form_field.dart';

class Subscription {
  final String title;
  final String startDate;
  final String endDate;
  final Frequency interval;
  final int intervalCount;
  final String? timeSlotId;
  final String? addressId;
  final List<SubscriptionItem> items;
  final Address? address;

  Subscription({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.interval,
    required this.intervalCount,
    required this.timeSlotId,
    required this.addressId,
    required this.items,
    this.address,
  });

  Subscription copyWith({
    String? title,
    String? startDate,
    String? endDate,
    Frequency? interval,
    int? intervalCount,
    String? timeSlotId,
    String? addressId,
    List<SubscriptionItem>? items,
    Address? address,
  }) {
    return Subscription(
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      interval: interval ?? this.interval,
      intervalCount: intervalCount ?? this.intervalCount,
      timeSlotId: timeSlotId ?? this.timeSlotId,
      addressId: addressId ?? this.addressId,
      items: items ?? this.items,
      address: address ?? this.address,
    );
  }

  Subscription.fromJson(Map<String, dynamic> json)
      : title = json['subscription_title'],
        startDate = json['subscription_start_date'],
        endDate = json['subscription_end_date'],
        interval = Frequency.values.firstWhere(
            (element) => element.name == json['interval'],
            orElse: () => Frequency.Daily),
        intervalCount = json['interval_count'],
        timeSlotId = json['time_slot_id'],
        addressId = json['address_id'],
        address =
            json['address'] != null ? Address.fromJson(json['address']) : null,
        items = (json['subscription_items'] as List)
            .map((e) => SubscriptionItem.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'subscription_title': title,
      'subscription_start_date': startDate,
      'subscription_end_date': endDate,
      'interval': interval.name,
      'interval_count': intervalCount,
      'time_slot': timeSlotId,
      'address_id': addressId,
      'subscription_items': jsonEncode(items.map((e) => e.toJson()).toList()),
    };
  }
}
