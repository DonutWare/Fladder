import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/models/settings/hotkeys_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final videoPlayerSettingsProvider =
    StateNotifierProvider<VideoPlayerSettingsProviderNotifier, VideoPlayerSettingsModel>((ref) {
  return VideoPlayerSettingsProviderNotifier(ref);
});

class VideoPlayerSettingsProviderNotifier extends StateNotifier<VideoPlayerSettingsModel> {
  VideoPlayerSettingsProviderNotifier(this.ref) : super(VideoPlayerSettingsModel(hotKeys: HotKeysModel()));

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
      screenBrightness: value,
    );
    if (state.screenBrightness != null) {
      ScreenBrightness().setApplicationScreenBrightness(state.screenBrightness!);
    } else {
      ScreenBrightness().resetApplicationScreenBrightness();
    }
  }

  void setSavedBrightness() {
    if (state.screenBrightness != null) {
      ScreenBrightness().setApplicationScreenBrightness(state.screenBrightness!);
    }
  }

  void setFillScreen(bool? value, {BuildContext? context}) {
    state = state.copyWith(fillScreen: value ?? false);
  }

  void setHardwareAccel(bool? value) => state = state.copyWith(hardwareAccel: value ?? true);
  void setUseLibass(bool? value) => state = state.copyWith(useLibass: value ?? false);
  void setBufferSize(int? value) => state = state.copyWith(bufferSize: value ?? 32);
  void setFitType(BoxFit? value) => state = state.copyWith(videoFit: value ?? BoxFit.contain);

  void setForwardSpeed(int? value) {
    state = state.copyWith(
        hotKeys: state.hotKeys.copyWith(forwardStep: Duration(seconds: value ?? HotKeysModel().forwardStep.inSeconds)));
  }

  void setBackwardSpeed(int? value) {
    state = state.copyWith(
        hotKeys:
            state.hotKeys.copyWith(backwardStep: Duration(seconds: value ?? HotKeysModel().backwardStep.inSeconds)));
  }

  void setVolume(double value) {
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }

  void steppedVolume(int i) {
    final value = (state.volume + i).clamp(0, 100).toDouble();
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }

  void toggleOrientation(Set<DeviceOrientation>? orientation) =>
      state = state.copyWith(allowedOrientations: orientation);

  void setShortcuts(MapEntry<HotKeys, KeyCombination?> newEntry) {
    final currentShortcuts = Map.fromEntries(state.hotKeys.shortCuts.entries);
    currentShortcuts.update(
      newEntry.key,
      (value) => newEntry.value,
    );
    state = state.copyWith(hotKeys: state.hotKeys.copyWith(shortCuts: currentShortcuts));
  }
}
