import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/items/presentation/item_details/item_details_body/item_details_body.dart';

import 'item_details_controller.dart';

@RoutePage()
class ItemDetailsScreen extends ConsumerStatefulWidget {
  const ItemDetailsScreen({Key? key, required this.itemId, this.mubadaraId, this.attributionToken})
      : super(key: key);
  final String itemId;
  final String? mubadaraId;
  final String? attributionToken;

  @override
  ConsumerState<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends ConsumerState<ItemDetailsScreen> {
  @override
  void initState() {
    Future(() {
      ref
          .read(itemDetailsControllerProvider.notifier)
          .getItemDetails(itemId: widget.itemId, mubadaraId: widget.mubadaraId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: ItemDetailsBody(attributionToken: widget.attributionToken),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
