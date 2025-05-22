import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import '../generated/l10n.dart';
import 'routing/app_router_provider.dart';
import 'theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key, required this.analytics});
  final FirebaseAnalytics analytics;
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
      routerConfig: appRouter.config(
        deepLinkBuilder: (deepLink) => DeepLink.defaultPath,
        navigatorObservers: () =>
            [FirebaseAnalyticsObserver(analytics: analytics)],
      ),
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
