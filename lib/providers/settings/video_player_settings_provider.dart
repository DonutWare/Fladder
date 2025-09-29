import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/shared_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';

final videoPlayerSettingsProvider =
    StateNotifierProvider<VideoPlayerSettingsProviderNotifier, VideoPlayerSettingsModel>((ref) {
  return VideoPlayerSettingsProviderNotifier(ref);
});

final playbackRateProvider = StateProvider<double>((ref) => 1.0);

class VideoPlayerSettingsProviderNotifier extends StateNotifier<VideoPlayerSettingsModel> {
  VideoPlayerSettingsProviderNotifier(this.ref) : super(VideoPlayerSettingsModel());

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

  VideoPlayerSettingsModel update(VideoPlayerSettingsModel Function(VideoPlayerSettingsModel currentState) value) => state = value(state);

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
  void setMediaTunneling(bool? value) => state = state.copyWith(enableTunneling: value ?? false);
  void setBufferSize(int? value) => state = state.copyWith(bufferSize: value ?? 32);
  void setFitType(BoxFit? value) => state = state.copyWith(videoFit: value ?? BoxFit.contain);

  String? get _screenshotsFolder => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
      ? ref.read(videoPlayerSettingsProvider.select((value) => value.screenshotsPath))
      : "";

  String? get screenshotsFolder => _screenshotsFolder;
  void setScreenshotsPath(String? path) => state = state.copyWith(screenshotsPath: path);

  ScreenshotFormat get _screenshotFormat => ref.read(videoPlayerSettingsProvider.select((value) => value.screenshotFormat));
  ScreenshotFormat get screenshotFormat => _screenshotFormat;
  void setScreenshotFormat(ScreenshotFormat format) => state = state.copyWith(screenshotFormat: format);

  int get _screenshotNamePadding => ref.read(videoPlayerSettingsProvider.select((value) => value.screenshotNamePadding));
  int get screenshotNamePadding => _screenshotNamePadding;
  void setscreenshotNamePadding(int amount) => state = state.copyWith(screenshotNamePadding: amount);

  void setVolume(double value) {
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }

  void steppedVolume(int i) {
    final value = (state.volume + i).clamp(0, 100).toDouble();
    state = state.copyWith(internalVolume: value);
    ref.read(videoPlayerProvider).setVolume(value);
  }

  void steppedSpeed(double i) {
    var value = double.parse(
      ((ref.read(playbackRateProvider) + i).clamp(0.25, 3)).toStringAsFixed(2),
    );

    if ((value - 1.0).abs() <= 0.06) {
      value = 1.0;
    }

    ref.read(playbackRateProvider.notifier).state = value;
    ref.read(videoPlayerProvider).setSpeed(value);
  }

  void toggleOrientation(Set<DeviceOrientation>? orientation) =>
      state = state.copyWith(allowedOrientations: orientation);

  void setShortcuts(MapEntry<VideoHotKeys, KeyCombination> newEntry) {
    state = state.copyWith(hotKeys: state.hotKeys.setOrRemove(newEntry, state.defaultShortCuts));
  }

  void nextChapter() {
    final chapters = ref.read(playBackModel)?.chapters ?? [];
    final currentPosition = ref.read(videoPlayerProvider.select((value) => value.lastState?.position));

    if (chapters.isNotEmpty && currentPosition != null) {
      final currentChapter = chapters.lastWhereOrNull((element) => element.startPosition <= currentPosition);

      if (currentChapter != null) {
        final nextChapterIndex = chapters.indexOf(currentChapter) + 1;
        if (nextChapterIndex < chapters.length) {
          ref.read(videoPlayerProvider).seek(chapters[nextChapterIndex].startPosition);
        } else {
          ref.read(videoPlayerProvider).seek(currentChapter.startPosition);
        }
      }
    }
  }

  void prevChapter() {
    final chapters = ref.read(playBackModel)?.chapters ?? [];
    final currentPosition = ref.read(videoPlayerProvider.select((value) => value.lastState?.position));

    if (chapters.isNotEmpty && currentPosition != null) {
      final currentChapter = chapters.lastWhereOrNull((element) => element.startPosition <= currentPosition);

      if (currentChapter != null) {
        final prevChapterIndex = chapters.indexOf(currentChapter) - 1;
        if (prevChapterIndex >= 0) {
          ref.read(videoPlayerProvider).seek(chapters[prevChapterIndex].startPosition);
        } else {
          ref.read(videoPlayerProvider).seek(currentChapter.startPosition);
        }
      }
    }
  }
}
