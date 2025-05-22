import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widam/src/constants/services_urls.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:widam/src/routing/app_router.gr.dart';
import '../../data/profile_repository.dart';

import '../../../../../generated/l10n.dart';

class ReachOutUs extends ConsumerWidget {
  const ReachOutUs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 8),
        const _ContactListTile(),
        const Divider(),
        ListTile(
          title: Text(S.of(context).onlineChat),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => launchUrl(Uri.parse(ServicesUrls.liveChat)),
        ),
        if (ref.watch(userDataProvider) != null) ...[
          const Divider(),
          ListTile(
            title: Text(S.of(context).complaints),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.pushRoute(const ComplaintsScreen()),
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ContactListTile extends ConsumerWidget {
  const _ContactListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactNumber =
        ref.watch(companyProfileProvider).asData?.value.contactNumber;
    return ListTile(
      title: Text(S.of(context).contactUs),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (contactNumber != null) {
          final Uri telLaunchUri = Uri(
            scheme: 'tel',
            path: contactNumber,
          );
          launchUrl(telLaunchUri);
        }
      },
    );
  }
}
