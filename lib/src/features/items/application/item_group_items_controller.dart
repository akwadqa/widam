// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:widam/src/common_models/response/app_response.dart';
// import 'package:widam/src/constants/strings.dart';
// import 'package:widam/src/features/addresses/application/local_location_info.dart';
// import 'package:widam/src/features/item_groups/domain/item_group_details/item_group_details.dart';
// import 'package:widam/src/features/item_groups/presentation/barcode_widget/barcode_controller.dart';
// import 'package:widam/src/features/item_groups/presentation/item_group_screen/params_controller.dart';
// import 'package:widam/src/features/item_groups/presentation/item_groups_body/filters_drop_down/filters_controller.dart';
// import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_list/selected_item_group_controller.dart';
// import 'package:widam/src/features/item_groups/presentation/item_groups_body/item_groups_search_field/item_groups_search_controller.dart';
// import 'package:widam/src/features/item_groups/presentation/item_groups_body/sub_item_groups_list/sub_item_groups_controller.dart';

// import '../../../../generated/l10n.dart';
// import '../../../common_models/response/pagination.dart';
// import '../../item_groups/data/item_groups_repository.dart';
// import '../domain/item/item.dart';

// part 'item_group_items_controller.g.dart';

// @riverpod
// class ItemGroupItemsController extends _$ItemGroupItemsController {
//   @override
//   FutureOr<ItemGroupItemsState> build() {
//     final initialState = ref.watch(getAllItemGroupsProvider).when(
//           data: (data) => ItemGroupItemsLoaded(
//             items: data.data.websiteItems,
//             pagination: data.pagination!,
//             paginationError: null,
//           ),
//           loading: () => const ItemGroupItemsLoading(),
//           error: (error, stackTrace) => ItemGroupItemsError(error, stackTrace),
//         );
//     return initialState;
//   }

//   ItemGroupsRepository get _itemGroupsRepository =>
//       ref.watch(itemGroupsRepositoryProvider);

//   String? get _itemGroupId =>
//       ref.watch(selectedSubItemGroupControllerProvider) ??
//       (ref.watch(selectedItemGroupControllerProvider) == Strings.allItemGroup
//           ? null
//           : ref.watch(selectedItemGroupControllerProvider));

//   String? get _selectedFilter => ref.watch(selectedFilterControllerProvider);

//   String? get _sortBy => _setSortValues(_selectedFilter)?['sortBy'];

//   String? get _sortOrder => _setSortValues(_selectedFilter)?['sortOrder'];

//   String? get _barcode => ref.watch(barcodeControllerProvider);

//   String? get _searchQuery => ref.watch(itemGroupsSearchControllerProvider);

//   String? get _params => ref.watch(paramsControllerProvider);

//   Future<bool> onLoading(int page) async {
//     final totalPage = ((state as AsyncData<ItemGroupItemsState>).asData!.value
//             as ItemGroupItemsLoaded)
//         .pagination
//         .totalPages;
//     if (state is! AsyncData<ItemGroupItemsState> || page > totalPage) {
//       return false;
//     }
//     try {
//       final warehouseId = ref.watch(localLocationInfoProvider).warehouseId;
//       final AppResponse<ItemGroupDetails> appResponse =
//           await _itemGroupsRepository.getItemsByItemGroup(
//               itemGroupId: _itemGroupId,
//               page: page,
//               sortBy: _sortBy,
//               sortOrder: _sortOrder,
//               barcode: _barcode,
//               searchQuery: _searchQuery,
//               parameters: _params,
//               warehouseId: warehouseId);

//       state = AsyncData((state.asData!.value as ItemGroupItemsLoaded).copyWith(
//         items: [
//           ...(state.asData!.value as ItemGroupItemsLoaded).items,
//           ...appResponse.data.websiteItems
//         ],
//         pagination: appResponse.pagination!,
//         paginationError: null,
//       ));

//       return true;
//     } catch (e, stack) {
//       state = AsyncData((state.asData!.value as ItemGroupItemsLoaded).copyWith(
//         paginationError: ItemGroupItemsError(e, stack),
//       ));

//       return false;
//     }
//   }

//   Future<void> getItems() async {
//     state = const AsyncLoading();
//     await _getItems();
//   }

//   Future<void> _getItems() async {
//     try {
//       final warehouseId = ref.watch(localLocationInfoProvider).warehouseId;
//       final appResponse = await _itemGroupsRepository.getItemsByItemGroup(
//           itemGroupId: _itemGroupId,
//           page: 1,
//           sortBy: _sortBy,
//           sortOrder: _sortOrder,
//           barcode: _barcode,
//           parameters: _params,
//           searchQuery: _searchQuery,
//           warehouseId: warehouseId);
//       state = AsyncData(ItemGroupItemsLoaded(
//         items: appResponse.data.websiteItems,
//         pagination: appResponse.pagination!,
//         paginationError: null,
//       ));
//       if (appResponse.data.isGroup == 1 && _itemGroupId != null) {
//         ref
//             .read(subItemGroupsControllerProvider.notifier)
//             .set(appResponse.data.subCategories);
//       }
//     } catch (e, stack) {
//       state = AsyncError(e, stack);
//     }
//   }

//   Future<bool> onRefresh() async {
//     await _getItems();
//     return true;
//   }

//   Map<String, String>? _setSortValues(String? sortValue) {
//     final sortValuesMap = {
//       S.current.priceHighToLow: {
//         'sortBy': 'website_item_price',
//         'sortOrder': 'desc'
//       },
//       S.current.priceLowToHigh: {
//         'sortBy': 'website_item_price',
//         'sortOrder': 'asc'
//       },
//       S.current.nameZtoA: {'sortBy': 'website_item_name', 'sortOrder': 'desc'},
//     };

//     final sortValues = sortValuesMap[sortValue];
//     return sortValues;
//   }
// }

// abstract class ItemGroupItemsState {
//   const ItemGroupItemsState();
// }

// class ItemGroupItemsInitial extends ItemGroupItemsState {
//   const ItemGroupItemsInitial();
// }

// class ItemGroupItemsLoading extends ItemGroupItemsState {
//   const ItemGroupItemsLoading();
// }

// class ItemGroupItemsLoaded extends ItemGroupItemsState {
//   ItemGroupItemsLoaded({
//     required this.items,
//     required this.pagination,
//     this.paginationError,
//   });

//   final List<Item> items;
//   final Pagination pagination;
//   final ItemGroupItemsError? paginationError;

//   ItemGroupItemsLoaded copyWith({
//     List<Item>? items,
//     Pagination? pagination,
//     ItemGroupItemsError? paginationError,
//   }) {
//     return ItemGroupItemsLoaded(
//       items: items ?? this.items,
//       pagination: pagination ?? this.pagination,
//       paginationError: paginationError ?? this.paginationError,
//     );
//   }
// }

// class ItemGroupItemsError extends ItemGroupItemsState {
//   ItemGroupItemsError(this.error, this.stackTrace);
//   final Object error;
//   final StackTrace stackTrace;
// }

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:widam/src/common_models/response/app_response.dart';
import 'package:widam/src/constants/strings.dart';
import 'package:widam/src/features/addresses/application/local_location_info.dart';
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
import '../../item_groups/domain/item_group/item_group.dart';
import '../domain/item/item.dart';

part 'item_group_items_controller.g.dart';

@riverpod
class ItemGroupItemsController extends _$ItemGroupItemsController {
  @override
  Future<ItemGroupItemsLoaded> build() async {
    // 1. Watch all reactive parameters directly inside build()
    final mainGroupId = ref.watch(selectedItemGroupControllerProvider);
    final subGroupId = ref.watch(selectedSubItemGroupControllerProvider);

    final itemGroupId = subGroupId ??
        (mainGroupId == Strings.allItemGroup ? null : mainGroupId);

    final selectedFilter = ref.watch(selectedFilterControllerProvider);
    final sortValues = _setSortValues(selectedFilter);

    final sortBy = sortValues?['sortBy'];
    final sortOrder = sortValues?['sortOrder'];

    final barcode = ref.watch(barcodeControllerProvider);
    final searchQuery = ref.watch(itemGroupsSearchControllerProvider);
    final params = ref.watch(paramsControllerProvider);
    final warehouseId = ref.watch(localLocationInfoProvider).warehouseId;

    final repository = ref.watch(itemGroupsRepositoryProvider);

    // 2. Fetch page 1 for the selected category/filters
    final AppResponse<ItemGroupDetails> appResponse =
        await repository.getItemsByItemGroup(
      itemGroupId: itemGroupId,
      page: 1,
      sortBy: sortBy,
      sortOrder: sortOrder,
      barcode: barcode,
      parameters: params,
      searchQuery: searchQuery,
      warehouseId: warehouseId,
    );

    // 3. Update sub-item groups safely outside the build phase
    if (subGroupId == null) {
      final List<ItemGroup> newSubCategories = (appResponse.data.isGroup == 1)
          ? appResponse.data.subCategories
          : <ItemGroup>[];

      Future.microtask(() {
        ref
            .read(subItemGroupsControllerProvider.notifier)
            .set(newSubCategories);
      });
    }

    return ItemGroupItemsLoaded(
      items: appResponse.data.websiteItems,
      pagination: appResponse.pagination ??
          const Pagination(
            currentPage: 1,
            totalPages: 1,
            totalItems: 0,
          ),
      paginationError: null,
    );
  }

  /// Handle pagination (Page 2, 3, etc.)
  Future<bool> onLoading(int page) async {
    final currentState = state.valueOrNull;
    if (currentState == null || page > currentState.pagination.totalPages) {
      return false;
    }

    try {
      final mainGroupId = ref.read(selectedItemGroupControllerProvider);
      final subGroupId = ref.read(selectedSubItemGroupControllerProvider);
      final itemGroupId = subGroupId ??
          (mainGroupId == Strings.allItemGroup ? null : mainGroupId);

      final selectedFilter = ref.read(selectedFilterControllerProvider);
      final sortValues = _setSortValues(selectedFilter);

      final sortBy = sortValues?['sortBy'];
      final sortOrder = sortValues?['sortOrder'];
      final barcode = ref.read(barcodeControllerProvider);
      final searchQuery = ref.read(itemGroupsSearchControllerProvider);
      final params = ref.read(paramsControllerProvider);
      final warehouseId = ref.read(localLocationInfoProvider).warehouseId;

      final AppResponse<ItemGroupDetails> appResponse =
          await ref.read(itemGroupsRepositoryProvider).getItemsByItemGroup(
                itemGroupId: itemGroupId,
                page: page,
                sortBy: sortBy,
                sortOrder: sortOrder,
                barcode: barcode,
                searchQuery: searchQuery,
                parameters: params,
                warehouseId: warehouseId,
              );

      state = AsyncData(currentState.copyWith(
        items: [...currentState.items, ...appResponse.data.websiteItems],
        pagination: appResponse.pagination ?? currentState.pagination,
        paginationError: null,
      ));

      return true;
    } catch (e, stack) {
      state = AsyncData(currentState.copyWith(
        paginationError: ItemGroupItemsError(e, stack),
      ));
      return false;
    }
  }

  Future<bool> onRefresh() async {
    ref.invalidateSelf();
    await future;
    return true;
  }

  Map<String, String>? _setSortValues(FilterType? filter) {
    switch (filter) {
      case FilterType.priceHighToLow:
        return {
          'sortBy': 'website_item_price',
          'sortOrder': 'desc',
        };

      case FilterType.priceLowToHigh:
        return {
          'sortBy': 'website_item_price',
          'sortOrder': 'asc',
        };

      case FilterType.nameZtoA:
        return {
          'sortBy': 'website_item_name',
          'sortOrder': 'desc',
        };

      case FilterType.nameAtoZ:
      case null:
        return null;
    }
  }
}

class ItemGroupItemsLoaded {
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

class ItemGroupItemsError {
  ItemGroupItemsError(this.error, this.stackTrace);
  final Object error;
  final StackTrace stackTrace;
}
