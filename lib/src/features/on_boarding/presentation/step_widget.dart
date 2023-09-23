import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/theme/app_colors.dart';

import '../../../theme/app_theme.dart';

class StepWidget extends StatelessWidget {
  const StepWidget(
      {super.key,
      this.title,
      required this.body,
      this.nextStep,
      required this.close,
      this.arrowAlignment = AlignmentDirectional.topEnd});
  final String? title;
  final String body;
  final VoidCallback? nextStep;
  final VoidCallback close;
  final AlignmentDirectional arrowAlignment;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (arrowAlignment.toString().contains('top'))
            Align(
                alignment: arrowAlignment,
                child: const Icon(
                  Icons.arrow_drop_up,
                  color: Colors.white,
                  size: 40,
                )),
          Material(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (title != null) ...[
                  Row(
                    children: [
                      Assets.icons.exclamationMark.svg(),
                      const SizedBox(width: 5),
                      Text(title!,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Text(body,
                    style:
                        const TextStyle(color: AppColors.gray, fontSize: 16)),
                Consumer(
                  builder: (context, ref, child) {
                    final fontFamily = ref.watch(fontFamilyProvider);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (nextStep != null)
                          TextButton(
                              onPressed: nextStep,
                              style: _textButtonStyle(fontFamily),
                              child: Text(S.of(context).next)),
                        TextButton(
                          onPressed: close,
                          style: _textButtonStyle(fontFamily),
                          child: Text(nextStep != null
                              ? S.of(context).skip
                              : S.of(context).close),
                        ),
                      ],
                    );
                  },
                )
              ]),
            ),
          ),
          if (arrowAlignment.toString().contains('bottom'))
            Align(
                alignment: arrowAlignment,
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 40,
                ))
        ],
      ),
    );
  }

  ButtonStyle _textButtonStyle(String fontFamily) {
    return TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: TextStyle(
            fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 16));
  }
}
