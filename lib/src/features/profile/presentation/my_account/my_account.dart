import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/loyalty_program_list_tile.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../profile_title_container.dart';
import '../../../../routing/app_router.gr.dart';

import '../../../auth/application/user_data_provider.dart';

class MyAccount extends ConsumerWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = ref.watch(userDataProvider);
    if (userToken == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        ProfileTitleContainer(title: S.of(context).myAccount),
        const MyAccountListTiles(),
      ],
    );
  }
}

class MyAccountListTiles extends ConsumerWidget {
  const MyAccountListTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 8),
        ListTile(
          leading: Assets.icons.addressesIcon.svg(),
          title: Text(S.of(context).myAddressees),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => context.pushRoute(const AddressesScreen()),
        ),
        const Divider(),
        ListTile(
          leading: Assets.icons.walletIcon.svg(),
          title: Text(S.of(context).widamWallet),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => context.pushRoute(const WidamWalletScreen()),
        ),
        const Divider(),
        const LoyaltyProgramListTile(),
        const Divider(),
        ListTile(
            leading: Assets.icons.profileIcon.svg(width: 18, height: 18),
            title: Text(S.of(context).signOut),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => ref.read(userDataProvider.notifier).removeUserData()),
        const SizedBox(height: 8),
      ],
    );
  }
}
