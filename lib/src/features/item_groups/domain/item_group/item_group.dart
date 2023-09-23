class ItemGroup {
  final String itemGroupId;
  final String itemGroupName;
  final String itemGroupImage;
  final List<ItemGroup>? subItemGroups;

  ItemGroup(
      {required this.itemGroupId,
      required this.itemGroupName,
      required this.itemGroupImage,
      required this.subItemGroups});

  factory ItemGroup.fromJson(Map<String, dynamic> json) {
    return ItemGroup(
      itemGroupId: json['item_group_id'],
      itemGroupName: json['item_group_name'],
      itemGroupImage: json['item_group_image'],
      subItemGroups: json['sub_categories'] != null
          ? (json['sub_categories'] as List)
              .map((e) => ItemGroup.fromJson(e))
              .toList()
          : null,
    );
  }
}
