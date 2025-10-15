import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/src/player_settings_helper.g.dart' as pigeon;

final pigeonPlayerSettingsSyncProvider = Provider<void>((ref) {
  void sendSettings() {
    final userData = ref.read(userProvider);
    final color = ref.read(
      clientSettingsProvider.select(
        (value) => value.themeColor?.color.toARGB32(),
      ),
    );
    final value = ref.read(videoPlayerSettingsProvider);

    if (!kIsWeb && Platform.isAndroid) {
      pigeon.PlayerSettingsPigeon().sendPlayerSettings(
        pigeon.PlayerSettings(
          enableTunneling: value.enableTunneling,
          skipTypes: value.segmentSkipSettings.map(
            (key, value) => MapEntry(
              switch (key) {
                MediaSegmentType.unknown => pigeon.SegmentType.intro,
                MediaSegmentType.commercial => pigeon.SegmentType.commercial,
                MediaSegmentType.preview => pigeon.SegmentType.preview,
                MediaSegmentType.recap => pigeon.SegmentType.recap,
                MediaSegmentType.outro => pigeon.SegmentType.outro,
                MediaSegmentType.intro => pigeon.SegmentType.intro,
              },
              switch (value) {
                SegmentSkip.none => pigeon.SegmentSkip.none,
                SegmentSkip.askToSkip => pigeon.SegmentSkip.ask,
                SegmentSkip.skip => pigeon.SegmentSkip.skip,
              },
            ),
          ),
          themeColor: color,
          autoNextType: switch (value.nextVideoType) {
            AutoNextType.off => pigeon.AutoNextType.off,
            AutoNextType.static => pigeon.AutoNextType.static,
            AutoNextType.smart => pigeon.AutoNextType.smart,
          },
          skipBackward: (userData?.userSettings?.skipBackDuration ?? const Duration(seconds: 15)).inMilliseconds,
          skipForward: (userData?.userSettings?.skipForwardDuration ?? const Duration(seconds: 30)).inMilliseconds,
        ),
      );
    }
  }

  ref.listen(userProvider, (_, __) => sendSettings());
  ref.listen(clientSettingsProvider, (_, __) => sendSettings());
  ref.listen(videoPlayerSettingsProvider, (_, __) => sendSettings());

  sendSettings();
});
