import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/tags/presentation/item_tag_label_list.dart';
import '../../../../../utils/magnetic_scroll_physics.dart';
import '../../../domain/item_details/item_details.dart';

import '../../../../../common_widgets/app_cached_network_image.dart';
import '../../../../../common_widgets/app_close_button.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../layouts/presentation/banner/carousel_dots_indicator.dart';
import '../../item_card/express_widget.dart';
import '../../../../tags/presentation/item_tags_list/item_tags_list.dart';

class ItemDetailsHeader extends ConsumerWidget {
  const ItemDetailsHeader({super.key, required this.itemDetails});
  final ItemDetails itemDetails;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [
      SizedBox(
        height: 350,
        width: double.infinity,
        child: itemDetails.additionalImages.length > 1
            ? CarouselSlider.builder(
                itemCount: itemDetails.additionalImages.length,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    _bannerImage(itemDetails.additionalImages[itemIndex].image),
                options: CarouselOptions(
                    viewportFraction: 1,
                    scrollPhysics: const MagneticScrollPhysics(itemSize: 350),
                    onPageChanged: (index, reason) => ref
                        .read(carouselPageIndexProvider.notifier)
                        .state = index),
              )
            : itemDetails.additionalImages.isEmpty
                ? const SizedBox.shrink()
                : _bannerImage(itemDetails.additionalImages.first.image),
      ),
      if (itemDetails.additionalImages.length > 1)
        PositionedDirectional(
            bottom: 5,
            start: 0,
            end: 0,
            child: CarouselDotsIndicator(
                dotsCount: itemDetails.additionalImages.length)),
      const PositionedDirectional(
        start: 10,
        top: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCloseButton(
                width: 40,
                height: 40,
                icon: Padding(
                    padding: EdgeInsetsDirectional.only(start: 4),
                    child: Icon(Icons.arrow_back_ios,
                        color: AppColors.vividCerulean))),
          ],
        ),
      ),
      if (itemDetails.tags
          .where((element) => element.productLabel == 1)
          .isNotEmpty)
        PositionedDirectional(
            start: 10,
            top: 80,
            child: SizedBox(
                width: 100, child: ItemTagLabelList(tags: itemDetails.tags))),
      if (itemDetails.tags
          .where((element) => element.productLabel == 0)
          .isNotEmpty)
        PositionedDirectional(
          bottom: 10,
          start: 10,
          child: SizedBox(
              width: 40, child: ItemTagsList(tags: itemDetails.tags, size: 40)),
        ),
      if (itemDetails.isExpressItem == 1)
        const PositionedDirectional(
          end: 10,
          bottom: 10,
          child: ExpressWidget(isBig: true),
        )
    ]);
  }

  Widget _bannerImage(String url) =>
      AppCachedNetworkImage(imageUrl: url, fit: BoxFit.fitHeight);
}
