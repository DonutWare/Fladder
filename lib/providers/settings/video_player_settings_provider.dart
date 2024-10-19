import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final videoPlayerSettingsProvider =
    StateNotifierProvider<VideoPlayerSettingsProviderNotifier, VideoPlayerSettingsModel>((ref) {
  return VideoPlayerSettingsProviderNotifier(ref);
});

class VideoPlayerSettingsProviderNotifier extends StateNotifier<VideoPlayerSettingsModel> {
  VideoPlayerSettingsProviderNotifier(this.ref) : super(const VideoPlayerSettingsModel());

  final Ref ref;

  @override
  set state(VideoPlayerSettingsModel value) {
    final oldState = super.state;
    super.state = value;
    ref.read(sharedUtilityProvider).videoPlayerSettings = value;
    if (!oldState.playerSame(value)) {
      ref.read(videoPlayerProvider.notifier).init();
    }
  }

  void setScreenBrightness(double? value) async {
    state = state.copyWith(
      screenBrightness: () => value,
    );
    if (state.screenBrightness != null) {
      ScreenBrightness().setScreenBrightness(state.screenBrightness!);
    } else {
      ScreenBrightness().resetScreenBrightness();
    }
  }

  void setSavedBrightness() {
    if (state.screenBrightness != null) {
      ScreenBrightness().setScreenBrightness(state.screenBrightness!);
    }
  }

  void setFillScreen(bool? value, {BuildContext? context}) {
    state = state.copyWith(fillScreen: value);
  }

  void setHardwareAccel(bool? value) => state = state.copyWith(hardwareAccel: value);
  void setUseLibass(bool? value) => state = state.copyWith(useLibass: value);

  void setFitType(BoxFit? value) => state = state.copyWith(videoFit: value);

  void setVolume(double value) {
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }

  void steppedVolume(int i) {
    final value = (state.volume + i).clamp(0, 100).toDouble();
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }
}
