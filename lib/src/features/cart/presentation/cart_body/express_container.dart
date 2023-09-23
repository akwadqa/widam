import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../theme/app_colors.dart';
import '../../../items/presentation/item_card/express_widget.dart';

class ExpressContainer extends StatelessWidget {
  const ExpressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.orange.shade50,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      child: Row(children: [
        Row(
          children: [
            Text(
              S.of(context).expressItemsDescription,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5.0),
            const ExpressWidget()
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(AppColors.carminePink),
              textStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500))),
          child: Text(S.of(context).switchLabel),
        )
      ]),
    );
  }
}
