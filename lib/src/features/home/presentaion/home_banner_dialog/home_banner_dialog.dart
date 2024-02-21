import 'package:flutter/material.dart' hide Banner;
import 'package:widam/src/common_widgets/app_cached_network_image.dart';
import 'package:widam/src/utils/utils.dart';

import '../../../layouts/domain/banner/banner.dart';

class HomeBannerDialog extends StatelessWidget {
  const HomeBannerDialog({super.key, required this.banner});

  final Banner banner;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Stack(
          fit: StackFit.expand,
          children: [
            InkWell(
              onTap: () => navigateToItemDetails(
                  context: context,
                  itemId: banner.bannerLink!,
                  mubadaraId: banner.mubadaraId,
                  isMubadara: 1),
              child: AppCachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl: banner.bannerImage,
              ),
            ),
            const Align(
                alignment: AlignmentDirectional.topEnd, child: CloseButton())
          ],
        ),
      ),
    );
  }
}
