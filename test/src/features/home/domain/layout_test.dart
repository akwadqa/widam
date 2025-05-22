import 'package:flutter_test/flutter_test.dart';
import 'package:widam/src/features/layouts/domain/banner/banner.dart';
import 'package:widam/src/features/layouts/domain/block.dart';
import 'package:widam/src/features/layouts/domain/basic_item_group/basic_item_group.dart';
import 'package:widam/src/features/layouts/domain/layout.dart';
import 'package:widam/src/features/layouts/domain/layout_data/layout_data.dart';
import 'package:widam/src/features/items/domain/item/item.dart';

void main() {
  test('fromJsonToBlock returns a Block<Banner> object based on the JSON input', () {
    const blockJson = {
      "block_id": "BLOCK-0021",
      "block_type": "Banner",
      "background": "#e37d7d",
      "title": "Banner",
      "icon": null,
      "data": [
        {
          "banner_type": "Website Item",
          "banner_link": "WI-00027",
          "banner_image": "/files/7c8dacd0-e6d1-455e-944a-d426eb3730bf.jpg",
          "website_item_name": "Beef Meat"
        }
      ],
      "is_dynamic": 0
    };

    final expectedBlock = Block<List<Banner>>.fromJson(blockJson,
            (data) => List<Banner>.from(data.map((x) => Banner.fromJson(x)))
    );
    final actualBlock = Layout.fromJsonToBlock(blockJson);

    expect(actualBlock.blockId, expectedBlock.blockId);
    expect(actualBlock.blockType, expectedBlock.blockType);
    expect(actualBlock.background, expectedBlock.background);
    expect(actualBlock.icon, expectedBlock.icon);
    expect((actualBlock.data as List<Banner>).length, expectedBlock.data.length);
    expect(actualBlock.isDynamic, expectedBlock.isDynamic);
  });

  test('fromJsonToBlock returns a Block<ItemGroup> object based on the JSON input', () {
    const blockJson = {
      "block_id": "BLOCK-0020",
      "block_type": "Item Group",
      "title": "Fresh Categories",
      "background": "#bd8a8a",
      "icon": null,
      "data": [
        {
          "item_group_id": "Fresh Fruit",
          "item_group_name": "Fresh Fruit",
          "item_group_image": "/files/WhatsApp Image 2023-03-05 at 15.48.18.jpg"
        },
        {
          "item_group_id": "Chicken",
          "item_group_name": "Chicken ",
          "item_group_image": "/files/R (1).jpeg"
        },
        {
          "item_group_id": "Rice",
          "item_group_name": "Rice",
          "item_group_image": "/files/1 rise.png"
        },
        {
          "item_group_id": "Dairy Products",
          "item_group_name": "Dairy Products",
          "item_group_image": "/files/R (4).png"
        },
        {
          "item_group_id": "Chips & Dips",
          "item_group_name": "Chips & Dips",
          "item_group_image": "/files/R (3).png"
        },
        {
          "item_group_id": "Fruits & Vegetables",
          "item_group_name": "Fruits & Vegetables",
          "item_group_image": "/files/Vegetables.png"
        }
      ],
      "is_dynamic": 0
    };

    final expectedBlock = Block<List<BasicItemGroup>>.fromJson(blockJson,
            (data) => List<BasicItemGroup>.from(data.map((x) => BasicItemGroup.fromJson(x)))
    );
    final actualBlock = Layout.fromJsonToBlock(blockJson);

    expect(actualBlock.blockId, expectedBlock.blockId);
    expect(actualBlock.blockType, expectedBlock.blockType);
    expect(actualBlock.background, expectedBlock.background);
    expect(actualBlock.icon, expectedBlock.icon);
    expect((actualBlock.data as List<BasicItemGroup>).length, expectedBlock.data.length);
    expect(actualBlock.isDynamic, expectedBlock.isDynamic);
  });

  test('fromJsonToBlock returns a Block<LayoutData> object based on the JSON input', () {
    const blockJson = {
      "block_id": "BLOCK-0010",
      "block_type": "Layout",
      "title": "Go To Products Layout",
      "background": "#703d3d",
      "icon": "/files/Image English.jpg",
      "data": {
        "layout_id": "LAYOUT-0002",
        "layout_title": "Products Layout",
      },
      "is_dynamic": 0
    };

    final expectedBlock = Block<LayoutData>.fromJson(blockJson,
            (data) => LayoutData.fromJson(data)
    );
    final actualBlock = Layout.fromJsonToBlock(blockJson);

    expect(actualBlock.blockId, expectedBlock.blockId);
    expect(actualBlock.blockType, expectedBlock.blockType);
    expect(actualBlock.background, expectedBlock.background);
    expect(actualBlock.icon, expectedBlock.icon);
    expect(actualBlock.isDynamic, expectedBlock.isDynamic);
  });

  test('fromJsonToBlock returns a Block<Item> object based on the JSON input', () {
    const blockJson = {
      "block_id": "BLOCK-0019",
      "block_type": "Item",
      "title": "Deals of the Day",
      "background": "#a67272",
      "icon": null,
      "data": [
        {
          "website_item_id": "WI-00013",
          "website_item_name": "Fresh Arabic Lamb",
          "website_item_image": "/files/WhatsApp Image 2023-03-04 at 3.03.49 PM.jpeg",
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
          "website_item_image": "/files/ec939b28-7f1c-4d18-a0b2-e1dcaba29b0f.jpg",
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
          "website_item_image": "/files/1.png",
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
          "website_item_image": "/files/WhatsApp Image 2023-03-05 at 13.34.06.jpg",
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
    };

    final expectedBlock = Block<List<Item>>.fromJson(blockJson,
            (data) => List<Item>.from(data.map((x) => Item.fromJson(x)))
    );
    final actualBlock = Layout.fromJsonToBlock(blockJson);

    expect(actualBlock.blockId, expectedBlock.blockId);
    expect(actualBlock.blockType, expectedBlock.blockType);
    expect(actualBlock.background, expectedBlock.background);
    expect(actualBlock.icon, expectedBlock.icon);
    expect((actualBlock.data as List<Item>).length, expectedBlock.data.length);
    expect(actualBlock.isDynamic, expectedBlock.isDynamic);
  });

  test('fromJsonToBlock returns a Block object based on the JSON input when is_dynamic = 1', () {
    const blockJson = {
      "block_id": "BLOCK-0013",
      "title": "Item - Best Sellers",
      "block_type": "Item",
      "background": "#c45454",
      "icon": "/files/Image English.jpg",
      "is_dynamic": 1
    };

    final expectedBlock = Block.fromJson(blockJson,
            (data) => data
    );
    final actualBlock = Layout.fromJsonToBlock(blockJson);

    expect(actualBlock.blockId, expectedBlock.blockId);
    expect(actualBlock.blockType, expectedBlock.blockType);
    expect(actualBlock.background, expectedBlock.background);
    expect(actualBlock.icon, expectedBlock.icon);
    expect(actualBlock.isDynamic, expectedBlock.isDynamic);
  });
}
