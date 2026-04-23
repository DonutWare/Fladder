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
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/src/video_player_helper.g.dart';
import 'package:fladder/util/bitrate_helper.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/wrappers/media_control_wrapper.dart';

class TvPlaybackModel extends PlaybackModel {
  static Timer? _refreshTimer;
  static Timer? _tickTimer;

  static DateTime? _lastScheduledAt;
  static String? _lastGuideProgId;
  static bool _isSwitching = false;
  final ChannelModel channel;

  final bool isNativePlayerBackend;

  final ChannelProgram? currentProgram;

  ChannelProgram? get playingProgram => currentProgram ?? channel.iCurrentProgram;

  @override
  ItemBaseModel get item => playingProgram?.toItemBaseModel() ?? channel;

  final Duration? position;
  final Duration? duration;

  TvPlaybackModel({
    required this.channel,
    super.playbackInfo,
    required super.item,
    this.position,
    this.duration,
    this.currentProgram,
    this.isNativePlayerBackend = false,
    super.media,
    super.queue,
  });

  void startTracking(Ref ref) {
    _stopTimers();
    _switchProgram(ref);

    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) => _tick(ref));
  }

  void stopTracking() {
    _stopTimers();
    _isSwitching = false;
    _lastGuideProgId = null;
  }

  @override
  void dispose() {
    stopTracking();
  }

  void _stopTimers() {
    _tickTimer?.cancel();
    _tickTimer = null;
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _lastScheduledAt = null;
  }

  void _tick(Ref ref) {
    final model = ref.read(playBackModel);
    if (model is! TvPlaybackModel) {
      _stopTimers();
      return;
    }

    final currentProgram = model.playingProgram;
    if (currentProgram == null || !ref.read(mediaPlaybackProvider).playing) {
      return;
    }

    final now = DateTime.now();

    if (!_isProgramValid(currentProgram, now)) {
      _switchProgram(ref);
      return;
    }

    final start = currentProgram.startDate;
    final end = currentProgram.endDate;
    final newPosition = now.isBefore(start) ? Duration.zero : now.difference(start);
    final newDuration = end.difference(start);

    ref.read(playBackModel.notifier).update((state) => model.copyWith(
          position: newPosition,
          duration: newDuration,
        ));
  }

  bool _isProgramValid(ChannelProgram program, DateTime now) {
    return now.isAfter(program.startDate) && now.isBefore(program.endDate);
  }

  Future<void> _switchProgram(Ref ref) async {
    if (_isSwitching) return;
    _isSwitching = true;
    try {
      final currentModel = ref.read(playBackModel);
      if (currentModel is! TvPlaybackModel) {
        _stopTimers();
        return;
      }

      final tempState = await ref.read(liveTvProvider.notifier).fetchDashboard();
      final updatedChannel =
          tempState.channels.firstWhereOrNull((c) => c.id == currentModel.channel.id) ?? currentModel.channel;
      final currentChannelPrograms = await ref.read(liveTvProvider.notifier).fetchPrograms(updatedChannel);
      final channelWithPrograms = updatedChannel.copyChannelWith(programs: currentChannelPrograms);

      final now = DateTime.now();
      final prog = channelWithPrograms.currentProgram;

      final start = prog?.startDate ?? now;
      final end = prog?.endDate ?? now;
      final newPosition = now.isBefore(start) ? Duration.zero : now.difference(start);
      final newDuration = end.difference(start);

      // Re-read in case model changed during async operations
      final latestModel = ref.read(playBackModel);
      if (latestModel is! TvPlaybackModel) {
        _stopTimers();
        return;
      }

      final newModel = latestModel.copyWith(
        channel: channelWithPrograms,
        currentProgram: prog,
        position: newPosition,
        duration: newDuration,
      );

      ref.read(playBackModel.notifier).update((state) => newModel);

      if (prog != null && prog.endDate.isAfter(now)) {
        _scheduleRefreshAt(prog.endDate, ref);
      }

      await _sendNativeGuideUpdate(ref, prog, channelWithPrograms, tempState, latestModel.isNativePlayerBackend);
    } finally {
      _isSwitching = false;
    }
  }

  Future<void> _sendNativeGuideUpdate(
    Ref ref,
    ChannelProgram? prog,
    ChannelModel channelWithPrograms,
    LiveTvModel tempState,
    bool isNativePlayerBackend,
  ) async {
    if (!isNativePlayerBackend || tempState.channels.isEmpty || _lastGuideProgId == prog?.id) {
      return;
    }

    _lastGuideProgId = prog?.id;

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
            subTitle: context != null ? prog.subLabel(context.localized) : null,
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
                          subTitle: context != null ? p.subLabel(context.localized) : null,
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

    try {
      log("Sending TV Guide: ${newGuide.channels.length} channels, current program: ${newGuide.currentProgram?.name}");
      VideoPlayerApi().sendTVGuideModel(newGuide);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  void _scheduleRefreshAt(DateTime at, Ref ref) {
    if (_lastScheduledAt != null && _lastScheduledAt!.isAtSameMomentAs(at)) {
      return;
    }

    _refreshTimer?.cancel();
    _lastScheduledAt = at;

    final now = DateTime.now();
    final delay = at.isBefore(now) ? const Duration(seconds: 1) : at.difference(now) + const Duration(seconds: 1);

    _refreshTimer = Timer(delay, () {
      _lastScheduledAt = null;
      _switchProgram(ref);
    });
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
