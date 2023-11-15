import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/layouts/presentation/blocks_list.dart';
import 'package:widam/src/global_providers/global_providers.dart';

import '../../../../common_widgets/address_and_delivery_widget.dart';
import '../../../../utils/utils.dart';
import '../../../layouts/data/layouts_repository.dart';
import '../../../main/presentation/item_details_sheet_controller.dart';

@RoutePage()
class DealsScreen extends ConsumerWidget {
  const DealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPadding = ref.watch(topPaddingProvider(context));
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: topPadding),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: AddressAndDeliveryWidget(),
        ),
        Expanded(
          child: ProviderScope(overrides: [
            itemDetailsSheetControllerProvider
                .overrideWith(() => ItemDetailsSheetController())
          ], child: const _Body()),
        ),
      ],
    ));
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenItemDetailsSheet(ref, context);
    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          ref.invalidate(layoutProvider(LayoutType.featured)),
      child: const CustomScrollView(slivers: [
        BlocksList(layoutType: LayoutType.featured),
      ]),
    );
  }
}
