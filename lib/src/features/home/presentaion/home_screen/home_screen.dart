import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    if (widget.bannerBlock != null) {
      final bannerBlock = widget.bannerBlock!.data.first;
      Future.delayed(const Duration(seconds: 4), () {
        showDialog(
            context: context,
            builder: (context) => HomeBannerDialog(banner: bannerBlock));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ProviderScope(overrides: [
        itemDetailsSheetControllerProvider
            .overrideWith(() => ItemDetailsSheetController())
      ], child: const HomeBody()),
    );
  }
}
