import '../../items/domain/item/item.dart';
import 'banner/banner.dart';
import 'basic_item_group/basic_item_group.dart';
import 'block.dart';
import 'layout_data/layout_data.dart';
import 'tile/tile.dart';

class Layout {
  Layout(
      {required this.layoutId,
      required this.layoutTitle,
      required this.published,
      required this.data});

  final String layoutId;
  final String layoutTitle;
  final int published;
  final List<Block> data;

  factory Layout.fromJson(Map<String, dynamic> json) {
    return Layout(
      layoutId: json['layout_id'],
      layoutTitle: json['layout_title'],
      published: json['published'],
      data: json['data'].map<Block>((v) => fromJsonToBlock(v)).toList(),
    );
  }

  static Block fromJsonToBlock(Map<String, dynamic> json) {
    final type = json['block_type'];
    final isDynamic = json['is_dynamic'];
    if (isDynamic == 1) {
      return Block.fromJson(json, (data) => data);
    }
    return switch (type) {
      'Item' || 'Mubadara' => Block<List<Item>>.fromJson(
          json, (data) => List<Item>.from(data.map((x) => Item.fromJson(x)))),
      'Item Group' => Block<List<BasicItemGroup>>.fromJson(
          json,
          (data) => List<BasicItemGroup>.from(
              data.map((x) => BasicItemGroup.fromJson(x)))),
      'Banner' => Block<List<Banner>>.fromJson(json,
          (data) => List<Banner>.from(data.map((x) => Banner.fromJson(x)))),
      'Layout' =>
        Block<LayoutData>.fromJson(json, (data) => LayoutData.fromJson(data)),
      _ => Block<List<Tile>>.fromJson(
          json, (data) => List<Tile>.from(data.map((x) => Tile.fromJson(x))))
    };
  }
}
