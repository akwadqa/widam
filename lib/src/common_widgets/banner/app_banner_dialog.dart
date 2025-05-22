import 'package:flutter/material.dart';

import 'app_banner.dart';

void showAppBannerDialog(BuildContext context, String message,
        [StackTrace? stackTrace]) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.topCenter,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            content: Material(
                child: AppBanner(message: message, stackTrace: stackTrace))));
