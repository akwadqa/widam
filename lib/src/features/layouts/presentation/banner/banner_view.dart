import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import '../../../../utils/magnetic_scroll_physics.dart';
import '../../../../utils/utils.dart';

import '../../../../common_widgets/app_cached_network_image.dart';
import '../../domain/banner/banner.dart';
import 'carousel_dots_indicator.dart';

class BannerView extends ConsumerWidget {
  const BannerView({super.key, required this.banners});
  final List<Banner> banners;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (banners.length == 1) {
      return _BannerImage(
          banner: banners.first,
          onTap: () => _onBannerTap(context, banners.first, ref));
    }
    return _BannerCarousel(
        banners: banners,
        onTap: (index) => _onBannerTap(context, banners[index], ref));
  }

  void _onBannerTap(BuildContext context, Banner banner, WidgetRef ref) {
    if (banner.bannerType == 'Banner') {
      return;
    }
    if (banner.bannerType == 'Website Item') {
      navigateToItemDetails(
          context: context,
          ref: ref,
          mubadaraId: banner.mubadaraId,
          isMubadara: banner.mubadaraId != null ? 1 : 0,
          itemId: banner.bannerLink!,
          itemType: 'V');
    } else if (banner.bannerType == 'Mubadara') {
      context.pushRoute(MubadaraItemsScreen(mubadaraId: banner.bannerLink!));
    } else {
      pushItemGroupScreen(context: context, itemGroupId: banner.bannerLink!);
    }
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({required this.banner, required this.onTap});
  final Banner banner;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
                image: CachedNetworkImageProvider(banner.bannerImage),
                fit: BoxFit.fitWidth)),
      ),
    );
  }
}

class _BannerCarousel extends ConsumerWidget {
  const _BannerCarousel({required this.banners, required this.onTap});
  final List<Banner> banners;
  final Function(int index) onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(
            onTap: () => onTap(itemIndex),
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              clipBehavior: Clip.antiAlias,
              child: AppCachedNetworkImage(
                imageUrl: banners[itemIndex].bannerImage,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          options: CarouselOptions(
              height: 160,
              autoPlay: true,
              scrollPhysics: const MagneticScrollPhysics(itemSize: 160),
              viewportFraction: 0.9,
              onPageChanged: (index, reason) =>
                  ref.read(carouselPageIndexProvider.notifier).state = index),
        ),
        Positioned(
            right: 0,
            left: 0,
            bottom: 8,
            child: CarouselDotsIndicator(dotsCount: banners.length))
      ],
    );
  }
}
