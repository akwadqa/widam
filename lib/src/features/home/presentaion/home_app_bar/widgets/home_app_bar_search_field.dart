import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../constants/strings.dart';
import '../../../../../theme/app_text_styles.dart';
import '../../../../../utils/utils.dart';
import '../../utils/home_decorations.dart';
import 'home_app_bar_tile.dart';

/// Read-only search box: tapping it opens the products screen with the
/// search field focused.
class HomeAppBarSearchField extends StatelessWidget {
  const HomeAppBarSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final hint = S.of(context).searchForAnyProduct;
    return HomeAppBarTile(
      semanticLabel: hint,
      onTap: () => pushItemGroupScreen(
        context: context,
        autoFocus: true,
        itemGroupId: Strings.allItemGroup,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 20,
              color: HomeDecorations.mutedText,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hint,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular14
                    .copyWith(color: HomeDecorations.mutedText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
