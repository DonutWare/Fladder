part of 'media_control_wrapper.dart';

extension AudioQueueHandler on MediaControlsWrapper {
  Future<void> _serial(Future<void> Function() op) {
    _pendingQueueOps++;
    final next = _queueOps.then((_) => op()).catchError((Object error, StackTrace stackTrace) {
      log('Queue operation error: $error\n$stackTrace');
    }).whenComplete(() => _pendingQueueOps--);
    _queueOps = next;
    return next;
  }

  Future<void> _updateQueueState(PlaybackQueueState Function(PlaybackQueueState) updater) => _serial(() async {
        final model = ref.read(playBackModel);
        if (model == null) return;
        ref.read(playBackModel.notifier).update((_) => model.updatePlaybackQueue(updater(model.playbackQueue)));
        await _syncNext();
      });

  Future<void> applyReplayGain(ItemBaseModel item, {VideoPlayerSettingsModel? settings}) async {
    if (_player is LibMPV) {
      final libMPV = _player as LibMPV;
      if (settings != null) {
        await libMPV.updateSettings(settings);
      }
      await libMPV.applyReplayGainForItem(item);
    }
  }

  Future<void> loadAudioQueue(
    List<ItemBaseModel> queue,
    int initialIndex,
    Duration startPosition,
    bool startPlayback,
  ) =>
      _serial(() async {
        if (queue.isEmpty) return;
        if (!_isAudioQueueMode) {
          _previousPlayer = _player;
          await _player?.stop();
          await setup(LibMPV());
          _isAudioQueueMode = true;
        }

        final player = _player;
        if (player is LibMPV) {
          player.setMusicPlaybackMode(true);
          await _playlistIndexSub?.cancel();
          _playlistIndexSub = player.playlistIndexStream.listen(_onMpvPlaylistIndexChanged);
        }

        _audioQueueSourceDepleted = false;
        _audioQueueNextStartIndex = queue.length;
        ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(queueRefilling: false));

        final currentItem = queue[initialIndex.clamp(0, queue.length - 1)];
        final url = await AudioUrlResolver(ref).resolve(currentItem);
        await _loadTrack(currentItem, url, play: false, startPosition: startPosition);
        await _syncNext();

        final context = ref.read(localizationContextProvider);
        if (context != null) {
          ref.read(windowTitleProvider.notifier).setPlayTitle(currentItem.windowTitle(context.localized));
        }

        unawaited(ref.read(audioLyricsProvider.notifier).loadForTrack(currentItem.id));

        final playbackModel = ref.read(playBackModel);
        if (playbackModel != null) {
          await _refreshMediaControls(model: playbackModel, playing: false);
        }

        if (startPlayback) {
          await play();
        }
      });

  Future<void> setShuffleEnabled(bool enabled) async {
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(shuffleEnabled: enabled));
    await _updateQueueState((qs) => qs.withShuffleEnabled(enabled, currentId: ref.read(playBackModel)?.item.id));
  }

  Future<void> setAudioRepeatMode(AudioRepeatMode repeatMode) async {
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(repeatMode: repeatMode));
    await _updateQueueState((qs) => qs.withRepeatMode(repeatMode));
  }

  Future<void> removeAudioQueueItem(String itemId) => _updateQueueState((qs) => qs.removeItemById(itemId));

  Future<void> removeAudioQueueSectionItem(AudioQueueSection section, int sectionIndex) =>
      _updateQueueState((qs) => qs.removeSectionItem(section, sectionIndex));

  Future<void> reorderAudioQueueSection(AudioQueueSection section, int oldIndex, int newIndex) =>
      _updateQueueState((qs) => qs.reorderSection(section, oldIndex, newIndex));

  List<ItemBaseModel> fullAudioQueue() {
    return ref.read(playBackModel)?.playbackQueue.queue ?? const <ItemBaseModel>[];
  }

  Future<void> addToTemporaryQueue(List<ItemBaseModel> items) async {
    if (items.isEmpty) return;
    await _updateQueueState((qs) => qs.addToNextUp(items));
  }

  Future<void> clearTemporaryQueue() => _updateQueueState((qs) => qs.clearNextUp());

  void _onAudioTrackCompleted() {
    final generation = _mpvGeneration;
    unawaited(_serial(() async {
      if (generation != _mpvGeneration) return;
      await _playNextQueueItem();
    }));
  }

  void _onMpvPlaylistIndexChanged(int index) {
    if (!_isAudioQueueMode) return;
    final generation = _mpvGeneration;
    unawaited(_serial(() async {
      if (generation != _mpvGeneration) return;
      if (index == _mpvCurrentIndex + 1) await _advanceToMpvNext();
      await _syncNext();
    }));
  }

  Future<void> _advanceToMpvNext() async {
    final next = _mpvNext;
    final playbackModel = ref.read(playBackModel);
    if (next == null || playbackModel == null) return;
    _mpvCurrentIndex++;
    _mpvNext = null;
    await applyReplayGain(next);
    final newQueueState = playbackModel.playbackQueue.advanceFromCurrentTo(playbackModel.item.id, next.id);
    await _applyQueueItem(next, newQueueState, playbackModel, load: false);
  }

  int get _pauseMark => _player is LibMPV ? (_player as LibMPV).pauseCount : 0;

  Future<void> _skipQueue(int step) async {
    final now = DateTime.now();
    if (now.difference(_lastSkipAt) < const Duration(seconds: 2)) _skipHardCut = true;
    _lastSkipAt = now;
    _skipPauseMark = _pauseMark;
    _skipSteps += step;
    final player = _player;
    if (player is LibMPV) player.finishCrossfade();
    if (_skipQueued) return;
    _skipQueued = true;

    await _disableRepeatOneForSkip();
    await _serial(() async {
      final steps = _skipSteps;
      final hardCut = _skipHardCut || steps.abs() > 1;
      final resume = _skipPauseMark == _pauseMark;
      _skipSteps = 0;
      _skipHardCut = false;
      _skipQueued = false;

      final model = ref.read(playBackModel);
      if (model == null || steps == 0) return;

      final next = _mpvNext;
      final player = _player;
      if (steps == 1 &&
          resume &&
          next != null &&
          player is LibMPV &&
          (hardCut || !_shouldCrossfade(model.item, next, manual: true))) {
        await player.playerNext();
        await _advanceToMpvNext();
        await player.play();
        await _syncNext();
        return;
      }

      var item = model.item;
      var state = model.playbackQueue;
      for (var i = 0; i < steps.abs(); i++) {
        final transition = steps > 0 ? state.nextTransition(item.id) : state.previousTransition(item.id);
        if (transition == null) break;
        item = transition.item;
        state = transition.state;
      }

      if (item.id == model.item.id) {
        if (steps < 0) await _player?.seek(Duration.zero);
        return;
      }
      await _applyQueueItem(item, state, model, manual: true, crossfade: !hardCut, resume: resume);
      await _syncNext();
    });
  }

  Future<void> jumpToQueueItem(ItemBaseModel item) {
    final pauseMark = _pauseMark;
    return _serial(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      await _applyQueueItem(
        item,
        playbackModel.playbackQueue.jumpToItem(item.id),
        playbackModel,
        resume: pauseMark == _pauseMark,
      );
      await _syncNext();
    });
  }

  Future<void> _playNextQueueItem({bool manual = false}) async {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel == null) return;
    final transition = playbackModel.playbackQueue.nextTransition(playbackModel.item.id);
    if (transition == null) return;
    await _applyQueueItem(transition.item, transition.state, playbackModel, manual: manual);
    await _syncNext();
  }

  bool _shouldCrossfade(ItemBaseModel current, ItemBaseModel next, {bool manual = false}) {
    if (!ref.read(videoPlayerSettingsProvider).enableCrossfade) return false;
    if (manual) return true;
    if (current is! AudioModel || next is! AudioModel) return false;
    final currentAlbumId = current.albumId;
    final nextAlbumId = next.albumId;
    if (currentAlbumId == null || currentAlbumId.isEmpty) return true;
    if (currentAlbumId != nextAlbumId) return true;
    final currentTrack = current.trackNumber;
    final nextTrack = next.trackNumber;
    if (currentTrack == null || nextTrack == null || currentTrack <= 0 || nextTrack <= 0) return true;
    return nextTrack != currentTrack + 1;
  }

  Future<void> _loadTrack(
    ItemBaseModel item,
    String url, {
    required bool play,
    Duration startPosition = Duration.zero,
    bool crossfade = false,
  }) async {
    _mpvNext = null;
    _mpvCurrentIndex = 0;
    final player = _player;
    if (crossfade && player is LibMPV) {
      final gain = item is AudioModel ? item.normalizationGain : null;
      await player.crossfadeToUrl(url, startPosition, replayGainDb: gain != null && gain.isFinite ? gain : null);
    } else {
      await applyReplayGain(item);
      await player?.loadVideo(url, play, startPosition: startPosition);
    }
    _mpvGeneration++;
    _player?.applySubtitleSettings(ref.read(subtitleSettingsProvider));
  }

  Future<void> _applyQueueItem(
    ItemBaseModel item,
    PlaybackQueueState newQueueState,
    PlaybackModel currentModel, {
    bool load = true,
    bool manual = false,
    bool crossfade = true,
    bool resume = true,
  }) async {
    if (currentModel.item.id != item.id) {
      final stopPosition = _player?.lastState.position ?? Duration.zero;
      final stopDuration = currentModel.item.overview.runTime ?? _player?.lastState.duration;
      await currentModel.playbackStopped(stopPosition, stopDuration, ref);
    }

    final nextModel = await ref.read(playbackModelHelper).createPlaybackModel(
          null,
          item,
          oldModel: currentModel,
          libraryQueue: newQueueState.queue,
          showPlaybackOptions: false,
        );
    if (nextModel == null) return;

    final updatedModel = nextModel.updatePlaybackQueue(newQueueState);
    ref.read(playBackModel.notifier).update((_) => updatedModel);

    if (load) {
      await _loadTrack(
        item,
        updatedModel.media?.url ?? '',
        play: resume,
        crossfade: resume && crossfade && _shouldCrossfade(currentModel.item, item, manual: manual),
      );
      if (resume) await _player?.play();
    }

    final context = ref.read(localizationContextProvider);
    if (context != null) {
      ref.read(windowTitleProvider.notifier).setPlayTitle(item.windowTitle(context.localized));
    }

    await updatedModel.playbackStarted(Duration.zero, ref);
    unawaited(ref.read(audioLyricsProvider.notifier).loadForTrack(item.id));
    await _refreshMediaControls(model: updatedModel, playing: !load || resume);
  }

  int? temporaryQueueStartInDisplay({required bool wrapAround}) {
    final playbackModel = ref.read(playBackModel);
    return playbackModel?.playbackQueue.nextUpStartInDisplay(playbackModel.item.id);
  }

  int? temporaryQueueCountInDisplay() {
    final playbackModel = ref.read(playBackModel);
    return playbackModel?.playbackQueue.nextUpCountInDisplay(playbackModel.item.id);
  }

  List<ItemBaseModel> audioQueueForDisplay({required bool wrapAround}) {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel == null || playbackModel.playbackQueue.queue.isEmpty) {
      return const <ItemBaseModel>[];
    }
    return playbackModel.playbackQueue.queueForDisplay(playbackModel.item.id, wrapAround: wrapAround);
  }

  Future<void> _syncNext() async {
    final player = _player;
    if (!_isAudioQueueMode || player is! LibMPV) return;
    if (ref.read(playBackModel) == null) return;

    await _tryRefillAudioQueue();
    final model = ref.read(playBackModel);
    if (model == null) return;

    final repeatOne = model.playbackQueue.repeatMode == AudioRepeatMode.one;
    await player.setLoopFile(repeatOne);

    final desired = repeatOne ? null : model.playbackQueue.nextItem(model.item.id);
    if (desired?.id == _mpvNext?.id) return;
    if (player.playlistIndex != _mpvCurrentIndex) return;

    if (_mpvNext != null) {
      await player.removeFromPlaylist(_mpvCurrentIndex + 1);
      _mpvNext = null;
    }
    if (desired == null) return;

    final url = await AudioUrlResolver(ref).resolve(desired);
    if (url.isEmpty) return;
    await player.addToPlaylist(url);
    _mpvNext = desired;
  }

  Future<void> _tryRefillAudioQueue() async {
    final playbackModel = ref.read(playBackModel);
    final queueSource = playbackModel?.queueSource;
    if (playbackModel == null || queueSource == null || !queueSource.supportsRefill) return;
    if (_audioQueueSourceDepleted) return;
    if (playbackModel.playbackQueue.queueAheadForPrefetch().length > 5) return;

    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(queueRefilling: true));
    try {
      final fetchedItems = await queueSource.fetchQueue(
        ref.read,
        limit: queueSource.limit,
        startIndex: _audioQueueNextStartIndex,
      );
      _audioQueueNextStartIndex += fetchedItems.length;
      if (fetchedItems.isEmpty) {
        _audioQueueSourceDepleted = true;
        return;
      }

      final currentModel = ref.read(playBackModel);
      if (currentModel == null) return;
      ref.read(playBackModel.notifier).update(
            (_) => currentModel.updatePlaybackQueue(currentModel.playbackQueue.appendToQueue(fetchedItems)),
          );
    } catch (error, stackTrace) {
      log('Audio queue refill failed: $error\n$stackTrace');
    } finally {
      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(queueRefilling: false));
    }
  }

  Future<void> _disableRepeatOneForSkip() async {
    if (ref.read(playBackModel)?.playbackQueue.repeatMode == AudioRepeatMode.one) {
      await setAudioRepeatMode(AudioRepeatMode.all);
    }
  }
}
