// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trick_play_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrickPlayModel _$TrickPlayModelFromJson(Map<String, dynamic> json) =>
    _TrickPlayModel(
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      tileWidth: (json['tileWidth'] as num).toInt(),
      tileHeight: (json['tileHeight'] as num).toInt(),
      thumbnailCount: (json['thumbnailCount'] as num).toInt(),
      interval: Duration(microseconds: (json['interval'] as num).toInt()),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TrickPlayModelToJson(_TrickPlayModel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'tileWidth': instance.tileWidth,
      'tileHeight': instance.tileHeight,
      'thumbnailCount': instance.thumbnailCount,
      'interval': instance.interval.inMicroseconds,
      'images': instance.images,
    };
