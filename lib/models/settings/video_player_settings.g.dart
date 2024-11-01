// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_player_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoPlayerSettingsModelImpl _$$VideoPlayerSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VideoPlayerSettingsModelImpl(
      screenBrightness: (json['screenBrightness'] as num?)?.toDouble(),
      videoFit: $enumDecodeNullable(_$BoxFitEnumMap, json['videoFit']) ??
          BoxFit.contain,
      fillScreen: json['fillScreen'] as bool? ?? false,
      hardwareAccel: json['hardwareAccel'] as bool? ?? true,
      useLibass: json['useLibass'] as bool? ?? false,
      internalVolume: (json['internalVolume'] as num?)?.toDouble() ?? 100,
      nextVideoType:
          $enumDecodeNullable(_$AutoNextTypeEnumMap, json['nextVideoType']) ??
              AutoNextType.static,
      audioDevice: json['audioDevice'] as String?,
    );

Map<String, dynamic> _$$VideoPlayerSettingsModelImplToJson(
        _$VideoPlayerSettingsModelImpl instance) =>
    <String, dynamic>{
      'screenBrightness': instance.screenBrightness,
      'videoFit': _$BoxFitEnumMap[instance.videoFit]!,
      'fillScreen': instance.fillScreen,
      'hardwareAccel': instance.hardwareAccel,
      'useLibass': instance.useLibass,
      'internalVolume': instance.internalVolume,
      'nextVideoType': _$AutoNextTypeEnumMap[instance.nextVideoType]!,
      'audioDevice': instance.audioDevice,
    };

const _$BoxFitEnumMap = {
  BoxFit.fill: 'fill',
  BoxFit.contain: 'contain',
  BoxFit.cover: 'cover',
  BoxFit.fitWidth: 'fitWidth',
  BoxFit.fitHeight: 'fitHeight',
  BoxFit.none: 'none',
  BoxFit.scaleDown: 'scaleDown',
};

const _$AutoNextTypeEnumMap = {
  AutoNextType.off: 'off',
  AutoNextType.smart: 'smart',
  AutoNextType.static: 'static',
};
