import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/address_and_delivery_widget.dart';
import 'package:widam/src/common_widgets/banner/app_banner.dart';
import 'package:widam/src/common_widgets/fade_circle_loading_indicator.dart';
import 'package:widam/src/features/addresses/presentation/addresses/adaptive_back_button.dart';
import 'package:widam/src/features/items/data/mubadara_items_repository.dart';
import 'package:widam/src/features/items/presentation/items_grid.dart';
import 'package:widam/src/global_providers/global_providers.dart';

@RoutePage()
class MubadaraItemsScreen extends ConsumerStatefulWidget {
  const MubadaraItemsScreen({super.key, required this.mubadaraId});
  final String mubadaraId;
  @override
  ConsumerState<MubadaraItemsScreen> createState() =>
      _MubadaraItemsScreenState();
}

class _MubadaraItemsScreenState extends ConsumerState<MubadaraItemsScreen> {
  @override
  void initState() {
    StatusBarControl.setStyle(StatusBarStyle.DARK_CONTENT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mubadaraItemsAsync =
        ref.watch(mubadaraItemsProvider(widget.mubadaraId));
    final topPadding =
        ref.watch(topPaddingProvider(MediaQuery.paddingOf(context).top));
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: topPadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: AddressAndDeliveryWidget(),
          ),
          const Align(
              alignment: AlignmentDirectional.centerStart,
              child: AdaptiveBackButton(width: 40.0, height: 40.0)),
          Expanded(
            child: mubadaraItemsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                        child: Text(
                            S.of(context).noProductsMatchingYourSelection));
                  }
                  return ItemsGrid(items: items);
                },
                error: (error, stackTrace) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: AppBanner(
                          message: error.toString(), stackTrace: stackTrace),
                    ),
                loading: () => const FadeCircleLoadingIndicator()),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    StatusBarControl.setStyle(StatusBarStyle.LIGHT_CONTENT);
    super.dispose();
  }
}
