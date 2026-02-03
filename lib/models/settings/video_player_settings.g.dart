// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_player_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoPlayerSettingsModel _$VideoPlayerSettingsModelFromJson(
        Map<String, dynamic> json) =>
    _VideoPlayerSettingsModel(
      screenBrightness: (json['screenBrightness'] as num?)?.toDouble(),
      videoFit: $enumDecodeNullable(_$BoxFitEnumMap, json['videoFit']) ??
          BoxFit.contain,
      fillScreen: json['fillScreen'] as bool? ?? false,
      hardwareAccel: json['hardwareAccel'] as bool? ?? true,
      useLibass: json['useLibass'] as bool? ?? false,
      enableTunneling: json['enableTunneling'] as bool? ?? false,
      bufferSize: (json['bufferSize'] as num?)?.toInt() ?? 32,
      playerOptions:
          $enumDecodeNullable(_$PlayerOptionsEnumMap, json['playerOptions']),
      internalVolume: (json['internalVolume'] as num?)?.toDouble() ?? 100,
      allowedOrientations: (json['allowedOrientations'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$DeviceOrientationEnumMap, e))
          .toSet(),
      nextVideoType:
          $enumDecodeNullable(_$AutoNextTypeEnumMap, json['nextVideoType']) ??
              AutoNextType.smart,
      maxHomeBitrate:
          $enumDecodeNullable(_$BitrateEnumMap, json['maxHomeBitrate']) ??
              Bitrate.original,
      maxInternetBitrate:
          $enumDecodeNullable(_$BitrateEnumMap, json['maxInternetBitrate']) ??
              Bitrate.original,
      audioDevice: json['audioDevice'] as String?,
      segmentSkipSettings:
          (json['segmentSkipSettings'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry($enumDecode(_$MediaSegmentTypeEnumMap, k),
                    $enumDecode(_$SegmentSkipEnumMap, e)),
              ) ??
              defaultSegmentSkipValues,
      hotKeys: (json['hotKeys'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$VideoHotKeysEnumMap, k),
                KeyCombination.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      screensaver:
          $enumDecodeNullable(_$ScreensaverEnumMap, json['screensaver']) ??
              Screensaver.logo,
      enableSpeedBoost: json['enableSpeedBoost'] as bool? ?? false,
      speedBoostRate: (json['speedBoostRate'] as num?)?.toDouble() ?? 2.0,
      enableDoubleTapSeek: json['enableDoubleTapSeek'] as bool? ?? true,
    );

Map<String, dynamic> _$VideoPlayerSettingsModelToJson(
        _VideoPlayerSettingsModel instance) =>
    <String, dynamic>{
      'screenBrightness': instance.screenBrightness,
      'videoFit': _$BoxFitEnumMap[instance.videoFit]!,
      'fillScreen': instance.fillScreen,
      'hardwareAccel': instance.hardwareAccel,
      'useLibass': instance.useLibass,
      'enableTunneling': instance.enableTunneling,
      'bufferSize': instance.bufferSize,
      'playerOptions': _$PlayerOptionsEnumMap[instance.playerOptions],
      'internalVolume': instance.internalVolume,
      'allowedOrientations': instance.allowedOrientations
          ?.map((e) => _$DeviceOrientationEnumMap[e]!)
          .toList(),
      'nextVideoType': _$AutoNextTypeEnumMap[instance.nextVideoType]!,
      'maxHomeBitrate': _$BitrateEnumMap[instance.maxHomeBitrate]!,
      'maxInternetBitrate': _$BitrateEnumMap[instance.maxInternetBitrate]!,
      'audioDevice': instance.audioDevice,
      'segmentSkipSettings': instance.segmentSkipSettings.map((k, e) =>
          MapEntry(_$MediaSegmentTypeEnumMap[k]!, _$SegmentSkipEnumMap[e]!)),
      'hotKeys': instance.hotKeys
          .map((k, e) => MapEntry(_$VideoHotKeysEnumMap[k]!, e)),
      'screensaver': _$ScreensaverEnumMap[instance.screensaver]!,
      'enableSpeedBoost': instance.enableSpeedBoost,
      'speedBoostRate': instance.speedBoostRate,
      'enableDoubleTapSeek': instance.enableDoubleTapSeek,
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

const _$PlayerOptionsEnumMap = {
  PlayerOptions.libMDK: 'libMDK',
  PlayerOptions.libMPV: 'libMPV',
  PlayerOptions.nativePlayer: 'nativePlayer',
};

const _$DeviceOrientationEnumMap = {
  DeviceOrientation.portraitUp: 'portraitUp',
  DeviceOrientation.landscapeLeft: 'landscapeLeft',
  DeviceOrientation.portraitDown: 'portraitDown',
  DeviceOrientation.landscapeRight: 'landscapeRight',
};

const _$AutoNextTypeEnumMap = {
  AutoNextType.off: 'off',
  AutoNextType.smart: 'smart',
  AutoNextType.static: 'static',
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

const _$SegmentSkipEnumMap = {
  SegmentSkip.none: 'none',
  SegmentSkip.askToSkip: 'askToSkip',
  SegmentSkip.skipOnce: 'skipOnce',
  SegmentSkip.skip: 'skip',
};

const _$MediaSegmentTypeEnumMap = {
  MediaSegmentType.unknown: 'unknown',
  MediaSegmentType.commercial: 'commercial',
  MediaSegmentType.preview: 'preview',
  MediaSegmentType.recap: 'recap',
  MediaSegmentType.outro: 'outro',
  MediaSegmentType.intro: 'intro',
};

const _$VideoHotKeysEnumMap = {
  VideoHotKeys.playPause: 'playPause',
  VideoHotKeys.seekForward: 'seekForward',
  VideoHotKeys.seekBack: 'seekBack',
  VideoHotKeys.mute: 'mute',
  VideoHotKeys.volumeUp: 'volumeUp',
  VideoHotKeys.volumeDown: 'volumeDown',
  VideoHotKeys.speedUp: 'speedUp',
  VideoHotKeys.speedDown: 'speedDown',
  VideoHotKeys.nextVideo: 'nextVideo',
  VideoHotKeys.prevVideo: 'prevVideo',
  VideoHotKeys.nextChapter: 'nextChapter',
  VideoHotKeys.prevChapter: 'prevChapter',
  VideoHotKeys.fullScreen: 'fullScreen',
  VideoHotKeys.skipMediaSegment: 'skipMediaSegment',
  VideoHotKeys.takeScreenshot: 'takeScreenshot',
  VideoHotKeys.takeScreenshotClean: 'takeScreenshotClean',
  VideoHotKeys.exit: 'exit',
};

const _$ScreensaverEnumMap = {
  Screensaver.disabled: 'disabled',
  Screensaver.dvd: 'dvd',
  Screensaver.logo: 'logo',
  Screensaver.time: 'time',
  Screensaver.black: 'black',
};
