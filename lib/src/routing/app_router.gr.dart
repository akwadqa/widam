// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;
import 'package:widam/src/features/account/presentation/edit_profile_screen/edit_profile_screen.dart'
    as _i8;
import 'package:widam/src/features/account/presentation/register_screen/register_screen.dart'
    as _i20;
import 'package:widam/src/features/addresses/domain/address/address.dart'
    as _i31;
import 'package:widam/src/features/addresses/presentation/addresses/add_edit_address_screen/add_edit_address_screen.dart'
    as _i2;
import 'package:widam/src/features/addresses/presentation/addresses/addresses_screen/addresses_screen.dart'
    as _i3;
import 'package:widam/src/features/app_data/presentation/app_initial_screen/app_initial_screen.dart'
    as _i4;
import 'package:widam/src/features/auth/presentation/login_screen/login_screen.dart'
    as _i13;
import 'package:widam/src/features/cart/presentation/cart_screen/cart_screen.dart'
    as _i5;
import 'package:widam/src/features/checkout/domain/order/order.dart' as _i33;
import 'package:widam/src/features/checkout/presentation/checkout_screen/checkout_screen.dart'
    as _i6;
import 'package:widam/src/features/checkout/presentation/ordered_successfully_screen/ordered_successfully_screen.dart'
    as _i16;
import 'package:widam/src/features/checkout/presentation/payment_web_view/payment_web_view.dart'
    as _i17;
import 'package:widam/src/features/deals/presentation/deals_screen/deals_screen.dart'
    as _i7;
import 'package:widam/src/features/home/presentaion/home_screen/home_screen.dart'
    as _i9;
import 'package:widam/src/features/item_groups/presentation/item_group_screen/item_group_screen.dart'
    as _i11;
import 'package:widam/src/features/item_groups/presentation/item_groups_screen/item_groups_screen.dart'
    as _i12;
import 'package:widam/src/features/items/presentation/item_details/item_details_screen.dart'
    as _i10;
import 'package:widam/src/features/loyalty_points/presentation/points_history_screen/points_history_screen.dart'
    as _i18;
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/widam_loyalty_program_screen.dart'
    as _i27;
import 'package:widam/src/features/main/presentation/main_screen/main_screen.dart'
    as _i14;
import 'package:widam/src/features/notifications/presentation/notifications_settings_screen/notifications_settings_screen.dart'
    as _i15;
import 'package:widam/src/features/profile/domain/user_details/user_details.dart'
    as _i32;
import 'package:widam/src/features/profile/presentation/profile_screen/profile_screen.dart'
    as _i19;
import 'package:widam/src/features/profile/presentation/terms_conditions_and_privacy_policy_screen.dart'
    as _i24;
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart'
    as _i34;
import 'package:widam/src/features/sales_orders/presentaion/sales_order_details_screen/sales_order_details_screen.dart'
    as _i21;
import 'package:widam/src/features/sales_orders/presentaion/sales_orders_screen/sales_orders_screen.dart'
    as _i22;
import 'package:widam/src/features/sales_orders/presentaion/track_map_screen/track_map_screen.dart'
    as _i25;
import 'package:widam/src/features/subscriptions/presentation/active_subscriptions_screen/active_subscriptions_screen.dart'
    as _i1;
import 'package:widam/src/features/subscriptions/presentation/subscription_screen/subscription_screen.dart'
    as _i23;
import 'package:widam/src/features/wallet/presentation/transaction_history_screen/transaction_history_screen.dart'
    as _i26;
import 'package:widam/src/features/wallet/presentation/widam_wallet_screen/widam_wallet_screen.dart'
    as _i28;

abstract class $AppRouter extends _i29.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    ActiveSubscriptionsScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ActiveSubscriptionsScreen(),
      );
    },
    AddEditAddressScreen.name: (routeData) {
      final args = routeData.argsAs<AddEditAddressScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddEditAddressScreen(
          key: args.key,
          address: args.address,
          latitude: args.latitude,
          longitude: args.longitude,
          geofenceId: args.geofenceId,
        ),
      );
    },
    AddressesScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddressesScreen(),
      );
    },
    AppInitialScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AppInitialScreen(),
      );
    },
    CartScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CartScreen(),
      );
    },
    CheckoutScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CheckoutScreen(),
      );
    },
    DealsScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.DealsScreen(),
      );
    },
    EditProfileScreen.name: (routeData) {
      final args = routeData.argsAs<EditProfileScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.EditProfileScreen(
          key: args.key,
          userDetails: args.userDetails,
        ),
      );
    },
    HomeScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeScreen(),
      );
    },
    ItemDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<ItemDetailsScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ItemDetailsScreen(
          key: args.key,
          itemId: args.itemId,
          mubadaraId: args.mubadaraId,
          attributionToken: args.attributionToken,
        ),
      );
    },
    ItemGroupScreen.name: (routeData) {
      final args = routeData.argsAs<ItemGroupScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ItemGroupScreen(
          key: args.key,
          autoFocus: args.autoFocus,
          itemGroupId: args.itemGroupId,
        ),
      );
    },
    ItemGroupsScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ItemGroupsScreen(),
      );
    },
    LoginScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.LoginScreen(),
      );
    },
    MainScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.MainScreen(),
      );
    },
    NotificationsSettingsScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.NotificationsSettingsScreen(),
      );
    },
    OrderedSuccessfullyScreen.name: (routeData) {
      final args = routeData.argsAs<OrderedSuccessfullyScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.OrderedSuccessfullyScreen(
          key: args.key,
          order: args.order,
          pun: args.pun,
        ),
      );
    },
    PaymentWebView.name: (routeData) {
      final args = routeData.argsAs<PaymentWebViewArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.PaymentWebView(
          key: args.key,
          redirectUrl: args.redirectUrl,
        ),
      );
    },
    PointsHistoryScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PointsHistoryScreen(),
      );
    },
    ProfileScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileScreen(),
      );
    },
    RegisterScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.RegisterScreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        ),
      );
    },
    SalesOrderDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<SalesOrderDetailsScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.SalesOrderDetailsScreen(
          key: args.key,
          salesOrder: args.salesOrder,
          statuses: args.statuses,
        ),
      );
    },
    SalesOrdersScreen.name: (routeData) {
      final args = routeData.argsAs<SalesOrdersScreenArgs>(
          orElse: () => const SalesOrdersScreenArgs());
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.SalesOrdersScreen(
          key: args.key,
          initialIndex: args.initialIndex,
        ),
      );
    },
    SubscriptionScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.SubscriptionScreen(),
      );
    },
    TermsConditionsAndPrivacyPolicyScreen.name: (routeData) {
      final args = routeData.argsAs<TermsConditionsAndPrivacyPolicyScreenArgs>(
          orElse: () => const TermsConditionsAndPrivacyPolicyScreenArgs());
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.TermsConditionsAndPrivacyPolicyScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    TrackMapScreen.name: (routeData) {
      final args = routeData.argsAs<TrackMapScreenArgs>();
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.TrackMapScreen(
          key: args.key,
          salesOrder: args.salesOrder,
        ),
      );
    },
    TransactionHistoryScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.TransactionHistoryScreen(),
      );
    },
    WidamLoyaltyProgramScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.WidamLoyaltyProgramScreen(),
      );
    },
    WidamWalletScreen.name: (routeData) {
      return _i29.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.WidamWalletScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ActiveSubscriptionsScreen]
class ActiveSubscriptionsScreen extends _i29.PageRouteInfo<void> {
  const ActiveSubscriptionsScreen({List<_i29.PageRouteInfo>? children})
      : super(
          ActiveSubscriptionsScreen.name,
          initialChildren: children,
        );

  static const String name = 'ActiveSubscriptionsScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddEditAddressScreen]
class AddEditAddressScreen
    extends _i29.PageRouteInfo<AddEditAddressScreenArgs> {
  AddEditAddressScreen({
    _i30.Key? key,
    _i31.Address? address,
    required String latitude,
    required String longitude,
    required String geofenceId,
    List<_i29.PageRouteInfo>? children,
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

  static const _i29.PageInfo<AddEditAddressScreenArgs> page =
      _i29.PageInfo<AddEditAddressScreenArgs>(name);
}

class AddEditAddressScreenArgs {
  const AddEditAddressScreenArgs({
    this.key,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.geofenceId,
  });

  final _i30.Key? key;

  final _i31.Address? address;

  final String latitude;

  final String longitude;

  final String geofenceId;

  @override
  String toString() {
    return 'AddEditAddressScreenArgs{key: $key, address: $address, latitude: $latitude, longitude: $longitude, geofenceId: $geofenceId}';
  }
}

/// generated route for
/// [_i3.AddressesScreen]
class AddressesScreen extends _i29.PageRouteInfo<void> {
  const AddressesScreen({List<_i29.PageRouteInfo>? children})
      : super(
          AddressesScreen.name,
          initialChildren: children,
        );

  static const String name = 'AddressesScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AppInitialScreen]
class AppInitialScreen extends _i29.PageRouteInfo<void> {
  const AppInitialScreen({List<_i29.PageRouteInfo>? children})
      : super(
          AppInitialScreen.name,
          initialChildren: children,
        );

  static const String name = 'AppInitialScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartScreen]
class CartScreen extends _i29.PageRouteInfo<void> {
  const CartScreen({List<_i29.PageRouteInfo>? children})
      : super(
          CartScreen.name,
          initialChildren: children,
        );

  static const String name = 'CartScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CheckoutScreen]
class CheckoutScreen extends _i29.PageRouteInfo<void> {
  const CheckoutScreen({List<_i29.PageRouteInfo>? children})
      : super(
          CheckoutScreen.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DealsScreen]
class DealsScreen extends _i29.PageRouteInfo<void> {
  const DealsScreen({List<_i29.PageRouteInfo>? children})
      : super(
          DealsScreen.name,
          initialChildren: children,
        );

  static const String name = 'DealsScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i8.EditProfileScreen]
class EditProfileScreen extends _i29.PageRouteInfo<EditProfileScreenArgs> {
  EditProfileScreen({
    _i30.Key? key,
    required _i32.UserDetails userDetails,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          EditProfileScreen.name,
          args: EditProfileScreenArgs(
            key: key,
            userDetails: userDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileScreen';

  static const _i29.PageInfo<EditProfileScreenArgs> page =
      _i29.PageInfo<EditProfileScreenArgs>(name);
}

class EditProfileScreenArgs {
  const EditProfileScreenArgs({
    this.key,
    required this.userDetails,
  });

  final _i30.Key? key;

  final _i32.UserDetails userDetails;

  @override
  String toString() {
    return 'EditProfileScreenArgs{key: $key, userDetails: $userDetails}';
  }
}

/// generated route for
/// [_i9.HomeScreen]
class HomeScreen extends _i29.PageRouteInfo<void> {
  const HomeScreen({List<_i29.PageRouteInfo>? children})
      : super(
          HomeScreen.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ItemDetailsScreen]
class ItemDetailsScreen extends _i29.PageRouteInfo<ItemDetailsScreenArgs> {
  ItemDetailsScreen({
    _i30.Key? key,
    required String itemId,
    String? mubadaraId,
    String? attributionToken,
    List<_i29.PageRouteInfo>? children,
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

  static const _i29.PageInfo<ItemDetailsScreenArgs> page =
      _i29.PageInfo<ItemDetailsScreenArgs>(name);
}

class ItemDetailsScreenArgs {
  const ItemDetailsScreenArgs({
    this.key,
    required this.itemId,
    this.mubadaraId,
    this.attributionToken,
  });

  final _i30.Key? key;

  final String itemId;

  final String? mubadaraId;

  final String? attributionToken;

  @override
  String toString() {
    return 'ItemDetailsScreenArgs{key: $key, itemId: $itemId, mubadaraId: $mubadaraId, attributionToken: $attributionToken}';
  }
}

/// generated route for
/// [_i11.ItemGroupScreen]
class ItemGroupScreen extends _i29.PageRouteInfo<ItemGroupScreenArgs> {
  ItemGroupScreen({
    _i30.Key? key,
    bool autoFocus = false,
    required String itemGroupId,
    List<_i29.PageRouteInfo>? children,
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

  static const _i29.PageInfo<ItemGroupScreenArgs> page =
      _i29.PageInfo<ItemGroupScreenArgs>(name);
}

class ItemGroupScreenArgs {
  const ItemGroupScreenArgs({
    this.key,
    this.autoFocus = false,
    required this.itemGroupId,
  });

  final _i30.Key? key;

  final bool autoFocus;

  final String itemGroupId;

  @override
  String toString() {
    return 'ItemGroupScreenArgs{key: $key, autoFocus: $autoFocus, itemGroupId: $itemGroupId}';
  }
}

/// generated route for
/// [_i12.ItemGroupsScreen]
class ItemGroupsScreen extends _i29.PageRouteInfo<void> {
  const ItemGroupsScreen({List<_i29.PageRouteInfo>? children})
      : super(
          ItemGroupsScreen.name,
          initialChildren: children,
        );

  static const String name = 'ItemGroupsScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i13.LoginScreen]
class LoginScreen extends _i29.PageRouteInfo<void> {
  const LoginScreen({List<_i29.PageRouteInfo>? children})
      : super(
          LoginScreen.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MainScreen]
class MainScreen extends _i29.PageRouteInfo<void> {
  const MainScreen({List<_i29.PageRouteInfo>? children})
      : super(
          MainScreen.name,
          initialChildren: children,
        );

  static const String name = 'MainScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i15.NotificationsSettingsScreen]
class NotificationsSettingsScreen extends _i29.PageRouteInfo<void> {
  const NotificationsSettingsScreen({List<_i29.PageRouteInfo>? children})
      : super(
          NotificationsSettingsScreen.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsSettingsScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OrderedSuccessfullyScreen]
class OrderedSuccessfullyScreen
    extends _i29.PageRouteInfo<OrderedSuccessfullyScreenArgs> {
  OrderedSuccessfullyScreen({
    _i30.Key? key,
    required _i33.Order order,
    String? pun,
    List<_i29.PageRouteInfo>? children,
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

  static const _i29.PageInfo<OrderedSuccessfullyScreenArgs> page =
      _i29.PageInfo<OrderedSuccessfullyScreenArgs>(name);
}

class OrderedSuccessfullyScreenArgs {
  const OrderedSuccessfullyScreenArgs({
    this.key,
    required this.order,
    this.pun,
  });

  final _i30.Key? key;

  final _i33.Order order;

  final String? pun;

  @override
  String toString() {
    return 'OrderedSuccessfullyScreenArgs{key: $key, order: $order, pun: $pun}';
  }
}

/// generated route for
/// [_i17.PaymentWebView]
class PaymentWebView extends _i29.PageRouteInfo<PaymentWebViewArgs> {
  PaymentWebView({
    _i30.Key? key,
    required String redirectUrl,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          PaymentWebView.name,
          args: PaymentWebViewArgs(
            key: key,
            redirectUrl: redirectUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentWebView';

  static const _i29.PageInfo<PaymentWebViewArgs> page =
      _i29.PageInfo<PaymentWebViewArgs>(name);
}

class PaymentWebViewArgs {
  const PaymentWebViewArgs({
    this.key,
    required this.redirectUrl,
  });

  final _i30.Key? key;

  final String redirectUrl;

  @override
  String toString() {
    return 'PaymentWebViewArgs{key: $key, redirectUrl: $redirectUrl}';
  }
}

/// generated route for
/// [_i18.PointsHistoryScreen]
class PointsHistoryScreen extends _i29.PageRouteInfo<void> {
  const PointsHistoryScreen({List<_i29.PageRouteInfo>? children})
      : super(
          PointsHistoryScreen.name,
          initialChildren: children,
        );

  static const String name = 'PointsHistoryScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ProfileScreen]
class ProfileScreen extends _i29.PageRouteInfo<void> {
  const ProfileScreen({List<_i29.PageRouteInfo>? children})
      : super(
          ProfileScreen.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i20.RegisterScreen]
class RegisterScreen extends _i29.PageRouteInfo<RegisterScreenArgs> {
  RegisterScreen({
    _i30.Key? key,
    required String mobileNumber,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          RegisterScreen.name,
          args: RegisterScreenArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterScreen';

  static const _i29.PageInfo<RegisterScreenArgs> page =
      _i29.PageInfo<RegisterScreenArgs>(name);
}

class RegisterScreenArgs {
  const RegisterScreenArgs({
    this.key,
    required this.mobileNumber,
  });

  final _i30.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'RegisterScreenArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [_i21.SalesOrderDetailsScreen]
class SalesOrderDetailsScreen
    extends _i29.PageRouteInfo<SalesOrderDetailsScreenArgs> {
  SalesOrderDetailsScreen({
    _i30.Key? key,
    required _i34.SalesOrder salesOrder,
    required List<String> statuses,
    List<_i29.PageRouteInfo>? children,
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

  static const _i29.PageInfo<SalesOrderDetailsScreenArgs> page =
      _i29.PageInfo<SalesOrderDetailsScreenArgs>(name);
}

class SalesOrderDetailsScreenArgs {
  const SalesOrderDetailsScreenArgs({
    this.key,
    required this.salesOrder,
    required this.statuses,
  });

  final _i30.Key? key;

  final _i34.SalesOrder salesOrder;

  final List<String> statuses;

  @override
  String toString() {
    return 'SalesOrderDetailsScreenArgs{key: $key, salesOrder: $salesOrder, statuses: $statuses}';
  }
}

/// generated route for
/// [_i22.SalesOrdersScreen]
class SalesOrdersScreen extends _i29.PageRouteInfo<SalesOrdersScreenArgs> {
  SalesOrdersScreen({
    _i30.Key? key,
    int initialIndex = 0,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          SalesOrdersScreen.name,
          args: SalesOrdersScreenArgs(
            key: key,
            initialIndex: initialIndex,
          ),
          initialChildren: children,
        );

  static const String name = 'SalesOrdersScreen';

  static const _i29.PageInfo<SalesOrdersScreenArgs> page =
      _i29.PageInfo<SalesOrdersScreenArgs>(name);
}

class SalesOrdersScreenArgs {
  const SalesOrdersScreenArgs({
    this.key,
    this.initialIndex = 0,
  });

  final _i30.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'SalesOrdersScreenArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i23.SubscriptionScreen]
class SubscriptionScreen extends _i29.PageRouteInfo<void> {
  const SubscriptionScreen({List<_i29.PageRouteInfo>? children})
      : super(
          SubscriptionScreen.name,
          initialChildren: children,
        );

  static const String name = 'SubscriptionScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i24.TermsConditionsAndPrivacyPolicyScreen]
class TermsConditionsAndPrivacyPolicyScreen
    extends _i29.PageRouteInfo<TermsConditionsAndPrivacyPolicyScreenArgs> {
  TermsConditionsAndPrivacyPolicyScreen({
    _i30.Key? key,
    String? title,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          TermsConditionsAndPrivacyPolicyScreen.name,
          args: TermsConditionsAndPrivacyPolicyScreenArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'TermsConditionsAndPrivacyPolicyScreen';

  static const _i29.PageInfo<TermsConditionsAndPrivacyPolicyScreenArgs> page =
      _i29.PageInfo<TermsConditionsAndPrivacyPolicyScreenArgs>(name);
}

class TermsConditionsAndPrivacyPolicyScreenArgs {
  const TermsConditionsAndPrivacyPolicyScreenArgs({
    this.key,
    this.title,
  });

  final _i30.Key? key;

  final String? title;

  @override
  String toString() {
    return 'TermsConditionsAndPrivacyPolicyScreenArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i25.TrackMapScreen]
class TrackMapScreen extends _i29.PageRouteInfo<TrackMapScreenArgs> {
  TrackMapScreen({
    _i30.Key? key,
    required _i34.SalesOrder salesOrder,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          TrackMapScreen.name,
          args: TrackMapScreenArgs(
            key: key,
            salesOrder: salesOrder,
          ),
          initialChildren: children,
        );

  static const String name = 'TrackMapScreen';

  static const _i29.PageInfo<TrackMapScreenArgs> page =
      _i29.PageInfo<TrackMapScreenArgs>(name);
}

class TrackMapScreenArgs {
  const TrackMapScreenArgs({
    this.key,
    required this.salesOrder,
  });

  final _i30.Key? key;

  final _i34.SalesOrder salesOrder;

  @override
  String toString() {
    return 'TrackMapScreenArgs{key: $key, salesOrder: $salesOrder}';
  }
}

/// generated route for
/// [_i26.TransactionHistoryScreen]
class TransactionHistoryScreen extends _i29.PageRouteInfo<void> {
  const TransactionHistoryScreen({List<_i29.PageRouteInfo>? children})
      : super(
          TransactionHistoryScreen.name,
          initialChildren: children,
        );

  static const String name = 'TransactionHistoryScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i27.WidamLoyaltyProgramScreen]
class WidamLoyaltyProgramScreen extends _i29.PageRouteInfo<void> {
  const WidamLoyaltyProgramScreen({List<_i29.PageRouteInfo>? children})
      : super(
          WidamLoyaltyProgramScreen.name,
          initialChildren: children,
        );

  static const String name = 'WidamLoyaltyProgramScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}

/// generated route for
/// [_i28.WidamWalletScreen]
class WidamWalletScreen extends _i29.PageRouteInfo<void> {
  const WidamWalletScreen({List<_i29.PageRouteInfo>? children})
      : super(
          WidamWalletScreen.name,
          initialChildren: children,
        );

  static const String name = 'WidamWalletScreen';

  static const _i29.PageInfo<void> page = _i29.PageInfo<void>(name);
}
