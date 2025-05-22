import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/generated/l10n.dart';
import 'package:widam/src/features/auth/application/user_data_provider.dart';
import 'package:widam/src/features/notifications/presentation/marketing_notifications_controller.dart';

@RoutePage()
class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).notificationsSettings),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return Column(children: [
            const _Switch(),
            if (ref.watch(userDataProvider) != null) ...[
              const Divider(),
              SwitchListTile.adaptive(
                  value: true,
                  onChanged: null,
                  title: Text(S.of(context).ordersUpdates)),
            ],
          ]);
        },
      ),
    );
  }
}

class _Switch extends ConsumerWidget {
  const _Switch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMarketingSubscribed =
        ref.watch(marketingNotificationsControllerProvider);
    return SwitchListTile.adaptive(
        title: Text(S.of(context).activateMarketingNotifications),
        value: isMarketingSubscribed,
        onChanged: ref
            .read(marketingNotificationsControllerProvider.notifier)
            .onSwitchChanged);
  }
}
