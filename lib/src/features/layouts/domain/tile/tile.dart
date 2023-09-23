import 'package:freezed_annotation/freezed_annotation.dart';
import '../block_data.dart';

part 'tile.freezed.dart';
part 'tile.g.dart';

@freezed
class Tile with _$Tile implements BlockData {
  const factory Tile({
    required String tileType,
    required String tileLink,
    required String tileImage,
    required String? parameters,
  }) = _Tile;

  factory Tile.fromJson(Map<String, dynamic> json) => _$TileFromJson(json);
}
