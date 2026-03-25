// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcode_download_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TranscodeDownloadModel _$TranscodeDownloadModelFromJson(
        Map<String, dynamic> json) =>
    _TranscodeDownloadModel(
      enabled: json['enabled'] as bool? ?? false,
      videoCodec: $enumDecode(_$VideoCodecEnumMap, json['videoCodec']),
      audioCodec: $enumDecode(_$AudioCodecEnumMap, json['audioCodec']),
      maxHeight: $enumDecode(_$MaxHeightEnumMap, json['maxHeight']),
      container: $enumDecode(_$VideoContainerEnumMap, json['container']),
      maxBitrate: $enumDecode(_$BitrateEnumMap, json['maxBitrate']),
    );

Map<String, dynamic> _$TranscodeDownloadModelToJson(
        _TranscodeDownloadModel instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'videoCodec': _$VideoCodecEnumMap[instance.videoCodec]!,
      'audioCodec': _$AudioCodecEnumMap[instance.audioCodec]!,
      'maxHeight': _$MaxHeightEnumMap[instance.maxHeight]!,
      'container': _$VideoContainerEnumMap[instance.container]!,
      'maxBitrate': _$BitrateEnumMap[instance.maxBitrate]!,
    };

const _$VideoCodecEnumMap = {
  VideoCodec.h264: 'h264',
  VideoCodec.h265: 'h265',
  VideoCodec.vp9: 'vp9',
  VideoCodec.av1: 'av1',
};

const _$AudioCodecEnumMap = {
  AudioCodec.aac: 'aac',
  AudioCodec.mp3: 'mp3',
  AudioCodec.opus: 'opus',
  AudioCodec.vorbis: 'vorbis',
};

const _$MaxHeightEnumMap = {
  MaxHeight.p480: 'p480',
  MaxHeight.p720: 'p720',
  MaxHeight.p1080: 'p1080',
  MaxHeight.p1440: 'p1440',
  MaxHeight.p2160: 'p2160',
};

const _$VideoContainerEnumMap = {
  VideoContainer.mp4: 'mp4',
  VideoContainer.mkv: 'mkv',
  VideoContainer.webm: 'webm',
};

const _$BitrateEnumMap = {
  Bitrate.original: 'original',
  Bitrate.auto: 'auto',
  Bitrate.b120Mbps: 'b120Mbps',
  Bitrate.b80Mbps: 'b80Mbps',
  Bitrate.b60Mbps: 'b60Mbps',
  Bitrate.b40Mbps: 'b40Mbps',
  Bitrate.b20Mbps: 'b20Mbps',
  Bitrate.b15Mbps: 'b15Mbps',
  Bitrate.b10Mbps: 'b10Mbps',
  Bitrate.b8Mbps: 'b8Mbps',
  Bitrate.b6Mbps: 'b6Mbps',
  Bitrate.b4Mbps: 'b4Mbps',
  Bitrate.b3Mbps: 'b3Mbps',
  Bitrate.b1_5Mbps: 'b1_5Mbps',
  Bitrate.b720Kbps: 'b720Kbps',
  Bitrate.b420Kbps: 'b420Kbps',
};
