import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_controller.dart';
import 'package:widam/src/utils/utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // ✅ NEW package import

class BarcodeWidget extends ConsumerWidget {
  BarcodeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const BarcodeScannerScreen(),
          ),
        );

        if (result != null && result is String && result.isNotEmpty) {
          debugPrint('[SCAN RESULT] $result');
          ref.read(barcodeControllerProvider.notifier).set(result);

          pushItemGroupScreen(
            context: context,
            itemGroupId: Strings.allItemGroup,
          );
        }
      },
      icon: Assets.icons.barcodeIcon.image(),
    );
  }
}


class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanBoxSize = size.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            scanWindowUpdateThreshold: 20,
            controller: MobileScannerController(),
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;
              if (code != null && code.isNotEmpty) {
                debugPrint('[SCAN RESULT] $code')
;                Navigator.pop(context, code);
              }
            },
          ),

          // Transparent scan area with border
          Center(
            child: Container(
              width: scanBoxSize,
              height: scanBoxSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // Dimmed overlay around the scan area
          IgnorePointer(
            child: CustomPaint(
              size: size,
              painter: _ScannerOverlayPainter(scanSize: scanBoxSize),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double scanSize;

  _ScannerOverlayPainter({required this.scanSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.6);
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: scanSize, height: scanSize);
    final outer = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final hole = Path()..addRRect(RRect.fromRectXY(rect, 8, 8));
    final overlay = Path.combine(PathOperation.difference, outer, hole);
    canvas.drawPath(overlay, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
