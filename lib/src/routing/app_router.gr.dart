// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i32;
import 'package:flutter/material.dart' as _i33;
import 'package:widam/src/features/account/presentation/edit_profile_screen/edit_profile_screen.dart'
    as _i10;
import 'package:widam/src/features/account/presentation/register_screen/register_screen.dart'
    as _i23;
import 'package:widam/src/features/addresses/domain/address/address.dart'
    as _i34;
import 'package:widam/src/features/addresses/presentation/addresses/add_edit_address_screen/add_edit_address_screen.dart'
    as _i3;
import 'package:widam/src/features/addresses/presentation/addresses/addresses_screen/addresses_screen.dart'
    as _i4;
import 'package:widam/src/features/app_data/presentation/app_initial_screen/app_initial_screen.dart'
    as _i5;
import 'package:widam/src/features/auth/presentation/login_screen/login_screen.dart'
    as _i15;
import 'package:widam/src/features/cart/presentation/cart_screen/cart_screen.dart'
    as _i6;
import 'package:widam/src/features/checkout/domain/order/order.dart' as _i38;
import 'package:widam/src/features/checkout/presentation/checkout_screen/checkout_screen.dart'
    as _i7;
import 'package:widam/src/features/checkout/presentation/ordered_successfully_screen/ordered_successfully_screen.dart'
    as _i19;
import 'package:widam/src/features/checkout/presentation/payment_web_view/payment_web_view.dart'
    as _i20;
import 'package:widam/src/features/complaints/presentation/add_complaint_screen/add_complaint_screen.dart'
    as _i2;
import 'package:widam/src/features/complaints/presentation/complaints_screen/complaints_screen.dart'
    as _i8;
import 'package:widam/src/features/deals/presentation/deals_screen/deals_screen.dart'
    as _i9;
import 'package:widam/src/features/home/presentaion/home_screen/home_screen.dart'
    as _i11;
import 'package:widam/src/features/item_groups/presentation/item_group_screen/item_group_screen.dart'
    as _i13;
import 'package:widam/src/features/item_groups/presentation/item_groups_screen/item_groups_screen.dart'
    as _i14;
import 'package:widam/src/features/items/presentation/item_details/item_details_screen.dart'
    as _i12;
import 'package:widam/src/features/items/presentation/mubadara_items_screen/mubadara_items_screen.dart'
    as _i17;
import 'package:widam/src/features/layouts/domain/banner/banner.dart' as _i37;
import 'package:widam/src/features/layouts/domain/block.dart' as _i36;
import 'package:widam/src/features/loyalty_points/presentation/points_history_screen/points_history_screen.dart'
    as _i21;
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/widam_loyalty_program_screen.dart'
    as _i30;
import 'package:widam/src/features/main/presentation/main_screen/main_screen.dart'
    as _i16;
import 'package:widam/src/features/notifications/presentation/notifications_settings_screen/notifications_settings_screen.dart'
    as _i18;
import 'package:widam/src/features/profile/domain/user_details/user_details.dart'
    as _i35;
import 'package:widam/src/features/profile/presentation/profile_screen/profile_screen.dart'
    as _i22;
import 'package:widam/src/features/profile/presentation/terms_conditions_and_privacy_policy_screen.dart'
    as _i27;
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart'
    as _i39;
import 'package:widam/src/features/sales_orders/presentaion/sales_order_details_screen/sales_order_details_screen.dart'
    as _i24;
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/sales_orders_screen.dart'
    as _i25;
import 'package:widam/src/features/sales_orders/presentaion/track_map_screen/track_map_screen.dart'
    as _i28;
import 'package:widam/src/features/subscriptions/presentation/active_subscriptions_screen/active_subscriptions_screen.dart'
    as _i1;
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_screen.dart'
    as _i26;
import 'package:widam/src/features/wallet/presentation/transaction_history_screen/transaction_history_screen.dart'
    as _i29;
import 'package:widam/src/features/wallet/presentation/widam_wallet_screen/widam_wallet_screen.dart'
    as _i31;

abstract class $AppRouter extends _i32.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i32.PageFactory> pagesMap = {
    ActiveSubscriptionsScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ActiveSubscriptionsScreen(),
      );
    },
    AddComplaintScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddComplaintScreen(),
      );
    },
    AddEditAddressScreen.name: (routeData) {
      final args = routeData.argsAs<AddEditAddressScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AddEditAddressScreen(
          key: args.key,
          address: args.address,
          latitude: args.latitude,
          longitude: args.longitude,
          geofenceId: args.geofenceId,
        ),
      );
    },
    AddressesScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AddressesScreen(),
      );
    },
    AppInitialScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.AppInitialScreen(),
      );
    },
    CartScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CartScreen(),
      );
    },
    CheckoutScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CheckoutScreen(),
      );
    },
    ComplaintsScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ComplaintsScreen(),
      );
    },
    DealsScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.DealsScreen(),
      );
    },
    EditProfileScreen.name: (routeData) {
      final args = routeData.argsAs<EditProfileScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.EditProfileScreen(
          key: args.key,
          userDetails: args.userDetails,
        ),
      );
    },
    HomeScreen.name: (routeData) {
      final args = routeData.argsAs<HomeScreenArgs>(
          orElse: () => const HomeScreenArgs());
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.HomeScreen(
          key: args.key,
          bannerBlock: args.bannerBlock,
        ),
      );
    },
    ItemDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<ItemDetailsScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ItemDetailsScreen(
          key: args.key,
          itemId: args.itemId,
          mubadaraId: args.mubadaraId,
          attributionToken: args.attributionToken,
        ),
      );
    },
    ItemGroupScreen.name: (routeData) {
      final args = routeData.argsAs<ItemGroupScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ItemGroupScreen(
          key: args.key,
          autoFocus: args.autoFocus,
          itemGroupId: args.itemGroupId,
        ),
      );
    },
    ItemGroupsScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ItemGroupsScreen(),
      );
    },
    LoginScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.LoginScreen(),
      );
    },
    MainScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MainScreen(),
      );
    },
    MubadaraItemsScreen.name: (routeData) {
      final args = routeData.argsAs<MubadaraItemsScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.MubadaraItemsScreen(
          key: args.key,
          mubadaraId: args.mubadaraId,
        ),
      );
    },
    NotificationsSettingsScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.NotificationsSettingsScreen(),
      );
    },
    OrderedSuccessfullyScreen.name: (routeData) {
      final args = routeData.argsAs<OrderedSuccessfullyScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.OrderedSuccessfullyScreen(
          key: args.key,
          order: args.order,
          pun: args.pun,
        ),
      );
    },
    PaymentWebView.name: (routeData) {
      final args = routeData.argsAs<PaymentWebViewArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.PaymentWebView(
          key: args.key,
          redirectUrl: args.redirectUrl,
        ),
      );
    },
    PointsHistoryScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.PointsHistoryScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.ProfileScreen(),
      );
    },
    RegisterScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.RegisterScreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
      );
    },
    SalesOrderDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<SalesOrderDetailsScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.SalesOrderDetailsScreen(
          key: args.key,
          salesOrder: args.salesOrder,
          statuses: args.statuses,
        ),
      );
    },
    SalesOrdersScreen.name: (routeData) {
      final args = routeData.argsAs<SalesOrdersScreenArgs>(
          orElse: () => const SalesOrdersScreenArgs());
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.SalesOrdersScreen(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
      );
    },
    SubscriptionScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.SubscriptionScreen(),
      );
    },
    TermsConditionsAndPrivacyPolicyScreen.name: (routeData) {
      final args = routeData.argsAs<TermsConditionsAndPrivacyPolicyScreenArgs>(
          orElse: () => const TermsConditionsAndPrivacyPolicyScreenArgs());
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.TermsConditionsAndPrivacyPolicyScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    TrackMapScreen.name: (routeData) {
      final args = routeData.argsAs<TrackMapScreenArgs>();
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.TrackMapScreen(
          key: args.key,
          salesOrder: args.salesOrder,
        ),
      );
    },
    TransactionHistoryScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.TransactionHistoryScreen(),
      );
    },
    WidamLoyaltyProgramScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.WidamLoyaltyProgramScreen(),
      );
    },
    WidamWalletScreen.name: (routeData) {
      return _i32.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.WidamWalletScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ActiveSubscriptionsScreen]
class ActiveSubscriptionsScreen extends _i32.PageRouteInfo<void> {
  const ActiveSubscriptionsScreen({List<_i32.PageRouteInfo>? children})
      : super(
          ActiveSubscriptionsScreen.name,
          initialChildren: children,
        );

  static const String name = 'ActiveSubscriptionsScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddComplaintScreen]
class AddComplaintScreen extends _i32.PageRouteInfo<void> {
  const AddComplaintScreen({List<_i32.PageRouteInfo>? children})
      : super(
          AddComplaintScreen.name,
          initialChildren: children,
        );

  static const String name = 'AddComplaintScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddEditAddressScreen]
class AddEditAddressScreen
    extends _i32.PageRouteInfo<AddEditAddressScreenArgs> {
  AddEditAddressScreen({
    _i33.Key? key,
    _i34.Address? address,
    required String latitude,
    required String longitude,
    required String geofenceId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          AddEditAddressScreen.name,
          args: AddEditAddressScreenArgs(
            key: key,
            address: address,
            latitude: latitude,
            longitude: longitude,
            geofenceId: geofenceId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEditAddressScreen';

  static const _i32.PageInfo<AddEditAddressScreenArgs> page =
      _i32.PageInfo<AddEditAddressScreenArgs>(name);
}

class AddEditAddressScreenArgs {
  const AddEditAddressScreenArgs({
    this.key,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.geofenceId,
  });

  final _i33.Key? key;

  final _i34.Address? address;

  final String latitude;

  final String longitude;

  final String geofenceId;

  @override
  String toString() {
    return 'AddEditAddressScreenArgs{key: $key, address: $address, latitude: $latitude, longitude: $longitude, geofenceId: $geofenceId}';
  }
}

/// generated route for
/// [_i4.AddressesScreen]
class AddressesScreen extends _i32.PageRouteInfo<void> {
  const AddressesScreen({List<_i32.PageRouteInfo>? children})
      : super(
          AddressesScreen.name,
          initialChildren: children,
        );

  static const String name = 'AddressesScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i5.AppInitialScreen]
class AppInitialScreen extends _i32.PageRouteInfo<void> {
  const AppInitialScreen({List<_i32.PageRouteInfo>? children})
      : super(
          AppInitialScreen.name,
          initialChildren: children,
        );

  static const String name = 'AppInitialScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CartScreen]
class CartScreen extends _i32.PageRouteInfo<void> {
  const CartScreen({List<_i32.PageRouteInfo>? children})
      : super(
          CartScreen.name,
          initialChildren: children,
        );

  static const String name = 'CartScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i7.CheckoutScreen]
class CheckoutScreen extends _i32.PageRouteInfo<void> {
  const CheckoutScreen({List<_i32.PageRouteInfo>? children})
      : super(
          CheckoutScreen.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ComplaintsScreen]
class ComplaintsScreen extends _i32.PageRouteInfo<void> {
  const ComplaintsScreen({List<_i32.PageRouteInfo>? children})
      : super(
          ComplaintsScreen.name,
          initialChildren: children,
        );

  static const String name = 'ComplaintsScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i9.DealsScreen]
class DealsScreen extends _i32.PageRouteInfo<void> {
  const DealsScreen({List<_i32.PageRouteInfo>? children})
      : super(
          DealsScreen.name,
          initialChildren: children,
        );

  static const String name = 'DealsScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i10.EditProfileScreen]
class EditProfileScreen extends _i32.PageRouteInfo<EditProfileScreenArgs> {
  EditProfileScreen({
    _i33.Key? key,
    required _i35.UserDetails userDetails,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          EditProfileScreen.name,
          args: EditProfileScreenArgs(
            key: key,
            userDetails: userDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileScreen';

  static const _i32.PageInfo<EditProfileScreenArgs> page =
      _i32.PageInfo<EditProfileScreenArgs>(name);
}

class EditProfileScreenArgs {
  const EditProfileScreenArgs({
    this.key,
    required this.userDetails,
  });

  final _i33.Key? key;

  final _i35.UserDetails userDetails;

  @override
  String toString() {
    return 'EditProfileScreenArgs{key: $key, userDetails: $userDetails}';
  }
}

/// generated route for
/// [_i11.HomeScreen]
class HomeScreen extends _i32.PageRouteInfo<HomeScreenArgs> {
  HomeScreen({
    _i33.Key? key,
    _i36.Block<List<_i37.Banner>>? bannerBlock,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          HomeScreen.name,
          args: HomeScreenArgs(
            key: key,
            bannerBlock: bannerBlock,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeScreen';

  static const _i32.PageInfo<HomeScreenArgs> page =
      _i32.PageInfo<HomeScreenArgs>(name);
}

class HomeScreenArgs {
  const HomeScreenArgs({
    this.key,
    this.bannerBlock,
  });

  final _i33.Key? key;

  final _i36.Block<List<_i37.Banner>>? bannerBlock;

  @override
  String toString() {
    return 'HomeScreenArgs{key: $key, bannerBlock: $bannerBlock}';
  }
}

/// generated route for
/// [_i12.ItemDetailsScreen]
class ItemDetailsScreen extends _i32.PageRouteInfo<ItemDetailsScreenArgs> {
  ItemDetailsScreen({
    _i33.Key? key,
    required String itemId,
    String? mubadaraId,
    String? attributionToken,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          ItemDetailsScreen.name,
          args: ItemDetailsScreenArgs(
            key: key,
            itemId: itemId,
            mubadaraId: mubadaraId,
            attributionToken: attributionToken,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemDetailsScreen';

  static const _i32.PageInfo<ItemDetailsScreenArgs> page =
      _i32.PageInfo<ItemDetailsScreenArgs>(name);
}

class ItemDetailsScreenArgs {
  const ItemDetailsScreenArgs({
    this.key,
    required this.itemId,
    this.mubadaraId,
    this.attributionToken,
  });

  final _i33.Key? key;

  final String itemId;

  final String? mubadaraId;

  final String? attributionToken;

  @override
  String toString() {
    return 'ItemDetailsScreenArgs{key: $key, itemId: $itemId, mubadaraId: $mubadaraId, attributionToken: $attributionToken}';
  }
}

/// generated route for
/// [_i13.ItemGroupScreen]
class ItemGroupScreen extends _i32.PageRouteInfo<ItemGroupScreenArgs> {
  ItemGroupScreen({
    _i33.Key? key,
    bool autoFocus = false,
    required String itemGroupId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          ItemGroupScreen.name,
          args: ItemGroupScreenArgs(
            key: key,
            autoFocus: autoFocus,
            itemGroupId: itemGroupId,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemGroupScreen';

  static const _i32.PageInfo<ItemGroupScreenArgs> page =
      _i32.PageInfo<ItemGroupScreenArgs>(name);
}

class ItemGroupScreenArgs {
  const ItemGroupScreenArgs({
    this.key,
    this.autoFocus = false,
    required this.itemGroupId,
  });

  final _i33.Key? key;

  final bool autoFocus;

  final String itemGroupId;

  @override
  String toString() {
    return 'ItemGroupScreenArgs{key: $key, autoFocus: $autoFocus, itemGroupId: $itemGroupId}';
  }
}

/// generated route for
/// [_i14.ItemGroupsScreen]
class ItemGroupsScreen extends _i32.PageRouteInfo<void> {
  const ItemGroupsScreen({List<_i32.PageRouteInfo>? children})
      : super(
          ItemGroupsScreen.name,
          initialChildren: children,
        );

  static const String name = 'ItemGroupsScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i15.LoginScreen]
class LoginScreen extends _i32.PageRouteInfo<void> {
  const LoginScreen({List<_i32.PageRouteInfo>? children})
      : super(
          LoginScreen.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i16.MainScreen]
class MainScreen extends _i32.PageRouteInfo<void> {
  const MainScreen({List<_i32.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          initialChildren: children,
        );

  static const String name = 'MainScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i17.MubadaraItemsScreen]
class MubadaraItemsScreen extends _i32.PageRouteInfo<MubadaraItemsScreenArgs> {
  MubadaraItemsScreen({
    _i33.Key? key,
    required String mubadaraId,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          MubadaraItemsScreen.name,
          args: MubadaraItemsScreenArgs(
            key: key,
            mubadaraId: mubadaraId,
          ),
          initialChildren: children,
        );

  static const String name = 'MubadaraItemsScreen';

  static const _i32.PageInfo<MubadaraItemsScreenArgs> page =
      _i32.PageInfo<MubadaraItemsScreenArgs>(name);
}

class MubadaraItemsScreenArgs {
  const MubadaraItemsScreenArgs({
    this.key,
    required this.mubadaraId,
  });

  final _i33.Key? key;

  final String mubadaraId;

  @override
  String toString() {
    return 'MubadaraItemsScreenArgs{key: $key, mubadaraId: $mubadaraId}';
  }
}

/// generated route for
/// [_i18.NotificationsSettingsScreen]
class NotificationsSettingsScreen extends _i32.PageRouteInfo<void> {
  const NotificationsSettingsScreen({List<_i32.PageRouteInfo>? children})
      : super(
          NotificationsSettingsScreen.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsSettingsScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i19.OrderedSuccessfullyScreen]
class OrderedSuccessfullyScreen
    extends _i32.PageRouteInfo<OrderedSuccessfullyScreenArgs> {
  OrderedSuccessfullyScreen({
    _i33.Key? key,
    required _i38.Order order,
    String? pun,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          OrderedSuccessfullyScreen.name,
          args: OrderedSuccessfullyScreenArgs(
            key: key,
            order: order,
            pun: pun,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderedSuccessfullyScreen';

  static const _i32.PageInfo<OrderedSuccessfullyScreenArgs> page =
      _i32.PageInfo<OrderedSuccessfullyScreenArgs>(name);
}

class OrderedSuccessfullyScreenArgs {
  const OrderedSuccessfullyScreenArgs({
    this.key,
    required this.order,
    this.pun,
  });

  final _i33.Key? key;

  final _i38.Order order;

  final String? pun;

  @override
  String toString() {
    return 'OrderedSuccessfullyScreenArgs{key: $key, order: $order, pun: $pun}';
  }
}

/// generated route for
/// [_i20.PaymentWebView]
class PaymentWebView extends _i32.PageRouteInfo<PaymentWebViewArgs> {
  PaymentWebView({
    _i33.Key? key,
    required String redirectUrl,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          PaymentWebView.name,
          args: PaymentWebViewArgs(
            key: key,
            redirectUrl: redirectUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentWebView';

  static const _i32.PageInfo<PaymentWebViewArgs> page =
      _i32.PageInfo<PaymentWebViewArgs>(name);
}

class PaymentWebViewArgs {
  const PaymentWebViewArgs({
    this.key,
    required this.redirectUrl,
  });

  final _i33.Key? key;

  final String redirectUrl;

  @override
  String toString() {
    return 'PaymentWebViewArgs{key: $key, redirectUrl: $redirectUrl}';
  }
}

/// generated route for
/// [_i21.PointsHistoryScreen]
class PointsHistoryScreen extends _i32.PageRouteInfo<void> {
  const PointsHistoryScreen({List<_i32.PageRouteInfo>? children})
      : super(
          PointsHistoryScreen.name,
          initialChildren: children,
        );

  static const String name = 'PointsHistoryScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i22.ProfileScreen]
class ProfileScreen extends _i32.PageRouteInfo<void> {
  const ProfileScreen({List<_i32.PageRouteInfo>? children})
      : super(
          ProfileScreen.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i23.RegisterScreen]
class RegisterScreen extends _i32.PageRouteInfo<RegisterScreenArgs> {
  RegisterScreen({
    _i33.Key? key,
    required String mobileNumber,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          RegisterScreen.name,
          args: RegisterScreenArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterScreen';

  static const _i32.PageInfo<RegisterScreenArgs> page =
      _i32.PageInfo<RegisterScreenArgs>(name);
}

class RegisterScreenArgs {
  const RegisterScreenArgs({
    this.key,
    required this.mobileNumber,
  });

  final _i33.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'RegisterScreenArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [_i24.SalesOrderDetailsScreen]
class SalesOrderDetailsScreen
    extends _i32.PageRouteInfo<SalesOrderDetailsScreenArgs> {
  SalesOrderDetailsScreen({
    _i33.Key? key,
    required _i39.SalesOrder salesOrder,
    required List<String> statuses,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SalesOrderDetailsScreen.name,
          args: SalesOrderDetailsScreenArgs(
            key: key,
            salesOrder: salesOrder,
            statuses: statuses,
          ),
          initialChildren: children,
        );

  static const String name = 'SalesOrderDetailsScreen';

  static const _i32.PageInfo<SalesOrderDetailsScreenArgs> page =
      _i32.PageInfo<SalesOrderDetailsScreenArgs>(name);
}

class SalesOrderDetailsScreenArgs {
  const SalesOrderDetailsScreenArgs({
    this.key,
    required this.salesOrder,
    required this.statuses,
  });

  final _i33.Key? key;

  final _i39.SalesOrder salesOrder;

  final List<String> statuses;

  @override
  String toString() {
    return 'SalesOrderDetailsScreenArgs{key: $key, salesOrder: $salesOrder, statuses: $statuses}';
  }
}

/// generated route for
/// [_i25.SalesOrdersScreen]
class SalesOrdersScreen extends _i32.PageRouteInfo<SalesOrdersScreenArgs> {
  SalesOrdersScreen({
    _i33.Key? key,
    int initialIndex = 0,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SalesOrdersScreen.name,
          args: SalesOrdersScreenArgs(
            key: key,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'SalesOrdersScreen';

  static const _i32.PageInfo<SalesOrdersScreenArgs> page =
      _i32.PageInfo<SalesOrdersScreenArgs>(name);
}

class SalesOrdersScreenArgs {
  const SalesOrdersScreenArgs({
    this.key,
    this.initialIndex = 0,
  });

  final _i33.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'SalesOrdersScreenArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i26.SubscriptionScreen]
class SubscriptionScreen extends _i32.PageRouteInfo<void> {
  const SubscriptionScreen({List<_i32.PageRouteInfo>? children})
      : super(
          SubscriptionScreen.name,
          initialChildren: children,
        );

  static const String name = 'SubscriptionScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i27.TermsConditionsAndPrivacyPolicyScreen]
class TermsConditionsAndPrivacyPolicyScreen
    extends _i32.PageRouteInfo<TermsConditionsAndPrivacyPolicyScreenArgs> {
  TermsConditionsAndPrivacyPolicyScreen({
    _i33.Key? key,
    String? title,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          TermsConditionsAndPrivacyPolicyScreen.name,
          args: TermsConditionsAndPrivacyPolicyScreenArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'TermsConditionsAndPrivacyPolicyScreen';

  static const _i32.PageInfo<TermsConditionsAndPrivacyPolicyScreenArgs> page =
      _i32.PageInfo<TermsConditionsAndPrivacyPolicyScreenArgs>(name);
}

class TermsConditionsAndPrivacyPolicyScreenArgs {
  const TermsConditionsAndPrivacyPolicyScreenArgs({
    this.key,
    this.title,
  });

  final _i33.Key? key;

  final String? title;

  @override
  String toString() {
    return 'TermsConditionsAndPrivacyPolicyScreenArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i28.TrackMapScreen]
class TrackMapScreen extends _i32.PageRouteInfo<TrackMapScreenArgs> {
  TrackMapScreen({
    _i33.Key? key,
    required _i39.SalesOrder salesOrder,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          TrackMapScreen.name,
          args: TrackMapScreenArgs(
            key: key,
            salesOrder: salesOrder,
          ),
          initialChildren: children,
        );

  static const String name = 'TrackMapScreen';

  static const _i32.PageInfo<TrackMapScreenArgs> page =
      _i32.PageInfo<TrackMapScreenArgs>(name);
}

class TrackMapScreenArgs {
  const TrackMapScreenArgs({
    this.key,
    required this.salesOrder,
  });

  final _i33.Key? key;

  final _i39.SalesOrder salesOrder;

  @override
  String toString() {
    return 'TrackMapScreenArgs{key: $key, salesOrder: $salesOrder}';
  }
}

/// generated route for
/// [_i29.TransactionHistoryScreen]
class TransactionHistoryScreen extends _i32.PageRouteInfo<void> {
  const TransactionHistoryScreen({List<_i32.PageRouteInfo>? children})
      : super(
          TransactionHistoryScreen.name,
          initialChildren: children,
        );

  static const String name = 'TransactionHistoryScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i30.WidamLoyaltyProgramScreen]
class WidamLoyaltyProgramScreen extends _i32.PageRouteInfo<void> {
  const WidamLoyaltyProgramScreen({List<_i32.PageRouteInfo>? children})
      : super(
          WidamLoyaltyProgramScreen.name,
          initialChildren: children,
        );

  static const String name = 'WidamLoyaltyProgramScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}

/// generated route for
/// [_i31.WidamWalletScreen]
class WidamWalletScreen extends _i32.PageRouteInfo<void> {
  const WidamWalletScreen({List<_i32.PageRouteInfo>? children})
      : super(
          WidamWalletScreen.name,
          initialChildren: children,
        );

  static const String name = 'WidamWalletScreen';

  static const _i32.PageInfo<void> page = _i32.PageInfo<void>(name);
}
