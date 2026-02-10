import 'package:flutter/material.dart';
import 'media_ad_dialog.dart';

Future<void> showMediaAdDialog(
  BuildContext context, {
  required String mediaUrl,
  VoidCallback? onTap,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => MediaAdDialog(
      mediaUrl: mediaUrl,
      onTap: onTap,
    ),
  );
}
