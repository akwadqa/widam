import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/features/user_language/application/current_language.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../common_widgets/banner/app_banner.dart';
import '../../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../../common_widgets/fade_circle_loading_indicator.dart';
import 'addresses_list_controller.dart';

import '../../../../../routing/app_router.gr.dart';
import '../../../domain/address/address.dart';
import '../address_card.dart';
import 'delete_address_controller.dart';

class AddressesList extends ConsumerWidget {
  const AddressesList({super.key, this.isEditable = true});

  final bool isEditable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesAsync = ref.watch(addressesListControllerProvider);
    return addressesAsync.when(
        data: (addresses) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${S.of(context).existingAddresses} (${addresses.length})',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 10.0),
                isEditable
                    ? _AnimatedList(addresses: addresses)
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return InkWell(
                              onTap: () => context.maybePop(address),
                              child: AddressCard(address: address));
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8.0),
                        itemCount: addresses.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        },
        error: (error, stackTrace) =>
            AppBanner(message: error.toString(), stackTrace: stackTrace),
        loading: () => const FadeCircleLoadingIndicator());
  }
}

class _AnimatedList extends StatefulWidget {
  const _AnimatedList({required this.addresses});
  final List<Address> addresses;
  @override
  State<_AnimatedList> createState() => __AnimatedListState();
}

class __AnimatedListState extends State<_AnimatedList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _controller.repeat(reverse: true);
    Timer(const Duration(seconds: 2), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final address = widget.addresses[index];
          return address.preferredShippingAddress != 1
              ? Dismissible(
                  key: ValueKey(address.addressId),
                  confirmDismiss: (direction) {
                    return showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                          title: Text(S.of(context).areYouSure),
                          actions: [
                            TextButton(
                                onPressed: () => context.maybePop(false),
                                child: Text(S.of(context).no)),
                            Consumer(
                              builder: (context, ref, child) {
                                ref.listen(deleteAddressControllerProvider,
                                    (previous, next) {
                                  if (next is AsyncData) {
                                    context.maybePop(true);
                                  } else if (next is AsyncError) {
                                    context.maybePop(false);
                                    showAppBannerDialog(context,
                                        next.error.toString(), next.stackTrace);
                                  }
                                });
                                final deleteAddressController =
                                    ref.watch(deleteAddressControllerProvider);
                                if (deleteAddressController is AsyncLoading) {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive());
                                }
                                return TextButton(
                                    child: Text(S.of(context).yes),
                                    onPressed: () {
                                      ref
                                          .read(deleteAddressControllerProvider
                                              .notifier)
                                          .deleteAddress(address);
                                    });
                              },
                            )
                          ]),
                    );
                  },
                  background: const _DismissibleBackground(),
                  direction: DismissDirection.endToStart,
                  child: _getItem(index, address),
                )
              : _getItem(index, address);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        itemCount: widget.addresses.length,
        shrinkWrap: true);
  }

  Widget _getItem(int index, Address address) {
    return index ==
            widget.addresses
                .indexWhere((element) => element.preferredShippingAddress != 1)
        ? Stack(
            children: [
              const Positioned.fill(child: _DismissibleBackground()),
              Builder(builder: (context) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Consumer(
                      builder: (context, ref, child) {
                        final currentLanguage =
                            ref.watch(currentLanguageProvider);
                        return Transform.translate(
                          offset: Offset(
                            currentLanguage == 'ar'
                                ? _controller.value * 50.0
                                : -_controller.value * 50.0,
                            0.0,
                          ),
                          child: _addressCard(address),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          )
        : _addressCard(address);
  }

  AddressCard _addressCard(Address address) {
    return AddressCard(
        address: address,
        showEditButton: true,
        onEdit: () {
          context.pushRoute(AddEditAddressScreen(
              address: address,
              latitude: address.latitude,
              longitude: address.longitude,
              geofenceId: address.geofence!.geofenceId));
        });
  }
}

class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.white,
        padding: const EdgeInsetsDirectional.only(end: 10),
        child: Assets.icons.deleteIcon.svg(height: 25));
  }
}
