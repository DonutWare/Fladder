import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/localization_helper.dart';

class TranscodeMusicDownloadModel {
  final bool enabled;
  final MusicAudioCodec audioCodec;
  final Bitrate maxBitrate;
  final MusicContainer container;

  const TranscodeMusicDownloadModel({
    this.enabled = false,
    this.audioCodec = MusicAudioCodec.aac,
    this.maxBitrate = Bitrate.b420Kbps,
    this.container = MusicContainer.mp3,
  });

  TranscodeMusicDownloadModel copyWith({
    bool? enabled,
    MusicAudioCodec? audioCodec,
    Bitrate? maxBitrate,
    MusicContainer? container,
  }) {
    return TranscodeMusicDownloadModel(
      enabled: enabled ?? this.enabled,
      audioCodec: audioCodec ?? this.audioCodec,
      maxBitrate: maxBitrate ?? this.maxBitrate,
      container: container ?? this.container,
    );
  }

  factory TranscodeMusicDownloadModel.fromJson(Map<String, dynamic> json) {
    return TranscodeMusicDownloadModel(
      enabled: json['enabled'] as bool? ?? false,
      audioCodec: MusicAudioCodec.values.byName((json['audioCodec'] as String?) ?? MusicAudioCodec.aac.name),
      maxBitrate: Bitrate.values.byName((json['maxBitrate'] as String?) ?? Bitrate.b420Kbps.name),
      container: MusicContainer.values.byName((json['container'] as String?) ?? MusicContainer.mp3.name),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'audioCodec': audioCodec.name,
      'maxBitrate': maxBitrate.name,
      'container': container.name,
    };
  }

  Map<String, String> curlHeaders(Duration duration, {ItemBaseModel? item}) => {
        'User-Agent': 'curl/8.0.1',
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Known-Content-Length': calculatedContentLength(duration, item: item).toString(),
      };

  int calculatedContentLength(Duration duration, {ItemBaseModel? item}) {
    final seconds = duration.inSeconds;
    if (seconds <= 0) return 0;
    final audioStreams = item?.streamModel?.audioStreams;
    final audioBitrate = audioStreams != null && audioStreams.isNotEmpty ? audioStreams.first.bitRate : null;
    final bitrateValue = maxBitrate.bitRate ?? audioBitrate ?? 420000;
    return ((bitrateValue * seconds) / 8 * 1.1).floor();
  }

  DeviceProfile get deviceProfile => DeviceProfile(
        maxStreamingBitrate: maxBitrate.bitRate,
        maxStaticBitrate: maxBitrate.bitRate,
        directPlayProfiles: const [
          DirectPlayProfile(type: DlnaProfileType.audio),
        ],
        transcodingProfiles: [
          TranscodingProfile(
            audioCodec: audioCodec.name.toLowerCase(),
            container: container.name.toLowerCase(),
            maxAudioChannels: '2',
            protocol: MediaStreamProtocol.http,
            type: DlnaProfileType.audio,
          ),
        ],
        containerProfiles: const [],
        subtitleProfiles: const [],
      );

  String label(BuildContext context) {
    if (!enabled) {
      return context.localized.qualityOptionsOriginal;
    }
    return '${context.localized.playbackTypeTranscode}: ${audioCodec.label} | ~${maxBitrate.label(context)} | ${container.label}';
  }
}

enum MusicAudioCodec {
  aac,
  mp3,
  opus,
  vorbis;

  String get label => switch (this) {
        MusicAudioCodec.aac => 'AAC',
        MusicAudioCodec.mp3 => 'MP3',
        MusicAudioCodec.opus => 'Opus',
        MusicAudioCodec.vorbis => 'Vorbis',
      };
}

enum MusicContainer {
  mp3,
  aac,
  opus,
  flac;

  String get label => switch (this) {
        MusicContainer.mp3 => 'mp3',
        MusicContainer.aac => 'aac',
        MusicContainer.opus => 'opus',
        MusicContainer.flac => 'flac',
      };

  String get extension => switch (this) {
        MusicContainer.mp3 => '.mp3',
        MusicContainer.aac => '.aac',
        MusicContainer.opus => '.opus',
        MusicContainer.flac => '.flac',
      };
}
