import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/routing/app_router.gr.dart';

import '../generated/l10n.dart';
import 'localization/current_language.dart';
import 'routing/app_router_provider.dart';
import 'theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final currentLanguage = ref.watch(currentLanguageProvider);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      onGenerateTitle: (context) => S.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(deepLinkBuilder: (deepLink) {
        //TODO: Implement path
        if (deepLink.path.startsWith('/details')) {
          // continute with the platfrom link
          return DeepLink(
              [const MainScreen(), ItemDetailsScreen(itemId: 'WI-00706')]);
        } else {
          return DeepLink.defaultPath;
          // or DeepLink.path('/')
          // or DeepLink([HomeRoute()])
        }
      }),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: ref.watch(themeDataProvider),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(currentLanguage),
    );
  }
}
