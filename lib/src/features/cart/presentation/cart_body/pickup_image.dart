import 'package:flutter/cupertino.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../../common_widgets/app_cached_network_image.dart';
import '../../../../constants/keys.dart';
import '../../../../constants/services_urls.dart';

class PickupMapImage extends StatelessWidget {
  const PickupMapImage(
      {super.key, required this.latitude, required this.longitude});

  final String latitude;
  final String longitude;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final availableMaps = await MapLauncher.installedMaps;
        await availableMaps.first.showMarker(
          coords: Coords(double.parse(latitude), double.parse(longitude)),
          title: '',
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: AppCachedNetworkImage(
              imageUrl:
                  '${ServicesUrls.googleMapsBaseUrl}/staticmap?size=${100}x${50}&visible=$latitude,$longitude&zoom=${15}&key=${Keys.googleAPIKey}&language=${Directionality.of(context) == TextDirection.ltr ? 'en' : 'ar'}')),
    );
  }
}
