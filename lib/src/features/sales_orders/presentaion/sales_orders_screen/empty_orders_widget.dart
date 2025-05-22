import 'package:flutter/widgets.dart';
import 'package:widam/gen/assets.gen.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/common_widgets/titled_image.dart';

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TitledImage(
            title: S.of(context).itIsEmptyHere,
            icon: Assets.icons.emptyFileIcon.svg()));
  }
}
