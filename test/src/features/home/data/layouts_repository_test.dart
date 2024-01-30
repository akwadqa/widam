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
        "layout_title": "Home Page",
        "published": 1,
        "data": [
            {
                "block_id": "BLOCK-0043",
                "block_type": "Banner",
                "show_title": 1,
                "show_title_block": 1,
                "background": "#ffffff",
                "icon": null,
                "data": [
                    {
                        "banner_type": "Item Group",
                        "banner_link": "IG019",
                        "banner_image": "https://widam.akwad.qa/files/Artboard 4 copy 5.png",
                        "item_group_name": "Marinated"
                    },
                    {
                        "banner_type": "Item Group",
                        "banner_link": "IG005",
                        "banner_image": "https://widam.akwad.qa/files/Beef in englsih.png",
                        "item_group_name": "Local Beef"
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0040",
                "block_type": "Item Group",
                "title": "Featured Category",
                "show_title": 0,
                "show_title_block": 0,
                "background": "#ffffff",
                "item_group_background": "#FFFFFF",
                "icon": "https://widam.akwad.qa/files/Artboard 1 copy 10.png",
                "view_type": "Square",
                "data": [
                    {
                        "item_group_id": "Local Slaughter",
                        "item_group_name": "Local Slaughter",
                        "item_group_image": "https://widam.akwad.qa/files/local slaugher.gif",
                        "parameters": null
                    },
                    {
                        "item_group_id": "Local Product",
                        "item_group_name": "Local Product",
                        "item_group_image": "https://widam.akwad.qa/files/Qatar products.gif",
                        "parameters": null
                    },
                    {
                        "item_group_id": "NAT Chicken",
                        "item_group_name": "NAT Chicken",
                        "item_group_image": "https://widam.akwad.qa/files/Na chicken.gif",
                        "parameters": null
                    },
                    {
                        "item_group_id": "Popular Week",
                        "item_group_name": "Popular Week",
                        "item_group_image": "https://widam.akwad.qa/files/Popular this week.gif",
                        "parameters": null
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0002",
                "block_type": "Item Group",
                "title": "Categories",
                "show_title": 0,
                "show_title_block": 1,
                "background": "#fafafa",
                "item_group_background": "#d7eff5",
                "icon": "https://widam.akwad.qa/files/Fresh Categories Title.png",
                "view_type": "Square",
                "data": [
                    {
                        "item_group_id": "IG018",
                        "item_group_name": "Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Lamb.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG001",
                        "item_group_name": "Beef",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG011",
                        "item_group_name": "Chicken",
                        "item_group_image": "https://widam.akwad.qa/files/chicken 33.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG019",
                        "item_group_name": "Marinated",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Marinated2.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG020",
                        "item_group_name": "Offal",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Offal May be.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG017",
                        "item_group_name": "Fruit & Vegetable",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Fruits and Vegetables 1.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG009",
                        "item_group_name": "Bread & Bakery",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Bread and Bakery.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG013",
                        "item_group_name": "Coffee, Tea & Sugar",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Coffee_Now.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG014",
                        "item_group_name": "Cooking Items",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Cooking Items1_Now.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG015",
                        "item_group_name": "Dairy",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Dairy.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG016",
                        "item_group_name": "Frozen Food",
                        "item_group_image": "https://widam.akwad.qa/files/Frozen Food4af613.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG010",
                        "item_group_name": "Camel",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Camel.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG021",
                        "item_group_name": "Seasoning & Condiments",
                        "item_group_image": "https://widam.akwad.qa/files/Seasoning and Condiments1.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG014",
                        "item_group_name": "Cooking Items",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Cooking Items1_Now.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "Akika",
                        "item_group_name": "Aqeeqah",
                        "item_group_image": "https://widam.akwad.qa/private/files/aqeeqah.png.jpg",
                        "parameters": null
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0048",
                "block_type": "Item",
                "title": "Recommended For you STATIC",
                "show_title": 1,
                "show_title_block": 0,
                "background": "#ffffff",
                "icon": "https://widam.akwad.qa/files/Recommended FOR YOU - EN.png",
                "is_dynamic": 0,
                "filling_to_show": "",
                "data": [
                    {
                        "is_express_item": 0,
                        "website_item_id": "WI-00706",
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_name": "Fresh Australian Whole Lamb 15Kg",
                        "website_item_short_name": "Beef Head",
                        "website_item_type": "V",
                        "min_qty": 1,
                        "max_qty": 100,
                        "website_item_image": "https://widam.akwad.qa/files/a559af54-0abf-42a4-99cd-070b2fdaaeb7.jpeg",
                        "price": {
                            "website_item_price": 525,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 525,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1
                    },
                    {
                        "is_express_item": 0,
                        "website_item_id": "WI-00893",
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_name": "Fresh Australian Half Lamb 7.5Kg",
                        "website_item_short_name": null,
                        "website_item_type": "V",
                        "min_qty": 1,
                        "max_qty": 100,
                        "website_item_image": "https://widam.akwad.qa/files/b7814574-c529-49f5-9535-3fe3937182bd3f93dd.jpeg",
                        "price": {
                            "website_item_price": 275,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 275,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1
                    },
                    {
                        "is_express_item": 0,
                        "website_item_id": "WI-00953",
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_name": "Fresh Australian Lamb Basket 10 Kg",
                        "website_item_short_name": null,
                        "website_item_type": "V",
                        "min_qty": 1,
                        "max_qty": 10,
                        "website_item_image": "https://widam.akwad.qa/files/LndQ7HwA.png",
                        "price": {
                            "website_item_price": 350,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 350,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1
                    },
                    {
                        "is_express_item": 0,
                        "website_item_id": "WI-00949",
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_name": "Fresh Australian Lamb Basket 5 Kg",
                        "website_item_short_name": null,
                        "website_item_type": "V",
                        "min_qty": 1,
                        "max_qty": 10,
                        "website_item_image": "https://widam.akwad.qa/files/LndQ7HwA.png",
                        "price": {
                            "website_item_price": 175,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 175,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1
                    }
                ]
            },
            {
                "block_id": "BLOCK-0005",
                "block_type": "Item Group",
                "title": "Meat Court",
                "show_title": 1,
                "show_title_block": 1,
                "background": "#ffece0",
                "item_group_background": "#F5866C",
                "icon": "https://widam.akwad.qa/files/MEAT COURT - EN.png",
                "view_type": "Circle",
                "data": [
                    {
                        "item_group_id": "IG043",
                        "item_group_name": "Arabic Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/beef meat ph.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG050",
                        "item_group_name": "Somali Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/somali.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG046",
                        "item_group_name": "Jordanian Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/Jordanian Lamb.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG045",
                        "item_group_name": "Australian Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/Lamb.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG054",
                        "item_group_name": "Tanzanian Lamb",
                        "item_group_image": "https://widam.akwad.qa/files/tanazian.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG005",
                        "item_group_name": "Local Beef",
                        "item_group_image": "https://widam.akwad.qa/files/Local_beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG004",
                        "item_group_name": "Brazilian Beef",
                        "item_group_image": "https://widam.akwad.qa/files/Beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG003",
                        "item_group_name": "Australian Beef",
                        "item_group_image": "https://widam.akwad.qa/files/Australian Beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG002",
                        "item_group_name": "Argentinian Beef",
                        "item_group_image": "https://widam.akwad.qa/files/Argentinian Beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG006",
                        "item_group_name": "Minced Beef",
                        "item_group_image": "https://widam.akwad.qa/files/Mined Beef.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG059",
                        "item_group_name": "Beef Offal",
                        "item_group_image": "https://widam.akwad.qa/files/Offal.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG030",
                        "item_group_name": "Whole Chicken",
                        "item_group_image": "https://widam.akwad.qa/files/Chicken.png",
                        "parameters": null
                    },
                    {
                        "item_group_id": "IG019",
                        "item_group_name": "Marinated",
                        "item_group_image": "https://widam.akwad.qa/files/OK_Marinated2.png",
                        "parameters": null
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0028",
                "block_type": "Item Group",
                "title": "Budgetary Selections",
                "show_title": 1,
                "show_title_block": 1,
                "background": "#ffffff",
                "item_group_background": "#FFFFFF",
                "icon": "https://widam.akwad.qa/files/BUDGETARY SELECTIONS - ENa575c4.png",
                "view_type": "Horizontal Scroll",
                "data": [
                    {
                        "item_group_id": "All Item Groups",
                        "item_group_name": "All Item Groups",
                        "item_group_image": "https://widam.akwad.qa/files/1.png",
                        "parameters": "max_price=5"
                    },
                    {
                        "item_group_id": "All Item Groups",
                        "item_group_name": "All Item Groups",
                        "item_group_image": "https://widam.akwad.qa/files/2.png",
                        "parameters": "max_price=10"
                    },
                    {
                        "item_group_id": "All Item Groups",
                        "item_group_name": "All Item Groups",
                        "item_group_image": "https://widam.akwad.qa/files/3a68872.png",
                        "parameters": "max_price=20"
                    },
                    {
                        "item_group_id": "All Item Groups",
                        "item_group_name": "All Item Groups",
                        "item_group_image": "https://widam.akwad.qa/files/4069920.png",
                        "parameters": "max_price=30"
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0050",
                "block_type": "Mubadara",
                "title": "Mubdarda",
                "show_title": 0,
                "show_title_block": 0,
                "background": "#ECAD4B",
                "icon": null,
                "is_udhiyah": 0,
                "data": [
                    {
                        "website_item_id": "WI-00750",
                        "website_item_name": "Chilled South African Lamb",
                        "website_item_short_name": "Chld RSA Lamb",
                        "website_item_type": "V",
                        "is_default_variant": 1,
                        "min_qty": 1,
                        "max_qty": 100,
                        "stock_uom": "Kilogram",
                        "has_website_variant": 0,
                        "website_item_image": "https://widam.akwad.qa/files/Chilled South African Lamb.png",
                        "item_group": "IG051",
                        "is_express_item": 0,
                        "is_requires_preparation": "1",
                        "price": {
                            "website_item_price": 500,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 500,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1,
                        "is_pickup": 0,
                        "is_mubadara": 1,
                        "is_udhiyah": 0,
                        "mubadara_id": "MBDR-00001"
                    },
                    {
                        "website_item_id": "WI-00734",
                        "website_item_name": "Chilled Australian Lamb",
                        "website_item_short_name": "Chilled AUS Lamb",
                        "website_item_type": "V",
                        "is_default_variant": 1,
                        "min_qty": 1,
                        "max_qty": 100,
                        "stock_uom": "Kilogram",
                        "has_website_variant": 0,
                        "website_item_image": "https://widam.akwad.qa/files/Chilled Australian Lamb _KG.png",
                        "item_group": "IG045",
                        "is_express_item": 0,
                        "is_requires_preparation": "1",
                        "price": {
                            "website_item_price": 29.75,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 29.75,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1,
                        "is_pickup": 0,
                        "is_mubadara": 1,
                        "is_udhiyah": 0,
                        "mubadara_id": "MBDR-00001"
                    },
                    {
                        "website_item_id": "WI-00464",
                        "website_item_name": "Fresh Local Veal Half Carcass",
                        "website_item_short_name": "Fresh Veal Half Carcass",
                        "website_item_type": "V",
                        "is_default_variant": 1,
                        "min_qty": 1,
                        "max_qty": 100,
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_image": "https://widam.akwad.qa/files/Fresh Local Veal Half Carcassa62096.png",
                        "item_group": "IG005",
                        "is_express_item": 0,
                        "is_requires_preparation": "1",
                        "price": {
                            "website_item_price": 875,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 875,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1,
                        "is_pickup": 0,
                        "is_mubadara": 1,
                        "is_udhiyah": 0,
                        "mubadara_id": "MBDR-00001"
                    }
                ],
                "is_dynamic": 0
            },
            {
                "block_id": "BLOCK-0051",
                "block_type": "Mubadara",
                "title": "Mubadara2",
                "show_title": 0,
                "show_title_block": 0,
                "background": "#ffffff",
                "icon": null,
                "is_udhiyah": 0,
                "data": [
                    {
                        "website_item_id": "WI-00893",
                        "website_item_name": "Fresh Australian Half Lamb 7.5Kg",
                        "website_item_short_name": null,
                        "website_item_type": "V",
                        "is_default_variant": 1,
                        "min_qty": 1,
                        "max_qty": 100,
                        "stock_uom": "Piece",
                        "has_website_variant": 0,
                        "website_item_image": "https://widam.akwad.qa/files/b7814574-c529-49f5-9535-3fe3937182bd3f93dd.jpeg",
                        "item_group": "IG045",
                        "is_express_item": 0,
                        "is_requires_preparation": "1",
                        "price": {
                            "website_item_price": 275,
                            "discount_title": null,
                            "discount_percent": 0,
                            "discount_amount": 0,
                            "discounted_price": 275,
                            "currency": "QAR"
                        },
                        "has_product_options": 0,
                        "tags": [],
                        "in_stock": 1,
                        "is_pickup": 0,
                        "is_mubadara": 1,
                        "is_udhiyah": 0,
                        "mubadara_id": "MBDR-00002"
                    }
                ],
                "is_dynamic": 0
            }
        ]
    }
};

