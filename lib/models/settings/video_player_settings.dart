import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/localization_helper.dart';

part 'video_player_settings.freezed.dart';
part 'video_player_settings.g.dart';

enum VideoHotKeys {
  playPause,
  seekForward,
  seekBack,
  mute,
  volumeUp,
  volumeDown,
  speedUp,
  speedDown,
  nextVideo,
  prevVideo,
  nextChapter,
  prevChapter,
  fullScreen,
  skipMediaSegment,
  takeScreenshot,
  takeScreenshotClean,
  exit;

  const VideoHotKeys();

  String label(BuildContext context) {
    return switch (this) {
      VideoHotKeys.playPause => context.localized.playPause,
      VideoHotKeys.seekForward => context.localized.seekForward,
      VideoHotKeys.seekBack => context.localized.seekBack,
      VideoHotKeys.mute => context.localized.mute,
      VideoHotKeys.volumeUp => context.localized.volumeUp,
      VideoHotKeys.volumeDown => context.localized.volumeDown,
      VideoHotKeys.speedUp => context.localized.speedUp,
      VideoHotKeys.speedDown => context.localized.speedDown,
      VideoHotKeys.nextVideo => context.localized.nextVideo,
      VideoHotKeys.prevVideo => context.localized.prevVideo,
      VideoHotKeys.nextChapter => context.localized.nextChapter,
      VideoHotKeys.prevChapter => context.localized.prevChapter,
      VideoHotKeys.fullScreen => context.localized.fullScreen,
      VideoHotKeys.skipMediaSegment => context.localized.skipMediaSegment,
      VideoHotKeys.takeScreenshot => context.localized.takeScreenshot,
      VideoHotKeys.takeScreenshotClean => context.localized.takeScreenshotClean,
      VideoHotKeys.exit => context.localized.exit,
    };
  }
}

@Freezed(copyWith: true)
abstract class VideoPlayerSettingsModel with _$VideoPlayerSettingsModel {
  const VideoPlayerSettingsModel._();

  factory VideoPlayerSettingsModel({
    double? screenBrightness,
    @Default(BoxFit.contain) BoxFit videoFit,
    @Default(false) bool fillScreen,
    @Default(true) bool hardwareAccel,
    @Default(false) bool useLibass,
    @Default(false) bool enableTunneling,
    @Default(32) int bufferSize,
    PlayerOptions? playerOptions,
    @Default(100) double internalVolume,
    Set<DeviceOrientation>? allowedOrientations,
    @Default(AutoNextType.smart) AutoNextType nextVideoType,
    @Default(Bitrate.original) Bitrate maxHomeBitrate,
    @Default(Bitrate.original) Bitrate maxInternetBitrate,
    String? audioDevice,
    @Default(defaultSegmentSkipValues) Map<MediaSegmentType, SegmentSkip> segmentSkipSettings,
    @Default({}) Map<VideoHotKeys, KeyCombination> hotKeys,
    @Default(Screensaver.logo) Screensaver screensaver,
    @Default(false) bool enableSpeedBoost,
    @Default(2.0) double speedBoostRate,
  }) = _VideoPlayerSettingsModel;

  double get volume => switch (defaultTargetPlatform) {
        TargetPlatform.android || TargetPlatform.iOS => 100,
        _ => internalVolume,
      };

  factory VideoPlayerSettingsModel.fromJson(Map<String, dynamic> json) => _$VideoPlayerSettingsModelFromJson(json);

  PlayerOptions get wantedPlayer =>
      leanBackMode ? PlayerOptions.nativePlayer : playerOptions ?? PlayerOptions.platformDefaults;

  Map<VideoHotKeys, KeyCombination> get currentShortcuts =>
      _defaultVideoHotKeys.map((key, value) => MapEntry(key, hotKeys[key] ?? value));

  Map<VideoHotKeys, KeyCombination> get defaultShortCuts => _defaultVideoHotKeys;

  bool playerSame(VideoPlayerSettingsModel other) {
    return other.hardwareAccel == hardwareAccel &&
        other.enableTunneling == enableTunneling &&
        other.useLibass == useLibass &&
        other.bufferSize == bufferSize &&
        other.wantedPlayer == wantedPlayer;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoPlayerSettingsModel &&
        other.screenBrightness == screenBrightness &&
        other.videoFit == videoFit &&
        other.fillScreen == fillScreen &&
        other.hardwareAccel == hardwareAccel &&
        other.useLibass == useLibass &&
        other.enableTunneling == enableTunneling &&
        other.bufferSize == bufferSize &&
        other.internalVolume == internalVolume &&
        other.playerOptions == playerOptions &&
        other.audioDevice == audioDevice;
  }

  @override
  int get hashCode {
    return screenBrightness.hashCode ^
        videoFit.hashCode ^
        fillScreen.hashCode ^
        hardwareAccel.hashCode ^
        useLibass.hashCode ^
        enableTunneling.hashCode ^
        bufferSize.hashCode ^
        internalVolume.hashCode ^
        audioDevice.hashCode;
  }
}

enum PlayerOptions {
  libMDK,
  libMPV,
  nativePlayer;

  const PlayerOptions();

  static Iterable<PlayerOptions> get available => leanBackMode
      ? {PlayerOptions.nativePlayer}
      : kIsWeb
          ? {PlayerOptions.libMPV}
          : switch (defaultTargetPlatform) {
              TargetPlatform.android => PlayerOptions.values,
              _ => {PlayerOptions.libMDK, PlayerOptions.libMPV},
            };

  static PlayerOptions get platformDefaults {
    if (leanBackMode) return PlayerOptions.nativePlayer;
    if (kIsWeb) return PlayerOptions.libMPV;
    return switch (defaultTargetPlatform) {
      _ => PlayerOptions.libMPV,
    };
  }

  String label(BuildContext context) => switch (this) {
        PlayerOptions.libMDK => "MDK",
        PlayerOptions.libMPV => "MPV",
        PlayerOptions.nativePlayer => "Native",
      };
}

enum Screensaver {
  disabled,
  dvd,
  logo,
  time,
  black;

  const Screensaver();

  String label(BuildContext context) => switch (this) {
        Screensaver.disabled => context.localized.disabled,
        Screensaver.dvd => context.localized.screensaverDvd,
        Screensaver.logo => context.localized.screensaverLogo,
        Screensaver.time => context.localized.screensaverTime,
        Screensaver.black => context.localized.screensaverBlack,
      };
}

enum AutoNextType {
  off,
  smart,
  static;

  const AutoNextType();

  String label(BuildContext context) => switch (this) {
        AutoNextType.off => context.localized.off,
        AutoNextType.smart => context.localized.autoNextOffSmartTitle,
        AutoNextType.static => context.localized.autoNextOffStaticTitle,
      };

  String desc(BuildContext context) => switch (this) {
        AutoNextType.off => context.localized.off,
        AutoNextType.smart => context.localized.autoNextOffSmartDesc,
        AutoNextType.static => context.localized.autoNextOffStaticDesc,
      };
}

Map<VideoHotKeys, KeyCombination> get _defaultVideoHotKeys => {
      for (var hotKey in VideoHotKeys.values)
        hotKey: switch (hotKey) {
          VideoHotKeys.playPause => KeyCombination(
              key: LogicalKeyboardKey.space,
              altKey: LogicalKeyboardKey.keyK,
            ),
          VideoHotKeys.seekForward => KeyCombination(
              key: LogicalKeyboardKey.arrowRight,
              altKey: LogicalKeyboardKey.keyL,
            ),
          VideoHotKeys.seekBack => KeyCombination(
              key: LogicalKeyboardKey.arrowLeft,
              altKey: LogicalKeyboardKey.keyJ,
            ),
          VideoHotKeys.mute => KeyCombination(key: LogicalKeyboardKey.keyM),
          VideoHotKeys.volumeUp => KeyCombination(key: LogicalKeyboardKey.arrowUp),
          VideoHotKeys.volumeDown => KeyCombination(key: LogicalKeyboardKey.arrowDown),
          VideoHotKeys.speedUp =>
            KeyCombination(key: LogicalKeyboardKey.arrowUp, modifier: LogicalKeyboardKey.controlLeft),
          VideoHotKeys.speedDown =>
            KeyCombination(key: LogicalKeyboardKey.arrowDown, modifier: LogicalKeyboardKey.controlLeft),
          VideoHotKeys.prevVideo =>
            KeyCombination(key: LogicalKeyboardKey.keyP, modifier: LogicalKeyboardKey.shiftLeft),
          VideoHotKeys.nextVideo =>
            KeyCombination(key: LogicalKeyboardKey.keyN, modifier: LogicalKeyboardKey.shiftLeft),
          VideoHotKeys.nextChapter => KeyCombination(key: LogicalKeyboardKey.pageUp),
          VideoHotKeys.prevChapter => KeyCombination(key: LogicalKeyboardKey.pageDown),
          VideoHotKeys.fullScreen => KeyCombination(key: LogicalKeyboardKey.keyF),
          VideoHotKeys.skipMediaSegment => KeyCombination(key: LogicalKeyboardKey.keyS),
          VideoHotKeys.takeScreenshot => KeyCombination(key: LogicalKeyboardKey.keyG),
          VideoHotKeys.takeScreenshotClean =>
            KeyCombination(key: LogicalKeyboardKey.keyG, modifier: LogicalKeyboardKey.controlLeft),
          VideoHotKeys.exit => KeyCombination(key: LogicalKeyboardKey.escape),
        },
    };
