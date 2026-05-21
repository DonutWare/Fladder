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
      await _refreshMediaControls(model: playbackModel, playing: startPlayback);
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
    if (_mpvPlaylistItems.length > _mpvPlaylistCurrentIndex + 1) return;
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

  Future<void> _playNextQueueItem({Duration startPosition = Duration.zero}) async {
    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null) return;
      final fromId = playbackModel.item.id;
      final transition = playbackModel.playbackQueue.nextTransition(fromId);
      if (transition == null) return;
      await _applyQueueItem(transition.item, transition.state, playbackModel, startPosition);
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
      await _applyQueueItem(transition.item, transition.state, playbackModel, Duration.zero);
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

  Future<void> _applyQueueItem(
    ItemBaseModel item,
    PlaybackQueueState newQueueState,
    PlaybackModel currentModel,
    Duration startPosition, {
    bool load = true,
  }) async {
    final nextModel = await ref.read(playbackModelHelper).createPlaybackModel(
          null,
          item,
          oldModel: currentModel,
          libraryQueue: newQueueState.queue,
          showPlaybackOptions: false,
          startPosition: startPosition,
        );
    if (nextModel == null) return;

    final updatedModel = nextModel.updatePlaybackQueue(newQueueState);
    ref.read(playBackModel.notifier).update((_) => updatedModel);

    await _applyReplayGain(item);
    if (load) {
      await _player?.loadVideo(updatedModel.media?.url ?? '', true, startPosition: startPosition);
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
    if (newIndex == _mpvPlaylistCurrentIndex || !_isAudioQueueMode) return;

    await _withQueueTransition(() async {
      final playbackModel = ref.read(playBackModel);
      if (playbackModel == null || newIndex >= _mpvPlaylistItems.length) return;
      final newItem = _mpvPlaylistItems[newIndex];
      final fromId = playbackModel.item.id;
      final newQueueState = playbackModel.playbackQueue.advanceFromCurrentTo(fromId, newItem.id);
      _mpvPlaylistCurrentIndex = newIndex;
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

      for (var i = _mpvPlaylistItems.length - 1; i > _mpvPlaylistCurrentIndex; i--) {
        await player.removeFromPlaylist(i);
      }
      _mpvPlaylistItems = _mpvPlaylistItems.sublist(0, _mpvPlaylistCurrentIndex + 1);

      if (playbackModel.playbackQueue.repeatMode == AudioRepeatMode.one) return;

      final buffer = _prefetchBuffer;
      if (buffer == null) return;
      final resolver = AudioUrlResolver(ref);
      final queued = <String>{};

      for (final item in playbackModel.playbackQueue.queueAheadForPrefetch()) {
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

  Future<bool> _disableRepeatOneForSkip() async {
    final playbackModel = ref.read(playBackModel);
    if (playbackModel?.playbackQueue.repeatMode == AudioRepeatMode.one) {
      await setAudioRepeatMode(AudioRepeatMode.all);
      return true;
    }
    return false;
  }
}
