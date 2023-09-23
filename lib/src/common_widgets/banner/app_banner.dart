import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../theme/app_colors.dart';

class AppBanner extends StatefulWidget {
  const AppBanner(
      {Key? key,
      required this.message,
      this.leadingIcon,
      this.trailing,
      this.stackTrace})
      : super(key: key);

  final String message;
  final StackTrace? stackTrace;
  final Widget? leadingIcon;
  final Widget? trailing;

  @override
  State<AppBanner> createState() => _AppBannerState();
}

class _AppBannerState extends State<AppBanner> {
  @override
  void initState() {
    debugPrint(widget.message);
    if (widget.stackTrace != null) debugPrint(widget.stackTrace.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = widget.message.contains('subtype')
        ? S.of(context).freiendlyErrorMessage
        : widget.message;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: const BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: ListTile(
              leading: widget.leadingIcon ?? Assets.icons.errorIcon.svg(),
              title: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              trailing: widget.trailing,
            )),
      ],
    );
  }
}
