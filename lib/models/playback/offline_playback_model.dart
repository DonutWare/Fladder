import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class OfflinePlaybackModel extends PlaybackModel {
  OfflinePlaybackModel({
    required this.syncedItem,
    super.mediaStreams,
    super.playbackInfo,
    required super.item,
    required super.media,
    super.mediaSegments,
    super.trickPlay,
    super.queue = const [],
    this.syncedQueue = const [],
    super.subtitleOffset,
  });

  final SyncedItem syncedItem;

  @override
  List<Chapter>? get chapters => syncedItem.chapters;

  @override
  Future<Duration>? startDuration() async => item.userData.playBackPosition;

  @override
  ItemBaseModel? get nextVideo => queue.nextOrNull(item);
  @override
  ItemBaseModel? get previousVideo => queue.previousOrNull(item);

  @override
  List<SubStreamModel> get subStreams => [SubStreamModel.no(), ...syncedItem.subtitles];

  @override
  Future<OfflinePlaybackModel> setSubtitle(SubStreamModel? model, MediaControlsWrapper player) async {
    final newIndex = await player.setSubtitleTrack(model, this);
    return copyWith(mediaStreams: mediaStreams?.copyWith(defaultSubStreamIndex: newIndex));
  }

  @override
  List<AudioStreamModel> get audioStreams => [AudioStreamModel.no(), ...mediaStreams?.audioStreams ?? []];

  @override
  Future<OfflinePlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) async {
    final newIndex = await player.setAudioTrack(model, this);
    return copyWith(mediaStreams: mediaStreams?.copyWith(defaultAudioStreamIndex: newIndex));
  }

  @override
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) async {
    return null;
  }

  @override
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) async {
    final progress = position.inMilliseconds / (item.overview.runTime?.inMilliseconds ?? 0) * 100;
    final isPlayed = UserData.isPlayed(position, item.overview.runTime ?? Duration.zero);
    final userData = syncedItem.userData?.copyWith(
      playbackPositionTicks: isPlayed != false ? 0 : position.toRuntimeTicks,
      progress: isPlayed != false ? 0.0 : progress,
      played: isPlayed,
      lastPlayed: DateTime.now().toUtc(),
    );
    final newItem = syncedItem.copyWith(
      userData: userData,
    );
    await ref.read(syncProvider.notifier).updateItem(newItem);
    return null;
  }

  @override
  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) async {
    final progress = position.inMilliseconds / (item.overview.runTime?.inMilliseconds ?? 0) * 100;
    final isPlayed = UserData.isPlayed(position, item.overview.runTime ?? Duration.zero);
    final userData = syncedItem.userData?.copyWith(
      playbackPositionTicks: isPlayed != false ? 0 : position.toRuntimeTicks,
      progress: isPlayed != false ? 0.0 : progress,
      played: isPlayed,
      lastPlayed: DateTime.now().toUtc(),
    );
    final newItem = syncedItem.copyWith(
      userData: userData,
    );
    await ref.read(syncProvider.notifier).updateItem(newItem);
    return null;
  }

  @override
  OfflinePlaybackModel? updateUserData(UserData userData) {
    return copyWith(
      item: item.copyWith(
        userData: userData,
      ),
    );
  }

  @override
  String toString() => 'OfflinePlaybackModel(item: $item, syncedItem: $syncedItem)';

  final List<SyncedItem> syncedQueue;

  @override
  OfflinePlaybackModel copyWith({
    ItemBaseModel? item,
    Media? media,
    MediaStreamsModel? mediaStreams,
    MediaSegmentsModel? mediaSegments,
    TrickPlayModel? trickPlay,
    List<ItemBaseModel>? queue,
    double? subtitleOffset,
  }) {
    return OfflinePlaybackModel(
      item: item ?? this.item,
      media: media ?? this.media,
      syncedItem: syncedItem,
      mediaStreams: mediaStreams ?? this.mediaStreams,
      mediaSegments: mediaSegments ?? this.mediaSegments,
      trickPlay: trickPlay ?? this.trickPlay,
      queue: queue ?? this.queue,
      syncedQueue: syncedQueue,
      subtitleOffset: subtitleOffset ?? this.subtitleOffset,
    );
  }
}
