import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: AppInitialScreen.page, initial: true, path: '/'),
    AutoRoute(page: MainScreen.page, children: [
      AutoRoute(page: HomeScreen.page),
      AutoRoute(page: ItemGroupsScreen.page),
      AutoRoute(page: DealsScreen.page),
      AutoRoute(page: CartScreen.page),
      AutoRoute(page: ProfileScreen.page),
    ]),
    AutoRoute(page: LoginScreen.page),
    AutoRoute(page: RegisterScreen.page),
    AutoRoute(page: SubscriptionScreen.page),
    AutoRoute(page: ItemDetailsScreen.page),
    AutoRoute(page: EditProfileScreen.page),
    AutoRoute(page: AddressesScreen.page),
    AutoRoute(page: AddEditAddressScreen.page),
    AutoRoute(page: CheckoutScreen.page),
    AutoRoute(page: PaymentWebView.page),
    AutoRoute(page: OrderedSuccessfullyScreen.page),
    AutoRoute(page: SalesOrdersScreen.page),
    AutoRoute(page: NotificationsSettingsScreen.page),
    AutoRoute(page: ActiveSubscriptionsScreen.page),
    AutoRoute(page: TermsConditionsAndPrivacyPolicyScreen.page),
    AutoRoute(page: ItemGroupScreen.page),
    AutoRoute(page: WidamWalletScreen.page),
    AutoRoute(page: TransactionHistoryScreen.page),
    AutoRoute(page: TrackMapScreen.page),
    AutoRoute(page: WidamLoyaltyProgramScreen.page),
    AutoRoute(page: PointsHistoryScreen.page),
    AutoRoute(page: SalesOrderDetailsScreen.page),
    AutoRoute(page: ComplaintsScreen.page),
    AutoRoute(page: AddComplaintScreen.page),
    AutoRoute(page: MubadaraItemsScreen.page)
  ];
}
