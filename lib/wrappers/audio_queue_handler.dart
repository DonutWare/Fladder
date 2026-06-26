part of 'media_control_wrapper.dart';

extension AudioQueueHandler on MediaControlsWrapper {
  void _updateQueueState(PlaybackQueueState Function(PlaybackQueueState) updater) {
    final model = ref.read(playBackModel);
    if (model == null) return;
    ref.read(playBackModel.notifier).update((_) => model.updatePlaybackQueue(updater(model.playbackQueue)));
    unawaited(_syncMpvPlaylist());
  }

  Future<void> _applyReplayGain(ItemBaseModel item) async {
    if (_player is LibMPV) await (_player as LibMPV).applyReplayGainForItem(item);
  }

  Future<void> _withQueueTransition(Future<void> Function() op) async {
    if (_audioQueueTransitioning) return;
    _audioQueueTransitioning = true;
    try {
      await op();
    } catch (error, stackTrace) {
      log('Queue transition error: $error\n$stackTrace');
    } finally {
      _audioQueueTransitioning = false;
    }
  }

  Future<void> loadAudioQueue(
    List<ItemBaseModel> queue,
    int initialIndex,
    Duration startPosition,
    bool startPlayback,
  ) async {
    if (!_isAudioQueueMode) {
      _previousPlayer = _player;
      await _player?.stop();
      await setup(LibMPV());
      _isAudioQueueMode = true;
    }

    _playlistIndexSub?.cancel();
    _prefetchBuffer?.invalidate();
    _prefetchBuffer = AudioPrefetchBuffer();
    _mpvPlaylistItems = [];
    _mpvPlaylistCurrentIndex = 0;
    _audioQueueRefillInProgress = false;
    _audioQueueSourceDepleted = false;
    _audioQueueNextStartIndex = queue.length;
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(queueRefilling: false));

    final resolver = AudioUrlResolver(ref);
    final currentItem = queue[initialIndex.clamp(0, queue.length - 1)];
    _prefetchBuffer!.prefetch(queue.sublist(initialIndex.clamp(0, queue.length - 1)), resolver);

    final firstUrl = await _prefetchBuffer!.getUrl(currentItem.id) ?? await AudioUrlResolver(ref).resolve(currentItem);
    _mpvPlaylistItems = [currentItem];

    await _applyReplayGain(currentItem);
    await _player?.loadVideo(firstUrl, false, startPosition: startPosition);
    _player?.applySubtitleSettings(ref.read(subtitleSettingsProvider));

    _playlistIndexSub = (_player is LibMPV ? (_player as LibMPV).playlistIndexStream : const Stream<int>.empty())
        .listen(_onMpvPlaylistIndexChanged);

    unawaited(_syncMpvPlaylist());

    final context = ref.read(localizationContextProvider);
    if (context != null) {
      ref.read(windowTitleProvider.notifier).setPlayTitle(currentItem.windowTitle(context.localized));
    }

    final playbackModel = ref.read(playBackModel);
    if (playbackModel != null) {
      await _refreshMediaControls(model: playbackModel, playing: false);
    }

    if (startPlayback) {
      await play();
    }
  }

  Future<void> setShuffleEnabled(bool enabled) async {
    final currentId = ref.read(playBackModel)?.item.id;
    _updateQueueState((qs) => qs.withShuffleEnabled(enabled, currentId: currentId));
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(shuffleEnabled: enabled));
  }

  Future<void> setAudioRepeatMode(AudioRepeatMode repeatMode) async {
    _updateQueueState((qs) => qs.withRepeatMode(repeatMode));
    ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(repeatMode: repeatMode));
  }

  Future<void> removeAudioQueueItem(String itemId) async {
    _updateQueueState((qs) => qs.removeItemById(itemId));
  }

  Future<void> removeAudioQueueSectionItem(AudioQueueSection section, int sectionIndex) async {
    _updateQueueState((qs) => qs.removeSectionItem(section, sectionIndex));
  }

  Future<void> reorderAudioQueueSection(AudioQueueSection section, int oldIndex, int newIndex) async {
    _updateQueueState((qs) => qs.reorderSection(section, oldIndex, newIndex));
  }

  List<ItemBaseModel> fullAudioQueue() {
    return ref.read(playBackModel)?.playbackQueue.queue ?? const <ItemBaseModel>[];
  }

  Future<void> addToTemporaryQueue(List<ItemBaseModel> items) async {
    if (items.isEmpty) return;
    if (ref.read(playBackModel) == null) {
      await loadAudioQueue(items, 0, Duration.zero, true);
      return;
    }
    _updateQueueState((qs) => qs.addToNextUp(items));
  }

  void clearTemporaryQueue() {
    _updateQueueState((qs) => qs.clearNextUp());
  }

  Future<void> _onAudioTrackCompleted() async {
    final remainingItems = _mpvPlaylistItems.length - _mpvPlaylistCurrentIndex - 1;
    if (remainingItems > 0) return;
    final playbackModel = ref.read(playBackModel);
    if (playbackModel == null || !_isAudioQueueMode) return;

    if (playbackModel.playbackQueue.repeatMode == AudioRepeatMode.one) {
      await _withQueueTransition(() async {
        await _applyReplayGain(playbackModel.item);
        await _player?.loadVideo(await AudioUrlResolver(ref).resolve(playbackModel.item), true);
      });
      return;
    }

    await _playNextQueueItem();
  }

  Future<void> _playNextQueueItem({Duration startPosition = Duration.zero, bool manual = false}) async {
    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      final fromId = playbackModel.item.id;
      final transition = playbackModel.playbackQueue.nextTransition(fromId);
      if (transition == null) return;
      await _applyQueueItem(transition.item, transition.state, playbackModel, startPosition, manual: manual);
    });
    await _syncMpvPlaylist();
  }

  Future<void> _playPreviousQueueItem() async {
    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      final transition = playbackModel.playbackQueue.previousTransition(playbackModel.item.id);
      if (transition == null) {
        await _player?.seek(Duration.zero);
        return;
      }
      await _applyQueueItem(transition.item, transition.state, playbackModel, Duration.zero, manual: true);
    });
    await _syncMpvPlaylist();
  }

  Future<void> jumpToQueueItem(ItemBaseModel item) async {
    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;

      final newQueueState = playbackModel.playbackQueue.jumpToItem(item.id);

      await _applyQueueItem(item, newQueueState, playbackModel, Duration.zero);
    });
    await _syncMpvPlaylist();
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

  Future<void> _applyQueueItem(
    ItemBaseModel item,
    PlaybackQueueState newQueueState,
    PlaybackModel currentModel,
    Duration startPosition, {
    bool load = true,
    bool manual = false,
  }) async {
    final isChangingItem = currentModel.item.id != item.id;
    if (isChangingItem) {
      final stopPosition = _player?.lastState.position ?? Duration.zero;
      final stopDuration = _player?.lastState.duration ?? currentModel.item.overview.runTime;
      await currentModel.playbackStopped(stopPosition, stopDuration, ref);
    }

    final nextModel = await ref.read(playbackModelHelper).createPlaybackModel(
          null,
          item,
          oldModel: currentModel,
          libraryQueue: newQueueState.queue,
          showPlaybackOptions: false,
          startPosition: startPosition,
        );
    if (nextModel == null) return;

    final latestNextUpQueue = ref.read(playBackModel)?.playbackQueue.nextUpQueue ?? const [];
    final originalNextUpQueue = currentModel.playbackQueue.nextUpQueue;
    final concurrentItems = latestNextUpQueue.where((e) => !originalNextUpQueue.any((q) => q.id == e.id)).toList();
    final mergedQueueState = concurrentItems.isNotEmpty
        ? newQueueState.copyWith(nextUpQueue: [...newQueueState.nextUpQueue, ...concurrentItems])
        : newQueueState;

    final updatedModel = nextModel.updatePlaybackQueue(mergedQueueState);
    ref.read(playBackModel.notifier).update((_) => updatedModel);

    if (load) {
      final url = updatedModel.media?.url ?? '';
      if (_isAudioQueueMode && _player is LibMPV && _shouldCrossfade(currentModel.item, item, manual: manual)) {
        final mpvPlayer = _player as LibMPV;
        double? gainDb;
        if (item is AudioModel) {
          final gain = item.normalizationGain;
          if (gain != null && !gain.isNaN && !gain.isInfinite) {
            gainDb = gain.clamp(-60.0, 20.0).toDouble();
          }
        }
        await mpvPlayer.crossfadeToUrl(url, startPosition, replayGainDb: gainDb);
        _playlistIndexSub?.cancel();
        _playlistIndexSub = mpvPlayer.playlistIndexStream.listen(_onMpvPlaylistIndexChanged);
      } else {
        await _applyReplayGain(item);
        await _player?.loadVideo(url, true, startPosition: startPosition);
      }
      _player?.applySubtitleSettings(ref.read(subtitleSettingsProvider));
      if (_player is LibMPV) {
        _mpvPlaylistItems = [item];
        _mpvPlaylistCurrentIndex = 0;
      }
    }

    final context = ref.read(localizationContextProvider);
    if (context != null) {
      ref.read(windowTitleProvider.notifier).setPlayTitle(item.windowTitle(context.localized));
    }

    await updatedModel.playbackStarted(startPosition, ref);
    await _refreshMediaControls(model: updatedModel, playing: true);
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

  Future<void> _onMpvPlaylistIndexChanged(int newIndex) async {
    if (!_isAudioQueueMode) return;
    if (newIndex < 0 || newIndex >= _mpvPlaylistItems.length || newIndex == _mpvPlaylistCurrentIndex) return;

    _mpvPlaylistCurrentIndex = newIndex;
    if (_audioQueueTransitioning) {
      await _syncMpvPlaylist();
      return;
    }

    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      final newItem = _mpvPlaylistItems[newIndex];
      final fromId = playbackModel.item.id;
      final newQueueState = playbackModel.playbackQueue.advanceFromCurrentTo(fromId, newItem.id);
      await _applyQueueItem(newItem, newQueueState, playbackModel, Duration.zero, load: false);
    });
    await _syncMpvPlaylist();
  }

  Future<void> _syncMpvPlaylist() async {
    if (_syncingPlaylist) {
      _syncPlaylistPending = true;
      return;
    }
    if (!_isAudioQueueMode || _player is! LibMPV) return;
    _syncingPlaylist = true;
    try {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      final player = _player as LibMPV;

      if (_mpvPlaylistItems.isEmpty) {
        _mpvPlaylistCurrentIndex = 0;
        return;
      }
      if (_mpvPlaylistCurrentIndex >= _mpvPlaylistItems.length) {
        _mpvPlaylistCurrentIndex = _mpvPlaylistItems.length - 1;
      }

      for (var i = _mpvPlaylistItems.length - 1; i > _mpvPlaylistCurrentIndex; i--) {
        await player.removeFromPlaylist(i);
      }
      _mpvPlaylistItems = _mpvPlaylistItems.sublist(0, _mpvPlaylistCurrentIndex + 1);

      if (playbackModel.playbackQueue.repeatMode == AudioRepeatMode.one) return;

      final buffer = _prefetchBuffer;
      if (buffer == null) return;
      await _tryRefillAudioQueue(playbackModel, buffer.bufferSize);

      final refreshedModel = ref.read(playBackModel);
      if (refreshedModel == null) return;
      final resolver = AudioUrlResolver(ref);
      final queued = <String>{};

      for (final item in refreshedModel.playbackQueue.queueAheadForPrefetch()) {
        if (queued.contains(item.id)) continue;
        if (_mpvPlaylistItems.length - _mpvPlaylistCurrentIndex - 1 >= buffer.bufferSize) break;

        buffer.prefetch([item], resolver);
        final url = await buffer.getUrl(item.id);
        if (url == null || url.isEmpty) break;

        await player.addToPlaylist(url);
        _mpvPlaylistItems.add(item);
        queued.add(item.id);
      }
    } finally {
      _syncingPlaylist = false;
      if (_syncPlaylistPending) {
        _syncPlaylistPending = false;
        unawaited(_syncMpvPlaylist());
      }
    }
  }

  Future<void> _tryRefillAudioQueue(PlaybackModel playbackModel, int bufferSize) async {
    final queueSource = playbackModel.queueSource;
    if (queueSource == null || !queueSource.supportsRefill) return;
    if (_audioQueueRefillInProgress || _audioQueueSourceDepleted) return;

    final remaining = playbackModel.playbackQueue.queueAheadForPrefetch().length;
    if (remaining > bufferSize) return;

    _audioQueueRefillInProgress = true;
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
      final updatedModel = currentModel.updatePlaybackQueue(
        currentModel.playbackQueue.appendToQueue(fetchedItems),
      );
      ref.read(playBackModel.notifier).update((_) => updatedModel);
    } catch (error, stackTrace) {
      log('Audio queue refill failed: $error\n$stackTrace');
    } finally {
      _audioQueueRefillInProgress = false;
      ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(queueRefilling: false));
    }
  }

  Future<bool> _disableRepeatOneForSkip() async {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel?.playbackQueue.repeatMode == AudioRepeatMode.one) {
      await setAudioRepeatMode(AudioRepeatMode.all);
      return true;
    }
    return false;
  }
}
