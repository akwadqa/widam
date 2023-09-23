import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:widam/src/features/layouts/data/layouts_repository.dart';
import 'package:widam/src/features/layouts/domain/layout.dart';
import 'package:widam/src/network/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {
  @override
  Future<Response> get(String url, {dynamic data, Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    return Response(data: _kSuccessResponse, statusCode: 200, requestOptions: RequestOptions());
  }
}

void main() {
  const layoutId = 'LAYOUT-0001';

  late ProviderContainer providerContainer;
  late LayoutsRepository repository;

  setUp(() {
    final mockNetworkService = MockNetworkService();
    providerContainer = ProviderContainer(
      overrides: [
        layoutsRepositoryProvider.overrideWithValue(
          LayoutsRepository(mockNetworkService),
        ),
      ],
    );
    repository = providerContainer.read(layoutsRepositoryProvider);
  });

  test('should call Layout API and return a layout', () async {
    // Act
    final result = await repository.getLayout(layoutId: layoutId);

    // Assert
    expect(result, isA<Layout>());
  });
}

const _kSuccessResponse = {
  "status_code": 200,
  "error": 0,
  "message": "layout Detail get Successfully",
  "data": {
    "layout_id": "LAYOUT-0001",
    "layout_title": "Home Layout",
    "published": 1,
    "data": [
      {
        "block_id": "BLOCK-0021",
        "block_type": "Banner",
        "background": "#dea2a2",
        "icon": null,
        "data": [
          {
            "banner_type": "Website Item",
            "banner_link": "WI-00027",
            "banner_image": "https://widam.akwad.qa/files/7c8dacd0-e6d1-455e-944a-d426eb3730bf.jpg",
            "website_item_name": "Beef Meat"
          }
        ],
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0020",
        "block_type": "Item Group",
        "title": "Fresh Categories",
        "background": "#9c5f5f",
        "icon": null,
        "view_type": "Square",
        "data": [
          {
            "item_group_id": "Fresh Fruit",
            "item_group_name": "Fresh Fruit",
            "item_group_image": "https://widam.akwad.qa/files/WhatsApp Image 2023-03-05 at 15.48.18.jpg",
            "item_group_view_type": "Grid Circle"
          },
          {
            "item_group_id": "Chicken",
            "item_group_name": "Chicken ",
            "item_group_image": "https://widam.akwad.qa/files/R (1).jpeg",
            "item_group_view_type": "Grid Circle"
          },
          {
            "item_group_id": "Rice",
            "item_group_name": "Rice",
            "item_group_image": "https://widam.akwad.qa/files/1 rise.png",
            "item_group_view_type": "Grid Circle"
          },
          {
            "item_group_id": "Dairy Products",
            "item_group_name": "Dairy Products",
            "item_group_image": "https://widam.akwad.qa/files/R (4).png",
            "item_group_view_type": "Grid Circle"
          },
          {
            "item_group_id": "Chips & Dips",
            "item_group_name": "Chips & Dips",
            "item_group_image": "https://widam.akwad.qa/files/R (3).png",
            "item_group_view_type": "Grid Circle"
          },
          {
            "item_group_id": "Fruits & Vegetables",
            "item_group_name": "Fruits & Vegetables",
            "item_group_image": "https://widam.akwad.qa/files/Vegetables.png",
            "item_group_view_type": "Grid Circle"
          }
        ],
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0010",
        "block_type": "Layout",
        "title": "Go To Products Layout",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "data": {
          "layout_id": "LAYOUT-0002",
          "layout_title": "Products Layout"
        },
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0012",
        "block_type": "Tile",
        "title": "Layout Tiles",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "tile_view": "Tile",
        "data": [
          {
            "tile_id": "BLOCK-0013",
            "tile_title": "Item - Best Sellers"
          },
          {
            "tile_id": "BLOCK-0015",
            "tile_title": "Item - Newest"
          },
          {
            "tile_id": "BLOCK-0013",
            "tile_title": "Item - Best Sellers"
          },
          {
            "tile_id": "BLOCK-0013",
            "tile_title": "Item - Best Sellers"
          }
        ],
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0019",
        "block_type": "Item",
        "title": "Deals of the Day",
        "background": "#9c5f5f",
        "icon": null,
        "data": [
          {
            "website_item_id": "WI-00013",
            "website_item_name": "Fresh Arabic Lamb",
            "website_item_image": "https://widam.akwad.qa/files/WhatsApp Image 2023-03-04 at 3.03.49 PM.jpeg",
            "view_type": "List Horizontal",
            "price": {
              "website_item_price": 60.0,
              "discount_title": "None",
              "discount_percent": 0.0,
              "discount_amount": 0.0,
              "discounted_price": 60.0,
              "currency": "QAR"
            },
            "in_stock": 1
          },
          {
            "website_item_id": "WI-00016",
            "website_item_name": "Chicken",
            "website_item_image": "https://widam.akwad.qa/files/ec939b28-7f1c-4d18-a0b2-e1dcaba29b0f.jpg",
            "view_type": "List Horizontal",
            "price": {
              "website_item_price": 50.0,
              "discount_title": "20 %",
              "discount_percent": 20.0,
              "discount_amount": 10.0,
              "discounted_price": 40.0,
              "currency": "QAR"
            },
            "in_stock": 1
          },
          {
            "website_item_id": "WI-00014",
            "website_item_name": "Goat Meat Whole",
            "website_item_image": "https://widam.akwad.qa/files/1.png",
            "view_type": "List Horizontal",
            "price": {
              "website_item_price": 200.0,
              "discount_title": "None",
              "discount_percent": 0.0,
              "discount_amount": 0.0,
              "discounted_price": 200.0,
              "currency": "QAR"
            },
            "in_stock": 1
          },
          {
            "website_item_id": "WI-00018",
            "website_item_name": "Tomato Premium Import",
            "website_item_image": "https://widam.akwad.qa/files/WhatsApp Image 2023-03-05 at 13.34.06.jpg",
            "view_type": "List Horizontal",
            "price": {
              "website_item_price": 9.0,
              "discount_title": "None",
              "discount_percent": 0.0,
              "discount_amount": 0.0,
              "discounted_price": 9.0,
              "currency": "QAR"
            },
            "in_stock": 1
          }
        ],
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0004",
        "block_type": "Item",
        "title": "Item with 20% Discount",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "data": [],
        "is_dynamic": 0
      },
      {
        "block_id": "BLOCK-0007",
        "title": "Item - On Sale",
        "block_type": "Item",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "view_type": "Square",
        "is_dynamic": 1
      },
      {
        "block_id": "BLOCK-0013",
        "title": "Item - Best Sellers",
        "block_type": "Item",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "view_type": "Square",
        "is_dynamic": 1
      },
      {
        "block_id": "BLOCK-0014",
        "title": "Item - Popularity",
        "block_type": "Item",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "view_type": "Square",
        "is_dynamic": 1
      },
      {
        "block_id": "BLOCK-0015",
        "title": "Item - Newest",
        "block_type": "Item",
        "background": "#9c5f5f",
        "icon": "https://widam.akwad.qa/files/Image English.jpg",
        "view_type": "Square",
        "is_dynamic": 1
      }
    ]
  }
};

