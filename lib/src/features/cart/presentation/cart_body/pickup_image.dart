import 'package:flutter/cupertino.dart';

import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../constants/keys.dart';
import '../../../../constants/services_urls.dart';

class PickupImage extends StatelessWidget {
  const PickupImage(
      {super.key, required this.latitude, required this.longitude});

  final String latitude;
  final String longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: AppCachedNetworkImage(
            imageUrl:
                '${ServicesUrls.googleMapsBaseUrl}/staticmap?size=${100}x${50}&visible=$latitude,$longitude&zoom=${15}&key=${Keys.googleAPIKey}&language=${Directionality.of(context) == TextDirection.ltr ? 'en' : 'ar'}'));
  }
}
