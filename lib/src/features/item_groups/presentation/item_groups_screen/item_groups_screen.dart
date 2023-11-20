import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/main/presentation/item_details_sheet_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';

import '../../../../common_widgets/address_and_delivery_widget.dart';
import '../item_groups_body/item_groups_body.dart';

@RoutePage()
class ItemGroupsScreen extends ConsumerWidget {
  const ItemGroupsScreen({super.key});

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
            ], child: const ItemGroupsBody()),
          )
        ],
      ),
    );
  }
}
