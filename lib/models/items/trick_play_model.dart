import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'trick_play_model.freezed.dart';
part 'trick_play_model.g.dart';

@freezed
class TrickPlayModel with _$TrickPlayModel {
  factory TrickPlayModel({
    required int width,
    required int height,
    required int tileWidth,
    required int tileHeight,
    required int thumbnailCount,
    required Duration interval,
    @Default([]) List<String> images,
  }) = _TrickPlayModel;

  const TrickPlayModel._();

  int get imagesPerTile => tileWidth * tileHeight;

  String? getTile(Duration position) {
    final int currentIndex = (position.inMilliseconds ~/ interval.inMilliseconds).clamp(0, thumbnailCount);
    final int indexOfTile = (currentIndex ~/ imagesPerTile).clamp(0, images.length);
    return images.elementAtOrNull(indexOfTile);
  }

  Offset offset(Duration position) {
    final int currentIndex = (position.inMilliseconds ~/ interval.inMilliseconds).clamp(0, thumbnailCount - 1);
    final int tileIndex = currentIndex % imagesPerTile;
    final int column = tileIndex % tileWidth;
    final int row = tileIndex ~/ tileWidth;
    return Offset(
      (width * column).toDouble(),
      (height * row).toDouble(),
    );
  }

  static Map<String, TrickPlayModel> toTrickPlayMap(Map<String, dynamic> map) {
    Map<String, TrickPlayModel> newMap = {};
    final firstMap = (((map.entries.first as MapEntry).value as Map<String, dynamic>));
    newMap.addEntries(firstMap.entries.map(
      (e) {
        final map = e.value as Map<String, dynamic>;
        return MapEntry(
          e.key,
          TrickPlayModel(
            width: map['Width'] as int? ?? 0,
            height: map['Height'] as int? ?? 0,
            tileWidth: map['TileWidth'] as int? ?? 0,
            tileHeight: map['TileHeight'] as int? ?? 0,
            thumbnailCount: map['ThumbnailCount'] as int? ?? 0,
            interval: Duration(milliseconds: map['Interval'] as int? ?? 0),
          ),
        );
      },
    ));
    return newMap;
  }

  factory TrickPlayModel.fromJson(Map<String, dynamic> json) => _$TrickPlayModelFromJson(json);
}
