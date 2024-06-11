import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../data/udhiya_coupons_repository.dart';

@RoutePage()
class UdhiyaCouponDetailsScreen extends StatelessWidget {
  const UdhiyaCouponDetailsScreen({super.key, required this.couponId});

  final String couponId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).couponDetails),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final couponDetailsAsync =
                ref.watch(udhiyaCouponDetailsProvider(couponId));
            return couponDetailsAsync.when(
              data: (coupon) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        '${S.of(context).couponNo} ${coupon.couponId}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).scanCodeMsg,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      AppCachedNetworkImage(imageUrl: coupon.qrCode),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            S.of(context).pickupDetails,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: AppColors.brightGray,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _InfoRow(
                              label: S.of(context).pickupLocation,
                              value: coupon.pickupDetails.pickupPoint,
                            ),
                            const SizedBox(height: 10),
                            _InfoRow(
                              label: S.of(context).pickupDate,
                              value: coupon.pickupDetails.pickupDate.date,
                            ),
                            const SizedBox(height: 10),
                            _InfoRow(
                              label: S.of(context).pickupTime,
                              value: coupon
                                  .pickupDetails.pickupTimeSlot.timeFormatted,
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () => _launchMap(
                                      coupon.pickupDetails.coordinates.latitude,
                                      coupon
                                          .pickupDetails.coordinates.longitude,
                                      coupon.pickupDetails.pickupPoint),
                                  child: Text(S.of(context).goToLocation)),
                            ),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.black),
                            const SizedBox(height: 10),
                            Text(S.of(context).couponItems,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 16)),
                            const SizedBox(height: 20),
                            ...coupon.couponItems!.map((item) => Row(
                                  children: [
                                    Text(item.itemName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                    const Spacer(),
                                    Text(item.qty.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                )),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              error: (error, st) =>
                  AppBanner(message: error.toString(), stackTrace: st),
              loading: () => const FadeCircleLoadingIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchMap(
      String latitude, String longitude, String title) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(double.parse(latitude), double.parse(longitude)),
      title: title,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}
