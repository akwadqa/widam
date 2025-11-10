// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i34;
import 'package:flutter/material.dart' as _i35;
import 'package:widam/src/features/account/presentation/edit_profile_screen/edit_profile_screen.dart'
    as _i10;
import 'package:widam/src/features/account/presentation/register_screen/register_screen.dart'
    as _i23;
import 'package:widam/src/features/addresses/domain/address/address.dart'
    as _i36;
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
import 'package:widam/src/features/checkout/domain/order/order.dart' as _i39;
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
import 'package:widam/src/features/layouts/domain/banner/banner.dart' as _i38;
import 'package:widam/src/features/layouts/domain/block.dart' as _i37;
import 'package:widam/src/features/loyalty_points/presentation/points_history_screen/points_history_screen.dart'
    as _i21;
import 'package:widam/src/features/loyalty_points/presentation/widam_loyalty_program_screen/widam_loyalty_program_screen.dart'
    as _i32;
import 'package:widam/src/features/main/presentation/main_screen/main_screen.dart'
    as _i16;
import 'package:widam/src/features/notifications/presentation/notifications_settings_screen/notifications_settings_screen.dart'
    as _i18;
import 'package:widam/src/features/profile/presentation/profile_screen/profile_screen.dart'
    as _i22;
import 'package:widam/src/features/profile/presentation/terms_conditions_and_privacy_policy_screen.dart'
    as _i27;
import 'package:widam/src/features/sales_orders/domain/sales_order/sales_order.dart'
    as _i40;
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
import 'package:widam/src/features/udhiya_coupons/presentation/udhiya_coupon_details_screen/udhiya_coupon_details_screen.dart'
    as _i30;
import 'package:widam/src/features/udhiya_coupons/presentation/udhiya_coupons_screen/udhiya_coupons_screen.dart'
    as _i31;
import 'package:widam/src/features/wallet/presentation/transaction_history_screen/transaction_history_screen.dart'
    as _i29;
import 'package:widam/src/features/wallet/presentation/widam_wallet_screen/widam_wallet_screen.dart'
    as _i33;

/// generated route for
/// [_i1.ActiveSubscriptionsScreen]
class ActiveSubscriptionsScreen extends _i34.PageRouteInfo<void> {
  const ActiveSubscriptionsScreen({List<_i34.PageRouteInfo>? children})
    : super(ActiveSubscriptionsScreen.name, initialChildren: children);

  static const String name = 'ActiveSubscriptionsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i1.ActiveSubscriptionsScreen();
    },
  );
}

/// generated route for
/// [_i2.AddComplaintScreen]
class AddComplaintScreen extends _i34.PageRouteInfo<void> {
  const AddComplaintScreen({List<_i34.PageRouteInfo>? children})
    : super(AddComplaintScreen.name, initialChildren: children);

  static const String name = 'AddComplaintScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddComplaintScreen();
    },
  );
}

/// generated route for
/// [_i3.AddEditAddressScreen]
class AddEditAddressScreen
    extends _i34.PageRouteInfo<AddEditAddressScreenArgs> {
  AddEditAddressScreen({
    _i35.Key? key,
    _i36.Address? address,
    required String latitude,
    required String longitude,
    required String geofenceId,
    List<_i34.PageRouteInfo>? children,
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

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditAddressScreenArgs>();
      return _i3.AddEditAddressScreen(
        key: args.key,
        address: args.address,
        latitude: args.latitude,
        longitude: args.longitude,
        geofenceId: args.geofenceId,
      );
    },
  );
}

class AddEditAddressScreenArgs {
  const AddEditAddressScreenArgs({
    this.key,
    this.address,
    required this.latitude,
    required this.longitude,
    required this.geofenceId,
  });

  final _i35.Key? key;

  final _i36.Address? address;

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
class AddressesScreen extends _i34.PageRouteInfo<void> {
  const AddressesScreen({List<_i34.PageRouteInfo>? children})
    : super(AddressesScreen.name, initialChildren: children);

  static const String name = 'AddressesScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i4.AddressesScreen();
    },
  );
}

/// generated route for
/// [_i5.AppInitialScreen]
class AppInitialScreen extends _i34.PageRouteInfo<void> {
  const AppInitialScreen({List<_i34.PageRouteInfo>? children})
    : super(AppInitialScreen.name, initialChildren: children);

  static const String name = 'AppInitialScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i5.AppInitialScreen();
    },
  );
}

/// generated route for
/// [_i6.CartScreen]
class CartScreen extends _i34.PageRouteInfo<void> {
  const CartScreen({List<_i34.PageRouteInfo>? children})
    : super(CartScreen.name, initialChildren: children);

  static const String name = 'CartScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i6.CartScreen();
    },
  );
}

/// generated route for
/// [_i7.CheckoutScreen]
class CheckoutScreen extends _i34.PageRouteInfo<void> {
  const CheckoutScreen({List<_i34.PageRouteInfo>? children})
    : super(CheckoutScreen.name, initialChildren: children);

  static const String name = 'CheckoutScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i7.CheckoutScreen();
    },
  );
}

/// generated route for
/// [_i8.ComplaintsScreen]
class ComplaintsScreen extends _i34.PageRouteInfo<void> {
  const ComplaintsScreen({List<_i34.PageRouteInfo>? children})
    : super(ComplaintsScreen.name, initialChildren: children);

  static const String name = 'ComplaintsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i8.ComplaintsScreen();
    },
  );
}

/// generated route for
/// [_i9.DealsScreen]
class DealsScreen extends _i34.PageRouteInfo<void> {
  const DealsScreen({List<_i34.PageRouteInfo>? children})
    : super(DealsScreen.name, initialChildren: children);

  static const String name = 'DealsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i9.DealsScreen();
    },
  );
}

/// generated route for
/// [_i10.EditProfileScreen]
class EditProfileScreen extends _i34.PageRouteInfo<void> {
  const EditProfileScreen({List<_i34.PageRouteInfo>? children})
    : super(EditProfileScreen.name, initialChildren: children);

  static const String name = 'EditProfileScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i10.EditProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.HomeScreen]
class HomeScreen extends _i34.PageRouteInfo<HomeScreenArgs> {
  HomeScreen({
    _i35.Key? key,
    _i37.Block<List<_i38.Banner>>? bannerBlock,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         HomeScreen.name,
         args: HomeScreenArgs(key: key, bannerBlock: bannerBlock),
         initialChildren: children,
       );

  static const String name = 'HomeScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeScreenArgs>(
        orElse: () => const HomeScreenArgs(),
      );
      return _i11.HomeScreen(key: args.key, bannerBlock: args.bannerBlock);
    },
  );
}

class HomeScreenArgs {
  const HomeScreenArgs({this.key, this.bannerBlock});

  final _i35.Key? key;

  final _i37.Block<List<_i38.Banner>>? bannerBlock;

  @override
  String toString() {
    return 'HomeScreenArgs{key: $key, bannerBlock: $bannerBlock}';
  }
}

/// generated route for
/// [_i12.ItemDetailsScreen]
class ItemDetailsScreen extends _i34.PageRouteInfo<ItemDetailsScreenArgs> {
  ItemDetailsScreen({
    _i35.Key? key,
    required String itemId,
    String? mubadaraId,
    String? attributionToken,
    List<_i34.PageRouteInfo>? children,
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

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemDetailsScreenArgs>();
      return _i12.ItemDetailsScreen(
        key: args.key,
        itemId: args.itemId,
        mubadaraId: args.mubadaraId,
        attributionToken: args.attributionToken,
      );
    },
  );
}

class ItemDetailsScreenArgs {
  const ItemDetailsScreenArgs({
    this.key,
    required this.itemId,
    this.mubadaraId,
    this.attributionToken,
  });

  final _i35.Key? key;

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
class ItemGroupScreen extends _i34.PageRouteInfo<ItemGroupScreenArgs> {
  ItemGroupScreen({
    _i35.Key? key,
    bool autoFocus = false,
    required String itemGroupId,
    List<_i34.PageRouteInfo>? children,
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

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemGroupScreenArgs>();
      return _i13.ItemGroupScreen(
        key: args.key,
        autoFocus: args.autoFocus,
        itemGroupId: args.itemGroupId,
      );
    },
  );
}

class ItemGroupScreenArgs {
  const ItemGroupScreenArgs({
    this.key,
    this.autoFocus = false,
    required this.itemGroupId,
  });

  final _i35.Key? key;

  final bool autoFocus;

  final String itemGroupId;

  @override
  String toString() {
    return 'ItemGroupScreenArgs{key: $key, autoFocus: $autoFocus, itemGroupId: $itemGroupId}';
  }
}

/// generated route for
/// [_i14.ItemGroupsScreen]
class ItemGroupsScreen extends _i34.PageRouteInfo<void> {
  const ItemGroupsScreen({List<_i34.PageRouteInfo>? children})
    : super(ItemGroupsScreen.name, initialChildren: children);

  static const String name = 'ItemGroupsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i14.ItemGroupsScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginScreen extends _i34.PageRouteInfo<void> {
  const LoginScreen({List<_i34.PageRouteInfo>? children})
    : super(LoginScreen.name, initialChildren: children);

  static const String name = 'LoginScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.MainScreen]
class MainScreen extends _i34.PageRouteInfo<void> {
  const MainScreen({List<_i34.PageRouteInfo>? children})
    : super(MainScreen.name, initialChildren: children);

  static const String name = 'MainScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i16.MainScreen();
    },
  );
}

/// generated route for
/// [_i17.MubadaraItemsScreen]
class MubadaraItemsScreen extends _i34.PageRouteInfo<MubadaraItemsScreenArgs> {
  MubadaraItemsScreen({
    _i35.Key? key,
    required String mubadaraId,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         MubadaraItemsScreen.name,
         args: MubadaraItemsScreenArgs(key: key, mubadaraId: mubadaraId),
         initialChildren: children,
       );

  static const String name = 'MubadaraItemsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MubadaraItemsScreenArgs>();
      return _i17.MubadaraItemsScreen(
        key: args.key,
        mubadaraId: args.mubadaraId,
      );
    },
  );
}

class MubadaraItemsScreenArgs {
  const MubadaraItemsScreenArgs({this.key, required this.mubadaraId});

  final _i35.Key? key;

  final String mubadaraId;

  @override
  String toString() {
    return 'MubadaraItemsScreenArgs{key: $key, mubadaraId: $mubadaraId}';
  }
}

/// generated route for
/// [_i18.NotificationsSettingsScreen]
class NotificationsSettingsScreen extends _i34.PageRouteInfo<void> {
  const NotificationsSettingsScreen({List<_i34.PageRouteInfo>? children})
    : super(NotificationsSettingsScreen.name, initialChildren: children);

  static const String name = 'NotificationsSettingsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i18.NotificationsSettingsScreen();
    },
  );
}

/// generated route for
/// [_i19.OrderedSuccessfullyScreen]
class OrderedSuccessfullyScreen
    extends _i34.PageRouteInfo<OrderedSuccessfullyScreenArgs> {
  OrderedSuccessfullyScreen({
    _i35.Key? key,
    required _i39.Order order,
    String? pun,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         OrderedSuccessfullyScreen.name,
         args: OrderedSuccessfullyScreenArgs(key: key, order: order, pun: pun),
         initialChildren: children,
       );

  static const String name = 'OrderedSuccessfullyScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderedSuccessfullyScreenArgs>();
      return _i19.OrderedSuccessfullyScreen(
        key: args.key,
        order: args.order,
        pun: args.pun,
      );
    },
  );
}

class OrderedSuccessfullyScreenArgs {
  const OrderedSuccessfullyScreenArgs({
    this.key,
    required this.order,
    this.pun,
  });

  final _i35.Key? key;

  final _i39.Order order;

  final String? pun;

  @override
  String toString() {
    return 'OrderedSuccessfullyScreenArgs{key: $key, order: $order, pun: $pun}';
  }
}

/// generated route for
/// [_i20.PaymentWebView]
class PaymentWebView extends _i34.PageRouteInfo<PaymentWebViewArgs> {
  PaymentWebView({
    _i35.Key? key,
    required String redirectUrl,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         PaymentWebView.name,
         args: PaymentWebViewArgs(key: key, redirectUrl: redirectUrl),
         initialChildren: children,
       );

  static const String name = 'PaymentWebView';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentWebViewArgs>();
      return _i20.PaymentWebView(key: args.key, redirectUrl: args.redirectUrl);
    },
  );
}

class PaymentWebViewArgs {
  const PaymentWebViewArgs({this.key, required this.redirectUrl});

  final _i35.Key? key;

  final String redirectUrl;

  @override
  String toString() {
    return 'PaymentWebViewArgs{key: $key, redirectUrl: $redirectUrl}';
  }
}

/// generated route for
/// [_i21.PointsHistoryScreen]
class PointsHistoryScreen extends _i34.PageRouteInfo<void> {
  const PointsHistoryScreen({List<_i34.PageRouteInfo>? children})
    : super(PointsHistoryScreen.name, initialChildren: children);

  static const String name = 'PointsHistoryScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i21.PointsHistoryScreen();
    },
  );
}

/// generated route for
/// [_i22.ProfileScreen]
class ProfileScreen extends _i34.PageRouteInfo<void> {
  const ProfileScreen({List<_i34.PageRouteInfo>? children})
    : super(ProfileScreen.name, initialChildren: children);

  static const String name = 'ProfileScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i22.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i23.RegisterScreen]
class RegisterScreen extends _i34.PageRouteInfo<RegisterScreenArgs> {
  RegisterScreen({
    _i35.Key? key,
    required String mobileNumber,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         RegisterScreen.name,
         args: RegisterScreenArgs(key: key, mobileNumber: mobileNumber),
         initialChildren: children,
       );

  static const String name = 'RegisterScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterScreenArgs>();
      return _i23.RegisterScreen(
        key: args.key,
        mobileNumber: args.mobileNumber,
      );
    },
  );
}

class RegisterScreenArgs {
  const RegisterScreenArgs({this.key, required this.mobileNumber});

  final _i35.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'RegisterScreenArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [_i24.SalesOrderDetailsScreen]
class SalesOrderDetailsScreen
    extends _i34.PageRouteInfo<SalesOrderDetailsScreenArgs> {
  SalesOrderDetailsScreen({
    _i35.Key? key,
    required _i40.SalesOrder salesOrder,
    required List<String> statuses,
    List<_i34.PageRouteInfo>? children,
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

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesOrderDetailsScreenArgs>();
      return _i24.SalesOrderDetailsScreen(
        key: args.key,
        salesOrder: args.salesOrder,
        statuses: args.statuses,
      );
    },
  );
}

class SalesOrderDetailsScreenArgs {
  const SalesOrderDetailsScreenArgs({
    this.key,
    required this.salesOrder,
    required this.statuses,
  });

  final _i35.Key? key;

  final _i40.SalesOrder salesOrder;

  final List<String> statuses;

  @override
  String toString() {
    return 'SalesOrderDetailsScreenArgs{key: $key, salesOrder: $salesOrder, statuses: $statuses}';
  }
}

/// generated route for
/// [_i25.SalesOrdersScreen]
class SalesOrdersScreen extends _i34.PageRouteInfo<SalesOrdersScreenArgs> {
  SalesOrdersScreen({
    _i35.Key? key,
    int initialIndex = 0,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         SalesOrdersScreen.name,
         args: SalesOrdersScreenArgs(key: key, initialIndex: initialIndex),
         initialChildren: children,
       );

  static const String name = 'SalesOrdersScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesOrdersScreenArgs>(
        orElse: () => const SalesOrdersScreenArgs(),
      );
      return _i25.SalesOrdersScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class SalesOrdersScreenArgs {
  const SalesOrdersScreenArgs({this.key, this.initialIndex = 0});

  final _i35.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'SalesOrdersScreenArgs{key: $key, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [_i26.SubscriptionScreen]
class SubscriptionScreen extends _i34.PageRouteInfo<void> {
  const SubscriptionScreen({List<_i34.PageRouteInfo>? children})
    : super(SubscriptionScreen.name, initialChildren: children);

  static const String name = 'SubscriptionScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i26.SubscriptionScreen();
    },
  );
}

/// generated route for
/// [_i27.TermsConditionsAndPrivacyPolicyScreen]
class TermsConditionsAndPrivacyPolicyScreen
    extends _i34.PageRouteInfo<TermsConditionsAndPrivacyPolicyScreenArgs> {
  TermsConditionsAndPrivacyPolicyScreen({
    _i35.Key? key,
    String? title,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         TermsConditionsAndPrivacyPolicyScreen.name,
         args: TermsConditionsAndPrivacyPolicyScreenArgs(
           key: key,
           title: title,
         ),
         initialChildren: children,
       );

  static const String name = 'TermsConditionsAndPrivacyPolicyScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TermsConditionsAndPrivacyPolicyScreenArgs>(
        orElse: () => const TermsConditionsAndPrivacyPolicyScreenArgs(),
      );
      return _i27.TermsConditionsAndPrivacyPolicyScreen(
        key: args.key,
        title: args.title,
      );
    },
  );
}

class TermsConditionsAndPrivacyPolicyScreenArgs {
  const TermsConditionsAndPrivacyPolicyScreenArgs({this.key, this.title});

  final _i35.Key? key;

  final String? title;

  @override
  String toString() {
    return 'TermsConditionsAndPrivacyPolicyScreenArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i28.TrackMapScreen]
class TrackMapScreen extends _i34.PageRouteInfo<TrackMapScreenArgs> {
  TrackMapScreen({
    _i35.Key? key,
    required _i40.SalesOrder salesOrder,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         TrackMapScreen.name,
         args: TrackMapScreenArgs(key: key, salesOrder: salesOrder),
         initialChildren: children,
       );

  static const String name = 'TrackMapScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrackMapScreenArgs>();
      return _i28.TrackMapScreen(key: args.key, salesOrder: args.salesOrder);
    },
  );
}

class TrackMapScreenArgs {
  const TrackMapScreenArgs({this.key, required this.salesOrder});

  final _i35.Key? key;

  final _i40.SalesOrder salesOrder;

  @override
  String toString() {
    return 'TrackMapScreenArgs{key: $key, salesOrder: $salesOrder}';
  }
}

/// generated route for
/// [_i29.TransactionHistoryScreen]
class TransactionHistoryScreen extends _i34.PageRouteInfo<void> {
  const TransactionHistoryScreen({List<_i34.PageRouteInfo>? children})
    : super(TransactionHistoryScreen.name, initialChildren: children);

  static const String name = 'TransactionHistoryScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i29.TransactionHistoryScreen();
    },
  );
}

/// generated route for
/// [_i30.UdhiyaCouponDetailsScreen]
class UdhiyaCouponDetailsScreen
    extends _i34.PageRouteInfo<UdhiyaCouponDetailsScreenArgs> {
  UdhiyaCouponDetailsScreen({
    _i35.Key? key,
    required String couponId,
    List<_i34.PageRouteInfo>? children,
  }) : super(
         UdhiyaCouponDetailsScreen.name,
         args: UdhiyaCouponDetailsScreenArgs(key: key, couponId: couponId),
         initialChildren: children,
       );

  static const String name = 'UdhiyaCouponDetailsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UdhiyaCouponDetailsScreenArgs>();
      return _i30.UdhiyaCouponDetailsScreen(
        key: args.key,
        couponId: args.couponId,
      );
    },
  );
}

class UdhiyaCouponDetailsScreenArgs {
  const UdhiyaCouponDetailsScreenArgs({this.key, required this.couponId});

  final _i35.Key? key;

  final String couponId;

  @override
  String toString() {
    return 'UdhiyaCouponDetailsScreenArgs{key: $key, couponId: $couponId}';
  }
}

/// generated route for
/// [_i31.UdhiyaCouponsScreen]
class UdhiyaCouponsScreen extends _i34.PageRouteInfo<void> {
  const UdhiyaCouponsScreen({List<_i34.PageRouteInfo>? children})
    : super(UdhiyaCouponsScreen.name, initialChildren: children);

  static const String name = 'UdhiyaCouponsScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i31.UdhiyaCouponsScreen();
    },
  );
}

/// generated route for
/// [_i32.WidamLoyaltyProgramScreen]
class WidamLoyaltyProgramScreen extends _i34.PageRouteInfo<void> {
  const WidamLoyaltyProgramScreen({List<_i34.PageRouteInfo>? children})
    : super(WidamLoyaltyProgramScreen.name, initialChildren: children);

  static const String name = 'WidamLoyaltyProgramScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i32.WidamLoyaltyProgramScreen();
    },
  );
}

/// generated route for
/// [_i33.WidamWalletScreen]
class WidamWalletScreen extends _i34.PageRouteInfo<void> {
  const WidamWalletScreen({List<_i34.PageRouteInfo>? children})
    : super(WidamWalletScreen.name, initialChildren: children);

  static const String name = 'WidamWalletScreen';

  static _i34.PageInfo page = _i34.PageInfo(
    name,
    builder: (data) {
      return const _i33.WidamWalletScreen();
    },
  );
}
