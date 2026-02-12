import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/tv_playback_model.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/book_viewer_provider.dart';
import 'package:fladder/providers/items/book_details_provider.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/book_viewer/book_viewer_screen.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/full_screen_helpers/full_screen_wrapper.dart';

extension BookBaseModelExtension on BookModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    int? currentPage,
    AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel>? provider,
    BuildContext? parentContext,
  }) async {
    if (kIsWeb) {
      FladderSnack.show(context.localized.unableToPlayBooksOnWeb, context: context);
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
      await context.refreshData();
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
    final albumModel = this;
    if (albumModel == null) return;

    final api = ref.read(jellyApiProvider);
    final op = CancelableOperation.fromFuture(api.itemsGet(
        parentId: albumModel.id,
        includeItemTypes: FladderItemType.galleryItem.map((e) => e.dtoKind).toList(),
        recursive: true));

    _showLoadingIndicator(context, albumModel, op);

    final getChildItems = await op.valueOrCancellation(null);
    if (op.isCanceled || getChildItems == null) {
      return;
    }

    final photos = getChildItems.body?.items.whereType<PhotoModel>() ?? [];

    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {
      log('Error closing loading dialog: $e');
    }

    if (photos.isEmpty) {
      return;
    }

    await context.pushRoute(PhotoViewerRoute(
      items: photos.toList(),
    ));

    if (context.mounted) {
      await context.refreshData();
    }
    return;
  }
}

extension ChannelModelExtension on ChannelModel? {
  Future<void> play(
    BuildContext context,
    WidgetRef ref, {
    int? currentPage,
    AutoDisposeStateNotifierProvider<BookDetailsProviderNotifier, BookProviderModel>? provider,
    BuildContext? parentContext,
  }) async {
    if (this == null) return;

    final op = CancelableOperation.fromFuture(ref.read(playbackModelHelper).createPlaybackModel(
          context,
          this,
          forcedPlaybackType: PlaybackType.tv,
          showPlaybackOptions: false,
          startPosition: Duration.zero,
        ));

    _showLoadingIndicator(context, this!, op);

    final model = await op.valueOrCancellation(null);

    if (op.isCanceled || model == null) {
      return;
    }

    if (model is! TvPlaybackModel) {
      return;
    }

    await _playVideo(
      context,
      startPosition: Duration.zero,
      current: model.copyWith(
        channel: this,
      ),
      ref: ref,
      cancelOperation: op,
    );
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
        ChannelModel channel => channel.play(context, ref),
        _ => _default(context, this, ref, startPosition: startPosition, showPlaybackOption: showPlaybackOption),
      };

  Future<void> _default(
    BuildContext context,
    ItemBaseModel? itemModel,
    WidgetRef ref, {
    Duration? startPosition,
    bool showPlaybackOption = false,
  }) async {
    if (itemModel == null) return;

    await ref.read(videoPlayerProvider.notifier).init();

    final op = CancelableOperation.fromFuture(ref.read(playbackModelHelper).createPlaybackModel(
          context,
          itemModel,
          showPlaybackOptions: showPlaybackOption,
          startPosition: startPosition,
        ));

    _showLoadingIndicator(context, itemModel, op);

    final model = await op.valueOrCancellation(null);
    if (op.isCanceled || model == null) return;

    await _playVideo(context, startPosition: startPosition, current: model, ref: ref, cancelOperation: op);
  }
}

extension ItemBaseModelsBooleans on List<ItemBaseModel> {
  Future<void> playLibraryItems(BuildContext context, WidgetRef ref, {bool shuffle = false}) async {
    if (isEmpty) return;

    final op = CancelableOperation.fromFuture(Future(() async {
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

      PlaybackModel? model = await ref.read(playbackModelHelper).createPlaybackModel(
            context,
            expandedList.firstOrNull,
            libraryQueue: expandedList,
          );

      return (model, expandedList);
    }));

    _showLoadingIndicator(context, null, op);

    final result = await op.valueOrCancellation(null);
    if (op.isCanceled || result == null) return;

    final PlaybackModel? model = result.$1;
    final List<ItemBaseModel> expandedList = result.$2;

    if (context.mounted) {
      await _playVideo(context, ref: ref, queue: expandedList, current: model, cancelOperation: op);
      if (context.mounted) {
        RefreshState.maybeOf(context)?.refresh();
      }
    }
  }
}

Future<void> _showLoadingIndicator(BuildContext context, ItemBaseModel? item, CancelableOperation op) async {
  return showDialog(
    barrierDismissible: false,
    useRootNavigator: true,
    context: context,
    builder: (context) => _LoadIndicatorCancelable(op: op, item: item),
  );
}

class _LoadIndicatorCancelable extends StatelessWidget {
  final ItemBaseModel? item;
  final CancelableOperation op;
  const _LoadIndicatorCancelable({required this.op, this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(
        maxWidth: 450,
        maxHeight: 500,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: Row(
                spacing: 16,
                children: [
                  if (item != null)
                    Flexible(
                      child: Container(
                        decoration: FladderTheme.defaultPosterDecoration,
                        clipBehavior: Clip.hardEdge,
                        height: 175,
                        child: AspectRatio(
                          aspectRatio: 0.7,
                          child: SquareProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                            strokeCap: StrokeCap.round,
                            strokeWidth: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: FladderTheme.defaultPosterDecoration,
                                clipBehavior: Clip.hardEdge,
                                child: FladderImage(
                                  image: item!.getPosters?.primary,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SquareProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        Text(
                          context.localized.loading,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (item != null) ...[
                          Text(
                            item!.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: context.localized.close,
              autofocus: AdaptiveLayout.of(context).isDesktop,
              onPressed: () {
                try {
                  op.cancel();
                } catch (_) {}
                Navigator.of(context, rootNavigator: true).pop();
              },
              icon: const Icon(IconsaxPlusLinear.close_square),
            ),
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
  CancelableOperation? cancelOperation,
}) async {
  if (current == null) {
    if (context.mounted) {
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (e) {
        log('Error closing loading dialog: $e');
      }
      FladderSnack.show(context.localized.unableToPlayMedia, context: context);
    }
    return;
  }

  if (cancelOperation?.isCanceled ?? false) return;

  final actualStartPosition = startPosition ?? await current.startDuration() ?? Duration.zero;

  final loadedCorrectly = await ref.read(videoPlayerProvider.notifier).loadPlaybackItem(
        current,
        actualStartPosition,
      );

  if (!loadedCorrectly) {
    if (context.mounted) {
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (e) {
        log('Error closing loading dialog: $e');
      }
      FladderSnack.show(context.localized.errorOpeningMedia, context: context);
    }
    return;
  }

  if (cancelOperation?.isCanceled ?? false) return;

  try {
    Navigator.of(context, rootNavigator: true).pop();
  } catch (_) {}

  ref.read(mediaPlaybackProvider.notifier).update((state) => state.copyWith(state: VideoPlayerState.fullScreen));

  if (cancelOperation?.isCanceled ?? false) return;

  await ref.read(videoPlayerProvider.notifier).openPlayer(context);
  if (AdaptiveLayout.of(context).isDesktop && defaultTargetPlatform != TargetPlatform.macOS) {
    fullScreenHelper.closeFullScreen(ref);
  }

  if (context.mounted) {
    if (cancelOperation?.isCanceled ?? false) return;
    await context.refreshData();
  }

  onPlayerExit?.call();
}
