import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_tizen/flutter_tizen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/settings/video_player_settings.dart';
import 'package:fladder/profiles/tizen_profile.dart';
import 'package:fladder/profiles/web_profile.dart';
import 'package:fladder/providers/video_player_provider.dart';

final videoProfileProvider = StateProvider.autoDispose<DeviceProfile>((ref) =>
    defaultProfile(ref.read(videoPlayerProvider.select((value) => value.backend)) ?? PlayerOptions.platformDefaults));

DeviceProfile defaultProfile(PlayerOptions player) {
  if (kIsWeb) {
    return webProfile;
  }
  
  // Use Tizen-specific profile for Tizen devices
  if (isTizen) {
    return tizenProfile;
  }
  
  return const DeviceProfile(
    maxStreamingBitrate: 120000000,
    maxStaticBitrate: 120000000,
    musicStreamingTranscodingBitrate: 384000,
    directPlayProfiles: [
      DirectPlayProfile(
        type: DlnaProfileType.video,
      ),
      DirectPlayProfile(
        type: DlnaProfileType.audio,
      )
    ],
    transcodingProfiles: [
      TranscodingProfile(
        audioCodec: 'aac,mp3,mp2',
        container: 'ts',
        maxAudioChannels: '2',
        protocol: MediaStreamProtocol.hls,
        type: DlnaProfileType.video,
        videoCodec: 'h264',
      ),
    ],
    containerProfiles: [],
    subtitleProfiles: [
      SubtitleProfile(format: 'vtt', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'ass', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'ssa', method: SubtitleDeliveryMethod.$external),
      SubtitleProfile(format: 'pgssub', method: SubtitleDeliveryMethod.$external),
    ],
  );
}
