import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/util/localization_helper.dart';

part 'video_player_settings.freezed.dart';
part 'video_player_settings.g.dart';

@freezed
class VideoPlayerSettingsModel with _$VideoPlayerSettingsModel {
  const VideoPlayerSettingsModel._();

  factory VideoPlayerSettingsModel({
    double? screenBrightness,
    @Default(BoxFit.contain) BoxFit videoFit,
    @Default(false) bool fillScreen,
    @Default(true) bool hardwareAccel,
    @Default(false) bool useLibass,
    @Default(100) double internalVolume,
    Set<DeviceOrientation>? allowedOrientations,
    @Default(AutoNextType.smart) AutoNextType nextVideoType,
    String? audioDevice,
  }) = _VideoPlayerSettingsModel;

  double get volume => switch (defaultTargetPlatform) {
        TargetPlatform.android || TargetPlatform.iOS => 100,
        _ => internalVolume,
      };

  factory VideoPlayerSettingsModel.fromJson(Map<String, dynamic> json) => _$VideoPlayerSettingsModelFromJson(json);

  bool playerSame(VideoPlayerSettingsModel other) {
    return other.hardwareAccel == hardwareAccel && other.useLibass == useLibass;
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
        other.internalVolume == internalVolume &&
        other.audioDevice == audioDevice;
  }

  @override
  int get hashCode {
    return screenBrightness.hashCode ^
        videoFit.hashCode ^
        fillScreen.hashCode ^
        hardwareAccel.hashCode ^
        useLibass.hashCode ^
        internalVolume.hashCode ^
        audioDevice.hashCode;
  }
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
