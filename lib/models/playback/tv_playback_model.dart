import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/live_tv_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/settings/arguments_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

Timer? _refreshTimer;
Timer? _tickTimer;

class TvPlaybackModel extends PlaybackModel {
  final ChannelModel channel;

  final ChannelProgram? currentProgram;

  @override
  ItemBaseModel get item => currentProgram != null ? currentProgram!.toItemBaseModel() : channel;

  final Duration? position;
  final Duration? duration;

  TvPlaybackModel({
    required this.channel,
    super.playbackInfo,
    required super.item,
    this.position,
    this.duration,
    this.currentProgram,
    super.media,
    super.queue,
  });

  void startTracking(Ref ref) {
    _stopTimers();
    _updateCurrentProgramFromProvider(ref);

    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) => _tick(ref));
  }

  void stopTracking() {
    _stopTimers();
  }

  void _stopTimers() {
    _tickTimer?.cancel();
    _tickTimer = null;
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  void _tick(Ref ref) {
    final currentProgram = this.currentProgram;
    if (currentProgram == null) {
      return;
    }

    if (!ref.read(mediaPlaybackProvider).playing) {
      return;
    }

    final now = DateTime.now();
    final start = currentProgram.startDate;
    final end = currentProgram.endDate;

    final newPosition = now.isBefore(start) ? Duration.zero : now.difference(start);
    final newDuration = end.difference(start);

    final updatedModel = copyWith(
      currentProgram: currentProgram,
      position: newPosition,
      duration: newDuration,
    );

    ref.read(playBackModel.notifier).update((state) => updatedModel);

    _scheduleRefreshAt(end, ref);
  }

  void _scheduleRefreshAt(DateTime at, Ref ref) {
    _refreshTimer?.cancel();

    final now = DateTime.now();
    final durationUntil = at.difference(now);

    if (durationUntil.isNegative) {
      ref.read(liveTvProvider.notifier).fetchPrograms(channel);
      Future.microtask(() => _updateCurrentProgramFromProvider(ref));
      return;
    }

    _refreshTimer = Timer(durationUntil + const Duration(seconds: 1), () async {
      await ref.read(liveTvProvider.notifier).fetchPrograms(channel);
      _updateCurrentProgramFromProvider(ref);
    });
  }

  Future<void> _updateCurrentProgramFromProvider(Ref ref) async {
    LiveTvModel tempState = await ref.read(liveTvProvider.notifier).fetchDashboard();

    final updatedChannel = tempState.channels.firstWhereOrNull((c) => c.id == channel.id) ?? channel;

    final currentChannelPrograms = await ref.read(liveTvProvider.notifier).fetchPrograms(updatedChannel);
    final channelWithPrograms = updatedChannel.copyChannelWith(programs: currentChannelPrograms);

    final now = DateTime.now();
    final prog = channelWithPrograms.currentProgram;

    final oldProgId = currentProgram?.id;
    final newModel = copyWith(
      channel: channelWithPrograms,
      currentProgram: prog,
    );

    ref.read(playBackModel.notifier).update((state) => newModel);

    if (prog != null && prog.endDate.isAfter(now)) {
      _scheduleRefreshAt(prog.endDate, ref);
    }

    if (oldProgId != prog?.id) {
      _tick(ref);
    }

    if (tempState.channels.isEmpty) {
      return;
    }

    final context = ref.read(localizationContextProvider);

    var guideProgram = prog != null
        ? GuideProgram(
            id: prog.id,
            channelId: prog.channelId,
            name: prog.name,
            startMs: prog.startDate.millisecondsSinceEpoch,
            endMs: prog.endDate.millisecondsSinceEpoch,
            overview: prog.overview,
            primaryPoster: prog.images?.primary?.path,
            subTitle: context != null ? prog.subLabel(context) : null,
          )
        : null;

    final newGuide = TVGuideModel(
      currentProgram: guideProgram,
      channels: tempState.channels.map(
        (e) {
          final isCurrentChannel = e.id == channelWithPrograms.id;
          return GuideChannel(
            channelId: e.id,
            name: e.name,
            logoUrl: e.images?.primary?.path,
            programs: isCurrentChannel
                ? channelWithPrograms.programs
                    .map((p) => GuideProgram(
                          id: p.id,
                          channelId: e.id,
                          name: p.name,
                          startMs: p.startDate.millisecondsSinceEpoch,
                          endMs: p.endDate.millisecondsSinceEpoch,
                          primaryPoster: p.images?.primary?.path,
                          overview: p.overview,
                          subTitle: context != null ? p.subLabel(context) : null,
                        ))
                    .toList()
                : [],
            programsLoaded: isCurrentChannel,
          );
        },
      ).toList(),
      startMs: tempState.startDate.millisecondsSinceEpoch,
      endMs: tempState.endDate.millisecondsSinceEpoch,
    );

    if (leanBackMode) {
      try {
        log("Sending TV Guide with lazy-loaded programs: ${newGuide.channels.length} channels, current program: ${newGuide.currentProgram?.name}");
        VideoPlayerApi().sendTVGuideModel(newGuide);
      } catch (e, stackTrace) {
        log(e.toString(), stackTrace: stackTrace);
      }
    }
  }

  @override
  Future<PlaybackModel?> updatePlaybackPosition(Duration position, bool isPlaying, Ref ref) async {
    return this;
  }

  @override
  Future<PlaybackModel?> playbackStarted(Duration position, Ref ref) async {
    if (_tickTimer == null) {
      startTracking(ref);
    }
    await ref.read(jellyApiProvider).sessionsPlayingPost(
          body: PlaybackStartInfo(
            canSeek: true,
            itemId: item.id,
            mediaSourceId: item.id,
            playSessionId: playbackInfo?.playSessionId,
            subtitleStreamIndex: item.streamModel?.defaultSubStreamIndex,
            audioStreamIndex: item.streamModel?.defaultAudioStreamIndex,
            volumeLevel: 100,
            playMethod: PlayMethod.directplay,
            isMuted: false,
            isPaused: false,
            repeatMode: RepeatMode.repeatall,
          ),
        );
    return this;
  }

  @override
  Future<PlaybackModel?> playbackStopped(Duration position, Duration? totalDuration, Ref ref) async {
    stopTracking();

    ref.read(playBackModel.notifier).update((state) => null);
    await ref.read(jellyApiProvider).sessionsPlayingStoppedPost(
          body: PlaybackStopInfo(
            itemId: item.id,
            mediaSourceId: item.id,
            playSessionId: playbackInfo?.playSessionId,
          ),
        );
    return this;
  }

  @override
  List<SubStreamModel>? get subStreams => null;

  @override
  List<AudioStreamModel>? get audioStreams => null;

  @override
  PlaybackModel? updateUserData(UserData userData) {
    return copyWith(
      item: item.copyWith(
        userData: userData,
      ),
    );
  }

  @override
  Future<PlaybackModel>? setAudio(AudioStreamModel? model, MediaControlsWrapper player) async => this;

  @override
  Future<PlaybackModel>? setQualityOption(Map<Bitrate, bool> map) async => this;

  @override
  Future<PlaybackModel>? setSubtitle(SubStreamModel? model, MediaControlsWrapper player) async => this;

  @override
  PlaybackModel copyWith({
    ChannelModel? channel,
    ChannelProgram? currentProgram,
    PlaybackInfoResponse? playbackInfo,
    ItemBaseModel? item,
    Duration? position,
    Duration? duration,
    Media? media,
    List<ItemBaseModel>? queue,
  }) =>
      TvPlaybackModel(
        channel: channel ?? this.channel,
        currentProgram: currentProgram ?? this.currentProgram,
        playbackInfo: playbackInfo ?? this.playbackInfo,
        item: item ?? this.item,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        media: media ?? this.media,
        queue: queue ?? this.queue,
      );
}
