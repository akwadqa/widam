import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/common_widgets/media_ad/show_media_ad_dialog.dart';
import 'package:widam/src/common_widgets/video_ads_dialog_widget.dart';
import 'package:widam/src/constants/services_urls.dart';
import 'package:widam/src/features/app_data/application/app_data_controller.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:widam/src/features/home/presentaion/home_banner_dialog/home_banner_dialog.dart';
import 'package:widam/src/features/layouts/domain/block.dart';
import 'package:widam/src/features/main/presentation/item_details_sheet_controller.dart';

import '../../../layouts/domain/banner/banner.dart';
import '../home_app_bar/home_app_bar.dart';
import '../home_body/home_body.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.bannerBlock});

  final Block<List<Banner>>? bannerBlock;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndShowVideoAd();
  }

  Future<void> _checkAndShowVideoAd() async {
    final prefs = ref.read(userDataProvider.notifier);
    final appUtility = ref.read(appDataControllerProvider).value;
    final hasSeenAd = prefs.hasSeenAd();
    final adVaialable=appUtility?.corporateVideo!=null||appUtility?.showVideoOncePerSession!=null;
    final showAd =adVaialable && ((!hasSeenAd && appUtility?.showVideoOncePerSession == 1) ||
        appUtility?.showVideoOncePerSession == 0);
// if(appUtility?.corporateVideo!=null||appUtility?.showVideoOncePerSession!=null){
    if (showAd) {
      // Show video ad once
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(Duration(seconds: 4));
        await showMediaAdDialog(
          context,
          mediaUrl: ServicesUrls.domain + (appUtility?.corporateVideo??""),
        );


        // Mark as seen
        await prefs.markAdAsSeen();

        // After video, optionally show banner
        if (widget.bannerBlock != null) {
          final bannerBlock = widget.bannerBlock!.data.first;
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              showDialog(
                context: context,
                builder: (context) => HomeBannerDialog(banner: bannerBlock),
              );
            }
          });
        }
      });
     }else {
      // Already seen ad, just show banner if available
      if (widget.bannerBlock != null) {
        final bannerBlock = widget.bannerBlock!.data.first;
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            showDialog(
              context: context,
              builder: (context) => HomeBannerDialog(banner: bannerBlock),
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ProviderScope(overrides: [
        // ignore: scoped_providers_should_specify_dependencies
        itemDetailsSheetControllerProvider
            .overrideWith(() => ItemDetailsSheetController())
      ], child: const HomeBody()),
    );
  }
}
