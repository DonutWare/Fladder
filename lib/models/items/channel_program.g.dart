// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChannelProgram _$ChannelProgramFromJson(Map<String, dynamic> json) =>
    _ChannelProgram(
      id: json['id'] as String,
      channelId: json['channelId'] as String,
      name: json['name'] as String,
      officialRating: json['officialRating'] as String,
      productionYear: (json['productionYear'] as num).toInt(),
      indexNumber: (json['indexNumber'] as num).toInt(),
      parentIndexNumber: (json['parentIndexNumber'] as num).toInt(),
      episodeTitle: json['episodeTitle'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      images: json['images'] == null
          ? null
          : ImagesData.fromJson(json['images'] as String),
      isSeries: json['isSeries'] as bool,
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$ChannelProgramToJson(_ChannelProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelId': instance.channelId,
      'name': instance.name,
      'officialRating': instance.officialRating,
      'productionYear': instance.productionYear,
      'indexNumber': instance.indexNumber,
      'parentIndexNumber': instance.parentIndexNumber,
      'episodeTitle': instance.episodeTitle,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'images': instance.images,
      'isSeries': instance.isSeries,
      'overview': instance.overview,
    };
