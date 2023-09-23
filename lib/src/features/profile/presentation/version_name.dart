import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../../main.dart';

class VersionName extends ConsumerWidget {
  const VersionName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    return Text('${S.of(context).version} ${packageInfo.version}');
  }
}
