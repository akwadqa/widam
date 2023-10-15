class Block<T> {
  Block(
      {required this.blockId,
      required this.blockType,
      required this.title,
      required this.background,
      required this.icon,
      required this.viewType,
      required this.itemGroupBackground,
      required this.data,
      required this.isDynamic,
      required this.fillingToShow,
      required this.showTitle,
      required this.showTitleBlock,
      required this.attributionToken});

  final String blockId;
  final String blockType;
  final String? title;
  final String background;
  final String? icon;
  final String? viewType;
  final String? itemGroupBackground;
  final T data;
  final int isDynamic;
  final String? fillingToShow;
  final int showTitle;
  final int showTitleBlock;
  final String? attributionToken;

  factory Block.fromJson(Map<String, dynamic> json, Function(dynamic) create) {
    return Block(
      showTitle: json['show_title'],
      showTitleBlock: json['show_title_block'],
      blockId: json['block_id'],
      blockType: json['block_type'],
      title: json['title'],
      background: json['background'],
      icon: json['icon'],
      viewType: json['view_type'],
      itemGroupBackground: json['item_group_background'],
      data: json['data'] != null ? create(json['data']) : null,
      isDynamic: json['is_dynamic'],
      fillingToShow: json['filling_to_show'],
      attributionToken: json['attribution_token'],
    );
  }
}
