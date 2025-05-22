import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:widam/src/features/notifications/application/notifications_service.dart';
import 'package:widam/src/routing/app_router_provider.dart';
import '../../../../routing/app_router.gr.dart';
import 'app_bottom_navigation_bar.dart';

@RoutePage()
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    Future(() {
      ref
          .read(notificationsServiceProvider)
          .setupInteractedMessage(ref.read(appRouterProvider));
      StatusBarControl.setStyle(StatusBarStyle.LIGHT_CONTENT);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeScreen(),
        const ItemGroupsScreen(),
        const DealsScreen(),
        const CartScreen(),
        const ProfileScreen()
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return AppBottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (int index) async {
            await StatusBarControl.setStyle(index == 0
                ? StatusBarStyle.LIGHT_CONTENT
                : StatusBarStyle.DARK_CONTENT);
            tabsRouter.setActiveIndex(index);
          },
        );
      },
    );
  }
}
