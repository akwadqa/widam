import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widam/src/constants/strings.dart';
import '../../../../../addresses/application/local_location_info.dart';
import '../../../../data/subscriptions_repository.dart';
import 'select_your_product.dart';

import '../../../../../../common_models/response/pagination.dart';
import '../../../../../items/domain/item/item.dart';

class SubscriptionsItemsNotifier
    extends StateNotifier<SubscriptionsItemsState> {
  SubscriptionsItemsNotifier(this._ref, SubscriptionsItemsState initialState)
      : super(initialState) {
    _init();
  }

  final AutoDisposeStateNotifierProviderRef<SubscriptionsItemsNotifier,
      SubscriptionsItemsState> _ref;

  String _itemGroupId = Strings.allItemGroup;
  late SubscriptionsRepository _subscriptionsRepository;

  void _init() {
    _subscriptionsRepository = _ref.watch(subscriptionsRepositoryProvider);
    _ref.listen(selectedSubscriptionsItemGroupIdProvider, (previous, next) {
      _getSubscriptionItemsByItemGroupId(itemGroupId: next);
    });
  }

  Future<bool> onLoading(int page) async {
    if (state is! SubscriptionsItemsLoaded ||
        page > (state as SubscriptionsItemsLoaded).pagination.totalPages) {
      return false;
    }
    try {
      final warehouseId = _ref.watch(localLocationInfoProvider).warehouseId;
      final dynamic appResponse = _itemGroupId == Strings.allItemGroup
          ? await _subscriptionsRepository.getAllItemGroupsSubscriptions(
              page: page, warehouseId: warehouseId)
          : await _subscriptionsRepository.getItemsByItemGroupSubscriptions(
              itemGroupId: _itemGroupId, page: page, warehouseId: warehouseId);

      state = (state as SubscriptionsItemsLoaded).copyWith(
        items: _itemGroupId == Strings.allItemGroup
            ? [
                ...(state as SubscriptionsItemsLoaded).items,
                ...appResponse.data.items
              ]
            : [
                ...(state as SubscriptionsItemsLoaded).items,
                ...appResponse.data.websiteItems
              ],
        pagination: appResponse.pagination!,
        paginationError: null,
      );

      return true;
    } catch (e, stack) {
      state = (state as SubscriptionsItemsLoaded).copyWith(
        paginationError: SubscriptionsItemsError(e, stack),
      );

      return false;
    }
  }

  Future<void> _getSubscriptionItemsByItemGroupId(
      {required String itemGroupId}) async {
    _itemGroupId = itemGroupId;
    if (_itemGroupId == Strings.allItemGroup) {
      await _loadAllItems();
    } else {
      await _loadItemsByItemGroupId();
    }
  }

  Future<void> _loadItemsByItemGroupId() async {
    state = const SubscriptionsItemsLoading();
    try {
      final warehouseId = _ref.watch(localLocationInfoProvider).warehouseId;
      final appResponse =
          await _subscriptionsRepository.getItemsByItemGroupSubscriptions(
              itemGroupId: _itemGroupId, page: 1, warehouseId: warehouseId);
      state = SubscriptionsItemsLoaded(
        items: appResponse.data.websiteItems,
        pagination: appResponse.pagination!,
        paginationError: null,
      );
    } catch (e, stack) {
      state = SubscriptionsItemsError(e, stack);
    }
  }

  Future<void> _loadAllItems() async {
    state = const SubscriptionsItemsLoading();
    try {
      final warehouseId = _ref.watch(localLocationInfoProvider).warehouseId;
      final appResponse = await _subscriptionsRepository
          .getAllItemGroupsSubscriptions(page: 1, warehouseId: warehouseId);
      state = SubscriptionsItemsLoaded(
        items: appResponse.data.websiteItems,
        pagination: appResponse.pagination!,
        paginationError: null,
      );
    } catch (e, stack) {
      state = SubscriptionsItemsError(e, stack);
    }
  }
}

final subscriptionsItemsNotifierProvider = StateNotifierProvider.autoDispose<
    SubscriptionsItemsNotifier, SubscriptionsItemsState>((ref) {
  final initialState = ref.watch(getAllItemGroupsSubscriptionsProvider).when(
      data: (data) => SubscriptionsItemsLoaded(
            items: data.data.websiteItems,
            pagination: data.pagination!,
            paginationError: null,
          ),
      error: (error, stackTrace) => SubscriptionsItemsError(error, stackTrace),
      loading: () => const SubscriptionsItemsLoading());
  return SubscriptionsItemsNotifier(ref, initialState);
});

abstract class SubscriptionsItemsState {
  const SubscriptionsItemsState();
}

class SubscriptionsItemsInitial extends SubscriptionsItemsState {
  const SubscriptionsItemsInitial();
}

class SubscriptionsItemsLoading extends SubscriptionsItemsState {
  const SubscriptionsItemsLoading();
}

class SubscriptionsItemsLoaded extends SubscriptionsItemsState {
  final List<Item> items;
  final Pagination pagination;
  final SubscriptionsItemsError? paginationError;

  const SubscriptionsItemsLoaded(
      {required this.items, required this.pagination, this.paginationError});

  SubscriptionsItemsLoaded copyWith({
    List<Item>? items,
    Pagination? pagination,
    SubscriptionsItemsError? paginationError,
  }) {
    return SubscriptionsItemsLoaded(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
      paginationError: paginationError ?? this.paginationError,
    );
  }
}

class SubscriptionsItemsError extends SubscriptionsItemsState {
  final Object error;
  final StackTrace stackTrace;

  const SubscriptionsItemsError(this.error, this.stackTrace);
}
