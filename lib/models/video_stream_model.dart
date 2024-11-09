import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/user_provider.dart';

enum PlaybackType {
  directStream,
  offline,
  transcode;

  IconData get icon => switch (this) {
        PlaybackType.offline => IconsaxOutline.cloud,
        PlaybackType.directStream => IconsaxOutline.arrow_right_1,
        PlaybackType.transcode => IconsaxOutline.convert,
      };

  String get name {
    switch (this) {
      case PlaybackType.directStream:
        return "Direct";
      case PlaybackType.offline:
        return "Offline";
      case PlaybackType.transcode:
        return "Transcoding";
    }
  }
}

class VideoPlayback {
  final List<ItemStreamModel> queue;
  final ItemStreamModel? currentItem;
  final SyncedItem? currentSyncedItem;
  final VideoStream? currentStream;
  VideoPlayback({
    required this.queue,
    this.currentItem,
    this.currentSyncedItem,
    this.currentStream,
  });

  List<SubStreamModel> get subStreams => currentStream?.mediaStreamsModel?.subStreams ?? [];
  List<AudioStreamModel> get audioStreams => currentStream?.mediaStreamsModel?.audioStreams ?? [];

  ItemStreamModel? get previousVideo {
    final int currentIndex = queue.indexWhere((element) => element.id == currentItem?.id);
    if (currentIndex > 0) {
      return queue[currentIndex - 1];
    }
    return null;
  }

  ItemStreamModel? get nextVideo {
    final int currentIndex = queue.indexWhere((element) => element.id == currentItem?.id);
    if ((currentIndex + 1) < queue.length) {
      return queue[currentIndex + 1];
    }
    return null;
  }

  VideoPlayback copyWith({
    List<ItemStreamModel>? queue,
    ItemStreamModel? currentItem,
    SyncedItem? currentSyncedItem,
    VideoStream? currentStream,
    Map<AudioStreamModel, AudioTrack>? audioMappings,
    Map<SubStreamModel, SubtitleTrack>? subMappings,
  }) {
    return VideoPlayback(
      queue: queue ?? this.queue,
      currentItem: currentItem ?? this.currentItem,
      currentSyncedItem: currentSyncedItem ?? this.currentSyncedItem,
      currentStream: currentStream ?? this.currentStream,
    );
  }

  VideoPlayback clear() {
    return VideoPlayback(
      queue: queue,
      currentItem: null,
      currentStream: null,
    );
  }
}

class VideoStream {
  final String id;
  final Duration? currentPosition;
  final PlaybackType playbackType;
  final String playbackUrl;
  final String playSessionId;
  final List<Chapter>? chapters;
  final List<Chapter>? trickPlay;
  final MediaSegmentsModel? mediaSegments;
  final int? audioStreamIndex;
  final int? subtitleStreamIndex;
  final MediaStreamsModel? mediaStreamsModel;

  AudioStreamModel? get currentAudioStream {
    if (audioStreamIndex == -1) {
      return null;
    }
    return mediaStreamsModel?.audioStreams.firstWhereOrNull(
        (element) => element.index == (audioStreamIndex ?? mediaStreamsModel?.currentAudioStream ?? 0));
  }

  SubStreamModel? get currentSubStream {
    if (subtitleStreamIndex == -1) {
      return null;
    }
    return mediaStreamsModel?.subStreams.firstWhereOrNull(
        (element) => element.index == (subtitleStreamIndex ?? mediaStreamsModel?.currentSubStream ?? 0));
  }

  VideoStream({
    required this.id,
    this.currentPosition,
    required this.playbackType,
    required this.playbackUrl,
    required this.playSessionId,
    this.chapters,
    this.trickPlay,
    this.mediaSegments,
    this.audioStreamIndex,
    this.subtitleStreamIndex,
    this.mediaStreamsModel,
  });

  VideoStream copyWith({
    String? id,
    Duration? currentPosition,
    PlaybackType? playbackType,
    String? playbackUrl,
    String? playSessionId,
    List<Chapter>? chapters,
    List<Chapter>? trickPlay,
    MediaSegmentsModel? mediaSegments,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    MediaStreamsModel? mediaStreamsModel,
  }) {
    return VideoStream(
      id: id ?? this.id,
      currentPosition: currentPosition ?? this.currentPosition,
      playbackType: playbackType ?? this.playbackType,
      playbackUrl: playbackUrl ?? this.playbackUrl,
      playSessionId: playSessionId ?? this.playSessionId,
      chapters: chapters ?? this.chapters,
      trickPlay: trickPlay ?? this.trickPlay,
      mediaSegments: mediaSegments ?? this.mediaSegments,
      audioStreamIndex: audioStreamIndex ?? this.audioStreamIndex,
      subtitleStreamIndex: subtitleStreamIndex ?? this.subtitleStreamIndex,
      mediaStreamsModel: mediaStreamsModel ?? this.mediaStreamsModel,
    );
  }

  static VideoStream? fromPlayBackInfo(PlaybackInfoResponse info, Ref ref) {
    final mediaSource = info.mediaSources?.first;
    var playType = PlaybackType.directStream;

    String? playbackUrl;

    if (mediaSource == null) return null;

    if (mediaSource.supportsDirectStream ?? false) {
      final Map<String, String?> directOptions = {
        'Static': 'true',
        'mediaSourceId': mediaSource.id,
        'api_key': ref.read(userProvider)?.credentials.token,
      };

      if (mediaSource.eTag != null) {
        directOptions['Tag'] = mediaSource.eTag;
      }

      if (mediaSource.liveStreamId != null) {
        directOptions['LiveStreamId'] = mediaSource.liveStreamId;
      }

      final params = Uri(queryParameters: directOptions).query;

      playbackUrl = '${ref.read(userProvider)?.server ?? ""}/Videos/${mediaSource.id}/stream?$params';
    } else if ((mediaSource.supportsTranscoding ?? false) && mediaSource.transcodingUrl != null) {
      playbackUrl = "${ref.read(userProvider)?.server ?? ""}${mediaSource.transcodingUrl ?? ""}";
      playType = PlaybackType.transcode;
    }

    if (playbackUrl == null) return null;

    return VideoStream(
      id: info.mediaSources?.first.id ?? "",
      playbackUrl: playbackUrl,
      playbackType: playType,
      playSessionId: info.playSessionId ?? "",
      mediaStreamsModel: MediaStreamsModel.fromMediaStreamsList(
          info.mediaSources?.firstOrNull, info.mediaSources?.firstOrNull?.mediaStreams ?? [], ref),
    );
  }
}
