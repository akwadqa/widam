import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../routing/app_router.gr.dart';
import 'app_bottom_navigation_bar.dart';

@RoutePage()
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const [
        HomeScreen(),
        ItemGroupsScreen(),
        DealsScreen(),
        CartScreen(),
        ProfileScreen()
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return AppBottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (int index) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness:
                  index == 0 ? Brightness.dark : Brightness.light,
              statusBarIconBrightness:
                  index == 0 ? Brightness.light : Brightness.dark,
            ));
            tabsRouter.setActiveIndex(index);
          },
        );
      },
    );
  }
}
