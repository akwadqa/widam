import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/item_groups/domain/item_group_details/item_group_details.dart';
import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/filters_drop_down/filters_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_controller.dart';
import 'package:widam/src/features/item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';

import '../../../../generated/l10n.dart';
import '../../../common_models/response/pagination.dart';
import '../../item_groups/data/item_groups_repository.dart';
import '../domain/item/item.dart';

part 'item_group_items_controller.g.dart';

@riverpod
class ItemGroupItemsController extends _$ItemGroupItemsController {
  @override
  FutureOr<ItemGroupItemsState> build() {
    final initialState = ref.watch(getAllItemGroupsProvider).when(
          data: (data) => ItemGroupItemsLoaded(
            items: data.data.websiteItems,
            pagination: data.pagination!,
            paginationError: null,
          ),
          loading: () => const ItemGroupItemsLoading(),
          error: (error, stackTrace) => ItemGroupItemsError(error, stackTrace),
        );
    return initialState;
  }

  ItemGroupsRepository get _itemGroupsRepository =>
      ref.watch(itemGroupsRepositoryProvider);

  String? get _itemGroupId =>
      ref.watch(selectedSubItemGroupControllerProvider) ??
      (ref.watch(selectedItemGroupControllerProvider) == Strings.allItemGroup
          ? null
          : ref.watch(selectedItemGroupControllerProvider));

  String? get _selectedFilter => ref.watch(selectedFilterControllerProvider);

  String? get _sortBy => _setSortValues(_selectedFilter)?['sortBy'];

  String? get _sortOrder => _setSortValues(_selectedFilter)?['sortOrder'];

  String? get _barcode => ref.watch(barcodeControllerProvider);

  String? get _searchQuery => ref.watch(itemGroupsSearchControllerProvider);

  String? get _params => ref.watch(paramsControllerProvider);

  Future<bool> onLoading(int page) async {
    final totalPage = ((state as AsyncData<ItemGroupItemsState>).asData!.value
            as ItemGroupItemsLoaded)
        .pagination
        .totalPages;
    if (state is! AsyncData<ItemGroupItemsState> || page > totalPage) {
      return false;
    }
    try {
      final AppResponse<ItemGroupDetails> appResponse =
          await _itemGroupsRepository.getItemsByItemGroup(
              itemGroupId: _itemGroupId,
              page: page,
              sortBy: _sortBy,
              sortOrder: _sortOrder,
              barcode: _barcode,
              searchQuery: _searchQuery,
              parameters: _params);

      state = AsyncData((state.asData!.value as ItemGroupItemsLoaded).copyWith(
        items: [
          ...(state.asData!.value as ItemGroupItemsLoaded).items,
          ...appResponse.data.websiteItems
        ],
        pagination: appResponse.pagination!,
        paginationError: null,
      ));

      return true;
    } catch (e, stack) {
      state = AsyncData((state.asData!.value as ItemGroupItemsLoaded).copyWith(
        paginationError: ItemGroupItemsError(e, stack),
      ));

      return false;
    }
  }

  Future<void> getItems() async {
    state = const AsyncLoading();
    await _getItems();
  }

  Future<void> _getItems() async {
    try {
      final appResponse = await _itemGroupsRepository.getItemsByItemGroup(
          itemGroupId: _itemGroupId,
          page: 1,
          sortBy: _sortBy,
          sortOrder: _sortOrder,
          barcode: _barcode,
          parameters: _params,
          searchQuery: _searchQuery);
      state = AsyncData(ItemGroupItemsLoaded(
        items: appResponse.data.websiteItems,
        pagination: appResponse.pagination!,
        paginationError: null,
      ));
      if (appResponse.data.isGroup == 1 && _itemGroupId != null) {
        ref
            .read(subItemGroupsControllerProvider.notifier)
            .set(appResponse.data.subCategories);
      }
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<bool> onRefresh() async {
    await _getItems();
    return true;
  }

  Map<String, String>? _setSortValues(String? sortValue) {
    final sortValuesMap = {
      S.current.priceHighToLow: {
        'sortBy': 'website_item_price',
        'sortOrder': 'desc'
      },
      S.current.priceLowToHigh: {
        'sortBy': 'website_item_price',
        'sortOrder': 'asc'
      },
      S.current.nameZtoA: {'sortBy': 'website_item_name', 'sortOrder': 'desc'},
    };

    final sortValues = sortValuesMap[sortValue];
    return sortValues;
  }
}

abstract class ItemGroupItemsState {
  const ItemGroupItemsState();
}

class ItemGroupItemsInitial extends ItemGroupItemsState {
  const ItemGroupItemsInitial();
}

class ItemGroupItemsLoading extends ItemGroupItemsState {
  const ItemGroupItemsLoading();
}

class ItemGroupItemsLoaded extends ItemGroupItemsState {
  ItemGroupItemsLoaded({
    required this.items,
    required this.pagination,
    this.paginationError,
  });

  final List<Item> items;
  final Pagination pagination;
  final ItemGroupItemsError? paginationError;

  ItemGroupItemsLoaded copyWith({
    List<Item>? items,
    Pagination? pagination,
    ItemGroupItemsError? paginationError,
  }) {
    return ItemGroupItemsLoaded(
      items: items ?? this.items,
      pagination: pagination ?? this.pagination,
      paginationError: paginationError ?? this.paginationError,
    );
  }
}

class ItemGroupItemsError extends ItemGroupItemsState {
  ItemGroupItemsError(this.error, this.stackTrace);
  final Object error;
  final StackTrace stackTrace;
}
