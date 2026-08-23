part of 'play_item_helpers.dart';

const _playlistAudioInitialQueueLimit = 5;
const _playlistAudioRefillLimit = 100;

extension PlaylistModelPlayback on PlaylistModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    Duration? startPosition,
    bool showPlaybackOption = false,
  }) async {
    final playlist = this;
    if (playlist == null) return;

    await ref.read(videoPlayerProvider.notifier).init();

    final op = CancelableOperation.fromFuture(Future(() async {
      final previewItems = await _fetchPlaylistItems(playlist.id, ref, maxItems: 50);
      final previewClassification = _classifyPlaylistItems(previewItems);

      if (!previewClassification.hasAny) return null;

      final actionCount = [
        previewClassification.hasPlayable,
        previewClassification.hasMusic,
        previewClassification.hasGallery,
      ].where((value) => value).length;

      if (actionCount > 1) {
        return (
          classification: previewClassification,
          model: null,
          queue: <ItemBaseModel>[],
          isAudio: false,
          photos: <PhotoModel>[]
        );
      }

      if (previewClassification.hasMusic) {
        final queueSource = PlaylistAudioQueueSource(
          playlistId: playlist.id,
          limit: _playlistAudioRefillLimit,
        );
        final initialQueue = await queueSource.fetchQueue(
          ref.read,
          limit: _playlistAudioInitialQueueLimit,
          startIndex: 0,
        );
        if (initialQueue.isEmpty) return null;
        final model = await ref.read(playbackModelHelper).createPlaybackModel(
              context,
              initialQueue.firstOrNull,
              libraryQueue: initialQueue,
              queueSource: queueSource,
            );
        return (classification: null, model: model, queue: initialQueue, isAudio: true, photos: <PhotoModel>[]);
      }

      final fullItems = await _fetchPlaylistItems(playlist.id, ref);
      final full = _classifyPlaylistItems(fullItems);

      if (previewClassification.hasPlayable) {
        if (full.playable.isEmpty) return null;
        final model = await ref.read(playbackModelHelper).createPlaybackModel(
              context,
              full.playable.firstOrNull,
              libraryQueue: full.playable,
            );
        return (classification: null, model: model, queue: full.playable, isAudio: false, photos: <PhotoModel>[]);
      }

      return (classification: null, model: null, queue: <ItemBaseModel>[], isAudio: false, photos: full.gallery);
    }));

    _showLoadingIndicator(context, playlist, op);

    final result = await op.valueOrCancellation(null);

    if (!op.isCanceled) {
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (_) {}
    }

    if (op.isCanceled || result == null) {
      if (!op.isCanceled && context.mounted) {
        FladderSnack.show(context.localized.unableToPlayMedia, context: context);
      }
      return;
    }

    if (!context.mounted) return;

    if (result.classification != null) {
      final classification = result.classification!;
      await showLibraryPlayOptions(
        context,
        context.localized.libraryPlayItems,
        playVideos: classification.hasPlayable ? () => _playPlaylistVideos(context, ref, playlist.id) : null,
        playMusic: classification.hasMusic ? () => _playPlaylistMusic(context, ref, playlist.id) : null,
        viewGallery: classification.hasGallery ? () => _playPlaylistGallery(context, ref, playlist.id) : null,
      );
      return;
    }

    if (result.photos.isNotEmpty) {
      await context.pushRoute(PhotoViewerRoute(items: result.photos));
      if (context.mounted) await context.refreshData();
      return;
    }

    if (result.model == null || result.queue.isEmpty) {
      FladderSnack.show(context.localized.unableToPlayMedia, context: context);
      return;
    }

    final model = result.model!;
    final queue = result.queue;

    if (result.isAudio) {
      final currentIndex = queue.indexWhere((e) => e.id == model.item.id).clamp(0, queue.length - 1);
      final actualStartPosition = startPosition ?? await model.startDuration() ?? Duration.zero;
      await ref
          .read(videoPlayerProvider.notifier)
          .loadAudioPlaybackItem(model, queue, currentIndex, actualStartPosition);
    } else {
      final actualStartPosition = startPosition ?? await model.startDuration() ?? Duration.zero;
      final loadedCorrectly = await ref.read(videoPlayerProvider.notifier).loadPlaybackItem(model, actualStartPosition);
      if (!loadedCorrectly) {
        if (context.mounted) FladderSnack.show(context.localized.errorOpeningMedia, context: context);
        return;
      }
      await ref.read(videoPlayerProvider.notifier).openPlayer(context);
      if (AdaptiveLayout.of(context).isDesktop && defaultTargetPlatform != TargetPlatform.macOS) {
        fullScreenHelper.closeFullScreen(ref);
      }
      if (context.mounted) await context.refreshData();
    }
  }
}

Future<void> _playPlaylistMusic(BuildContext context, WidgetRef ref, String playlistId) async {
  await ref.read(videoPlayerProvider.notifier).init();

  final op = CancelableOperation.fromFuture(Future(() async {
    final queueSource = PlaylistAudioQueueSource(
      playlistId: playlistId,
      limit: _playlistAudioRefillLimit,
    );
    final initialQueue = await queueSource.fetchQueue(
      ref.read,
      limit: _playlistAudioInitialQueueLimit,
      startIndex: 0,
    );
    if (initialQueue.isEmpty) return null;
    final model = await ref.read(playbackModelHelper).createPlaybackModel(
          context,
          initialQueue.firstOrNull,
          libraryQueue: initialQueue,
          queueSource: queueSource,
        );
    if (model == null) return null;
    return (model, initialQueue);
  }));

  _showLoadingIndicator(context, null, op);

  final result = await op.valueOrCancellation(null);

  if (!op.isCanceled) {
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {}
  }

  if (op.isCanceled || result == null) {
    if (!op.isCanceled && context.mounted) {
      FladderSnack.show(context.localized.unableToPlayMedia, context: context);
    }
    return;
  }

  final (model, queue) = result;
  final currentIndex = queue.indexWhere((e) => e.id == model.item.id).clamp(0, queue.length - 1);
  final actualStartPosition = await model.startDuration() ?? Duration.zero;
  await ref.read(videoPlayerProvider.notifier).loadAudioPlaybackItem(model, queue, currentIndex, actualStartPosition);
}

Future<void> _playPlaylistVideos(BuildContext context, WidgetRef ref, String playlistId) async {
  await ref.read(videoPlayerProvider.notifier).init();

  final op = CancelableOperation.fromFuture(Future(() async {
    final items = await _fetchPlaylistItems(playlistId, ref);
    final classified = _classifyPlaylistItems(items);
    if (classified.playable.isEmpty) return null;
    final model = await ref.read(playbackModelHelper).createPlaybackModel(
          context,
          classified.playable.firstOrNull,
          libraryQueue: classified.playable,
        );
    if (model == null) return null;
    return (model, classified.playable);
  }));

  _showLoadingIndicator(context, null, op);

  final result = await op.valueOrCancellation(null);

  if (!op.isCanceled) {
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {}
  }

  if (op.isCanceled || result == null) {
    if (!op.isCanceled && context.mounted) {
      FladderSnack.show(context.localized.unableToPlayMedia, context: context);
    }
    return;
  }

  final (model, queue) = result;
  final actualStartPosition = await model.startDuration() ?? Duration.zero;
  final loadedCorrectly = await ref.read(videoPlayerProvider.notifier).loadPlaybackItem(model, actualStartPosition);
  if (!loadedCorrectly) {
    if (context.mounted) FladderSnack.show(context.localized.errorOpeningMedia, context: context);
    return;
  }
  await ref.read(videoPlayerProvider.notifier).openPlayer(context);
  if (AdaptiveLayout.of(context).isDesktop && defaultTargetPlatform != TargetPlatform.macOS) {
    fullScreenHelper.closeFullScreen(ref);
  }
  if (context.mounted) await context.refreshData();
}

Future<void> _playPlaylistGallery(BuildContext context, WidgetRef ref, String playlistId) async {
  final op = CancelableOperation.fromFuture(Future(() async {
    final items = await _fetchPlaylistItems(playlistId, ref);
    return _classifyPlaylistItems(items).gallery;
  }));

  _showLoadingIndicator(context, null, op);

  final photos = await op.valueOrCancellation(null);

  if (!op.isCanceled) {
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {}
  }

  if (op.isCanceled || photos == null || photos.isEmpty) {
    if (!op.isCanceled && context.mounted) {
      FladderSnack.show(context.localized.unableToPlayMedia, context: context);
    }
    return;
  }

  if (context.mounted) {
    await context.pushRoute(PhotoViewerRoute(items: photos));
    if (context.mounted) await context.refreshData();
  }
}

class _PlaylistClassification {
  final List<ItemBaseModel> playable;
  final List<ItemBaseModel> music;
  final List<PhotoModel> gallery;

  const _PlaylistClassification({
    required this.playable,
    required this.music,
    required this.gallery,
  });

  bool get hasPlayable => playable.isNotEmpty;
  bool get hasMusic => music.isNotEmpty;
  bool get hasGallery => gallery.isNotEmpty;
  bool get hasAny => hasPlayable || hasMusic || hasGallery;
}

_PlaylistClassification _classifyPlaylistItems(List<ItemBaseModel> items) {
  return _PlaylistClassification(
    playable: items.where((item) => FladderItemType.playable.contains(item.type)).toList(),
    music: items.where((item) => FladderItemType.musicPlayable.contains(item.type)).toList(),
    gallery: items.whereType<PhotoModel>().toList(),
  );
}

Future<List<ItemBaseModel>> _fetchPlaylistItems(String playlistId, WidgetRef ref, {int? maxItems}) async {
  const pageSize = 100;
  var startIndex = 0;
  final items = <ItemBaseModel>[];

  while (true) {
    final remaining = maxItems != null ? maxItems - items.length : pageSize;
    if (remaining <= 0) break;

    final requestLimit = min(pageSize, remaining);
    final response = await ref.read(jellyApiProvider).playlistsPlaylistIdItemsGet(
      playlistId: playlistId,
      startIndex: startIndex,
      limit: requestLimit,
      enableUserData: true,
      enableImages: true,
      imageTypeLimit: 1,
      fields: [
        ItemFields.primaryimageaspectratio,
        ItemFields.mediasources,
        ItemFields.mediastreams,
        ItemFields.parentid,
        ItemFields.overview,
      ],
    );

    final pageItems = response.body?.items ?? const <ItemBaseModel>[];
    if (pageItems.isEmpty) break;

    items.addAll(pageItems);
    startIndex += pageItems.length;

    final totalCount = response.body?.totalRecordCount;
    if (totalCount != null && startIndex >= totalCount) {
      break;
    }

    if (pageItems.length < requestLimit) {
      break;
    }
  }

  return items;
}
