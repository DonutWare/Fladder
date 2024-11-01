import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/book_viewer_provider.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/book_viewer/book_viewer_screen.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/screens/video_player/video_player.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';

Future<void> _showLoadingIndicator(BuildContext context) async {
  return showDialog(
    barrierDismissible: kDebugMode,
    useRootNavigator: true,
    context: context,
    builder: (context) => const LoadIndicator(),
  );
}

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(strokeCap: StrokeCap.round),
            const SizedBox(width: 70),
            Text(
              "Loading",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

Future<void> _playVideo(
  BuildContext context, {
  required PlaybackModel? current,
  Duration? startPosition,
  List<ItemBaseModel>? queue,
  required WidgetRef ref,
  VoidCallback? onPlayerExit,
}) async {
  if (current == null) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      fladderSnackbar(context, title: context.localized.unableToPlayMedia);
    }
    return;
  }

  final loadedCorrectly = await ref.read(videoPlayerProvider.notifier).loadPlaybackItem(
        current,
        startPosition: startPosition,
      );

  if (!loadedCorrectly) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      fladderSnackbar(context, title: context.localized.errorOpeningMedia);
    }
    return;
  }

  //Pop loading screen
  Navigator.of(context, rootNavigator: true).pop();

  ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.fullScreen));

  if (context.mounted) {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const VideoPlayer(),
      ),
    );
    if (AdaptiveLayout.of(context).isDesktop) {
      final fullScreen = await windowManager.isFullScreen();
      if (fullScreen) {
        await windowManager.setFullScreen(false);
      }
    }
    if (context.mounted) {
      context.refreshData();
    }
    onPlayerExit?.call();
  }
}

extension BookBaseModelExtension on BookModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    int? currentPage,
    AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel>? provider,
    BuildContext? parentContext,
  }) async {
    if (kIsWeb) {
      fladderSnackbar(context, title: context.localized.unableToPlayBooksOnWeb);
      return;
    }
    if (this == null) {
      return;
    }
    var newProvider = provider;

    if (newProvider == null) {
      newProvider = bookDetailsProvider(this?.id ?? "");
      await ref.watch(bookDetailsProvider(this?.id ?? "").notifier).fetchDetails(this!);
    }

    ref.read(bookViewerProvider.notifier).fetchBook(this);
    await openBookViewer(
      context,
      newProvider,
      initialPage: currentPage ?? this?.currentPage,
    );
    parentContext?.refreshData();
    if (context.mounted) {
      context.refreshData();
    }
  }
}

extension PhotoAlbumExtension on PhotoAlbumModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    int? currentPage,
    AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel>? provider,
    BuildContext? parentContext,
  }) async {
    _showLoadingIndicator(context);

    final albumModel = this;
    if (albumModel == null) return;
    final api = ref.read(jellyApiProvider);
    final getChildItems = await api.itemsGet(
        parentId: albumModel.id,
        includeItemTypes: FladderItemType.galleryItem.map((e) => e.dtoKind).toList(),
        recursive: true);
    final photos = getChildItems.body?.items.whereType<PhotoModel>() ?? [];

    Navigator.of(context, rootNavigator: true).pop();

    if (photos.isEmpty) {
      return;
    }

    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => PhotoViewerScreen(
          items: photos.toList(),
        ),
      ),
    );
    if (context.mounted) {
      context.refreshData();
    }
    return;
  }
}

extension ItemBaseModelExtensions on ItemBaseModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    Duration? startPosition,
    bool showPlaybackOption = false,
  }) async =>
      switch (this) {
        PhotoAlbumModel album => album.play(context, ref),
        BookModel book => book.play(context, ref),
        _ => _default(context, this, ref, startPosition: startPosition),
      };

  Future<void> _default(
    BuildContext context,
    ItemBaseModel? itemModel,
    WidgetRef ref, {
    Duration? startPosition,
    bool showPlaybackOption = false,
  }) async {
    if (itemModel == null) return;

    _showLoadingIndicator(context);

    SyncedItem? syncedItem = ref.read(syncProvider.notifier).getSyncedItem(this);

    final options = {
      PlaybackType.directStream,
      PlaybackType.transcode,
      if (syncedItem != null && syncedItem.status == SyncStatus.complete) PlaybackType.offline,
    };

    PlaybackModel? model;

    if (showPlaybackOption) {
      final playbackType = await _showPlaybackTypeSelection(
        context: context,
        options: options,
      );

      model = switch (playbackType) {
        PlaybackType.directStream || PlaybackType.transcode => await ref
            .read(playbackModelHelper)
            .createServerPlaybackModel(itemModel, playbackType, startPosition: startPosition),
        PlaybackType.offline => await ref.read(playbackModelHelper).createOfflinePlaybackModel(itemModel, syncedItem),
        null => null
      };
    } else {
      model = (await ref.read(playbackModelHelper).createServerPlaybackModel(itemModel, PlaybackType.directStream)) ??
          await ref.read(playbackModelHelper).createOfflinePlaybackModel(itemModel, syncedItem);
    }

    await _playVideo(context, startPosition: startPosition, current: model, ref: ref);
  }
}

extension ItemBaseModelsBooleans on List<ItemBaseModel> {
  Future<void> playLibraryItems(BuildContext context, WidgetRef ref, {bool shuffle = false}) async {
    if (isEmpty) return;

    _showLoadingIndicator(context);

    // Replace all shows/seasons with all episodes
    List<List<ItemBaseModel>> newList = await Future.wait(map((element) async {
      switch (element.type) {
        case FladderItemType.series:
          return await ref.read(jellyApiProvider).fetchEpisodeFromShow(seriesId: element.id);
        default:
          return [element];
      }
    }));

    var expandedList =
        newList.expand((element) => element).toList().where((element) => element.playAble).toList().uniqueBy(
              (value) => value.id,
            );

    if (shuffle) {
      expandedList.shuffle();
    }

    PlaybackModel? model = await ref.read(playbackModelHelper).createServerPlaybackModel(
          expandedList.firstOrNull,
          PlaybackType.directStream,
          libraryQueue: expandedList,
        );

    if (context.mounted) {
      await _playVideo(context, ref: ref, queue: expandedList, current: model);
      if (context.mounted) {
        RefreshState.of(context).refresh();
      }
    }
  }
}

Future<PlaybackType?> _showPlaybackTypeSelection({
  required BuildContext context,
  required Set<PlaybackType> options,
}) async {
  PlaybackType? playbackType;

  await showDialogAdaptive(
    context: context,
    builder: (context) {
      return PlaybackDialogue(
        options: options,
        onClose: (type) {
          playbackType = type;
          Navigator.of(context).pop();
        },
      );
    },
  );
  return playbackType;
}

class PlaybackDialogue extends StatelessWidget {
  final Set<PlaybackType> options;
  final Function(PlaybackType type) onClose;
  const PlaybackDialogue({required this.options, required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).add(const EdgeInsets.only(top: 16, bottom: 8)),
          child: Text(
            "Playback type",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(),
        ...options.map((type) => ListTile(
              title: Text(type.name),
              leading: Icon(type.icon),
              onTap: () {
                onClose(type);
              },
            ))
      ],
    );
  }
}
