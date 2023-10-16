import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_controller.dart';
import 'package:widam/src/utils/utils.dart';

class BarcodeWidget extends ConsumerWidget {
  const BarcodeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        FlutterBarcodeScanner.scanBarcode(
                '#0050B3', S.of(context).cancel, false, ScanMode.BARCODE)
            .then((barcodeScanRes) {
          if (barcodeScanRes != '-1') {
            ref.read(barcodeControllerProvider.notifier).set(barcodeScanRes);
            pushItemGroupScreen(
                context: context, itemGroupId: Strings.allItemGroup);
          }
        });
      },
      icon: Assets.icons.barcodeIcon.image(),
    );
  }
}
