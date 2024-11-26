import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:widam/src/features/cart/presentation/add_to_cart_button/quantity_controller.dart';
import 'package:widam/src/features/recommendations/presentation/recently_viewd/recently_viewd_controller.dart';
import 'package:widam/src/features/recommendations/presentation/similar_items/similar_items_controller.dart';
import 'package:widam/src/global_providers/global_providers.dart';
import '../../../../common_widgets/banner/app_banner_dialog.dart';
import '../../../../common_widgets/fade_circle_loading_indicator.dart';
import '../../../../theme/app_colors.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../items/presentation/item_card/circle_button.dart';
import '../../application/cart_service.dart';

class AddToCartButton extends ConsumerStatefulWidget {
  final int minQuantity;
  final int maxQuantity;
  final String itemId;
  final String itemWarehouseId;
  final String? row;
  final int? inStock;
  final String? attributionToken;

  const AddToCartButton({
    super.key,
    required this.minQuantity,
    required this.maxQuantity,
    required this.itemId,
    required this.itemWarehouseId,
    this.row,
    this.inStock,
    this.attributionToken,
  });

  @override
  ConsumerState<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends ConsumerState<AddToCartButton> {
  bool _isExpanded = false;
  bool _isLoading = false;
  int _quantityInCart = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateCartProvider);
    final isInCart = ref.watch(isInCartProvider(widget.itemId));
    _quantityInCart = ref.watch(quantityControllerProvider(
        widget.itemId, widget.itemWarehouseId, widget.minQuantity, widget.row));
    _isLoading = state is AsyncLoading;

    _listenForCartUpdateErrors();
    _listenForIsInCart();

    if (widget.inStock == 0) {
      return _isLoading
          ? const FadeCircleLoadingIndicator()
          : CircleButton(
              backgroundColor: AppColors.cultured,
              border: Border.all(
                color: AppColors.sunsetOrange,
                width: 0.5,
              ),
              onTap: () async {
                await _deleteItem();
              },
              child: _deleteIcon(),
            );
    }

    return Opacity(
      opacity: _isLoading ? 0.5 : 1,
      child: GestureDetector(
        onTap: _toggleExpanded,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _isExpanded ? 150 : kCircleButtonSize,
          height: kCircleButtonSize,
          decoration: _buildContainerDecoration(),
          child: Stack(
            children: [
              _buildRemoveButton(),
              _buildQuantityText(),
              _buildAddButton(isInCart),
            ],
          ),
        ),
      ),
    );
  }

  bool get _canVibrate => ref.read(canVibrateProvider).requireValue;

  Future<void> _deleteItem() async {
    _warningFeedback();
    final result = await ref
        .read(updateCartProvider.notifier)
        .deleteItemFromCart(itemId: widget.itemId, row: widget.row);
    if (result) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  void _listenForCartUpdateErrors() {
    ref.listen(updateCartProvider, (previous, next) {
      if (next is AsyncError) {
        showAppBannerDialog(context, next.error.toString(), next.stackTrace);
      }
    });
  }

  void _listenForIsInCart() {
    ref.listen(isInCartProvider(widget.itemId), (previous, next) {
      setState(() {
        _isExpanded = false;
      });
    });
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.cultured,
      borderRadius: BorderRadius.circular(14),
    );
  }

  Widget _buildRemoveButton() {
    return PositionedDirectional(
      start: 0,
      child: CircleButton(
        backgroundColor: AppColors.cultured,
        border: Border.all(
          color: AppColors.sunsetOrange,
          width: 0.5,
        ),
        onTap: _isLoading
            ? null
            : _isExpanded && _quantityInCart >= widget.minQuantity
                ? () => _handleRemoveButtonTap()
                : null,
        child: _buildRemoveButtonContent(),
      ),
    );
  }

  void _handleRemoveButtonTap() async {
    if (_quantityInCart == widget.minQuantity || widget.row != null) {
      await _deleteItem();
    } else {
      _warningFeedback();
      ref
          .read(quantityControllerProvider(
                  widget.itemId, widget.itemWarehouseId, widget.minQuantity, widget.row)
              .notifier)
          .decrementQuantity();
    }
  }

  void _warningFeedback() {
    if (_canVibrate) {
      Vibrate.feedback(FeedbackType.warning);
    }
  }

  Widget _buildRemoveButtonContent() {
    return _quantityInCart > widget.minQuantity && widget.row == null
        ? const Icon(
            Icons.remove,
            color: AppColors.sunsetOrange,
          )
        : _deleteIcon();
  }

  Widget _deleteIcon() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Assets.icons.deleteIcon.svg(),
    );
  }

  Widget _buildQuantityText() {
    return Center(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: _isExpanded
            ? _isLoading
                ? const FadeCircleLoadingIndicator()
                : Text(
                    _quantityInCart.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildAddButton(bool isInCart) {
    return PositionedDirectional(
      end: 0,
      child: CircleButton(
        onTap: _isLoading
            ? null
            : _isExpanded &&
                    _quantityInCart < widget.maxQuantity &&
                    widget.row == null
                ? () => _handleAddButtonTap()
                : !_isExpanded && !isInCart
                    ? () async => _handleInitialAddButtonTap()
                    : null,
        backgroundColor: _isExpanded || isInCart
            ? AppColors.sunsetOrange
            : AppColors.secondary,
        child: !_isExpanded && isInCart
            ? Center(
                child: Text(
                  _quantityInCart.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            : Icon(
                widget.row != null ? Icons.close : Icons.add,
                color: Colors.white,
              ),
      ),
    );
  }

  Future<void> _handleAddButtonTap() async {
    _heavyFeedback();
    ref
        .read(quantityControllerProvider(
                widget.itemId, widget.itemWarehouseId, widget.minQuantity, widget.row)
            .notifier)
        .increamentQuantity();
  }

  void _heavyFeedback() {
    if (_canVibrate) {
      Vibrate.feedback(FeedbackType.heavy);
    }
  }

  Future<void> _handleInitialAddButtonTap() async {
    _heavyFeedback();
    setState(() {
      _isExpanded = true;
    });
    ref
        .read(quantityControllerProvider(
                widget.itemId, widget.itemWarehouseId, widget.minQuantity, widget.row)
            .notifier)
        .addTocart(widget.attributionToken);
    ref.invalidate(recentlyViewdControllerProvider);
    ref.invalidate(similarItemsControllerProvider);
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
