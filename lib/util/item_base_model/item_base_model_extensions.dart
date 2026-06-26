import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:share_plus/share_plus.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/collections/add_to_collection.dart';
import 'package:fladder/screens/metadata/edit_item.dart';
import 'package:fladder/screens/metadata/identifty_screen.dart';
import 'package:fladder/screens/metadata/info_screen.dart';
import 'package:fladder/screens/metadata/refresh_metadata.dart';
import 'package:fladder/screens/playlists/add_to_playlists.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/screens/syncing/sync_item_details.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/src/wallpaper_api.g.dart';
import 'package:fladder/util/clipboard_helper.dart';
import 'package:fladder/util/custom_cache_manager.dart';
import 'package:fladder/util/file_downloader.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/pop_up/delete_file.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

extension ItemBaseModelsBooleans on List<ItemBaseModel> {
  Map<FladderItemType, List<ItemBaseModel>> get groupedItems {
    Map<FladderItemType, List<ItemBaseModel>> groupedItems = {};
    for (int i = 0; i < length; i++) {
      FladderItemType type = this[i].type;
      if (!groupedItems.containsKey(type)) {
        groupedItems[type] = [this[i]];
      } else {
        groupedItems[type]?.add(this[i]);
      }
    }
    return groupedItems;
  }

  FladderItemType get getMostCommonType {
    if (isEmpty) return FladderItemType.movie;
    final Map<FladderItemType, int> counts = {};

    for (final item in this) {
      final type = item.type;
      counts[type] = (counts[type] ?? 0) + 1;
    }

    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  double? getMostCommonAspectRatio({double tolerance = 0.01}) {
    final Map<int, List<double>> buckets = {};

    for (final item in this) {
      final aspectRatio = item.primaryRatio;
      if (aspectRatio == null) continue;

      final bucketKey = (aspectRatio / tolerance).round();

      buckets.putIfAbsent(bucketKey, () => []).add(aspectRatio);
    }

    if (buckets.isEmpty) return null;

    final mostCommonBucket = buckets.entries.reduce((a, b) => a.value.length >= b.value.length ? a : b);

    final average = mostCommonBucket.value.reduce((a, b) => a + b) / mostCommonBucket.value.length;
    return average;
  }
}

enum ItemActions {
  play,
  addToQueue,
  instantMix,
  openShow,
  openParent,
  details,
  showAlbum,
  playFromStart,
  addCollection,
  addPlaylist,
  markPlayed,
  markUnplayed,
  setFavorite,
  refreshMetaData,
  editMetaData,
  mediaInfo,
  identify,
  download,
  setAsWallpaper,
  share,
}

extension ItemBaseModelExtensions on ItemBaseModel {
  Future<void> showDetailsMenu(BuildContext context, WidgetRef ref, Offset globalPos) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: generateActions(
        context,
        ref,
      ).popupMenuItems(useIcons: true),
    );
  }

  List<ItemAction> generateActions(
    BuildContext context,
    WidgetRef ref, {
    List<ItemAction> otherActions = const [],
    Set<ItemActions> exclude = const {},
    Function(UserData? newData)? onUserDataChanged,
    Function(ItemBaseModel item)? onItemUpdated,
    Function(ItemBaseModel item)? onDeleteSuccesFully,
  }) {
    final isAdmin = ref.read(userProvider)?.policy?.isAdministrator ?? false;
    final downloadEnabled = ref.read(userProvider.select(
          (value) => value?.canDownload ?? false,
        )) &&
        syncAble &&
        (canDownload ?? false);
    final downloadUrl = ref.read(userProvider.notifier).createDownloadUrl(this);
    final syncedItemFuture = ref.read(syncProvider.notifier).getSyncedItem(id);
    final hasSeerrData = overview.seerrUrl?.isNotEmpty == true;
    final showMarkAs = switch (this) {
      AlbumModel() => false,
      ArtistModel() => false,
      _ => true,
    };
    final ItemAction? parentAction = switch (this) {
      EpisodeModel _ => !exclude.contains(ItemActions.openShow)
          ? ItemActionButton(
              icon: Icon(FladderItemType.series.icon),
              action: () => parentBaseModel.navigateTo(context),
              label: Text(context.localized.openShow),
            )
          : null,
      AudioModel _ => !exclude.contains(ItemActions.openParent)
          ? ItemActionButton(
              icon: Icon(FladderItemType.musicAlbum.icon),
              action: () => parentBaseModel.navigateTo(context),
              label: Text(context.localized.showAlbum),
            )
          : null,
      AlbumModel album => !exclude.contains(ItemActions.openParent)
          ? ItemActionButton(
              icon: Icon(FladderItemType.musicArtist.icon),
              action: () => album.parentBaseModel.navigateTo(context),
              label: Text(context.localized.showArtist),
            )
          : null,
      SeriesModel _ => null,
      _ => !exclude.contains(ItemActions.openParent) && !galleryItem
          ? ItemActionButton(
              icon: Icon(FladderItemType.folder.icon),
              action: () => parentBaseModel.navigateTo(context),
              label: Text(context.localized.openParent),
            )
          : null,
    };
    return [
      if (!exclude.contains(ItemActions.play))
        if (playAble)
          ItemActionButton(
            action: () => play(context, ref),
            icon: const Icon(IconsaxPlusLinear.play),
            label: Text(playButtonLabel(context.localized)),
          ),
      if (!exclude.contains(ItemActions.addToQueue))
        if (this is AudioModel || this is AlbumModel || this is ArtistModel)
          ItemActionButton(
            action: () => switch (this) {
              AudioModel audio => audio.addToQueue(context, ref),
              AlbumModel album => album.addToQueue(context, ref),
              ArtistModel artist => artist.addToQueue(context, ref),
              _ => Future.value(),
            },
            icon: const Icon(IconsaxPlusLinear.music_playlist),
            label: Text(context.localized.addToQueue),
          ),
      if (!exclude.contains(ItemActions.instantMix))
        if (this is AudioModel || this is AlbumModel || this is ArtistModel)
          ItemActionButton(
            action: () => switch (this) {
              AudioModel audio => audio.playInstantMix(context, ref),
              AlbumModel album => album.playInstantMix(context, ref),
              ArtistModel artist => artist.playInstantMix(context, ref),
              _ => Future.value(),
            },
            icon: const Icon(IconsaxPlusLinear.blend_2),
            label: Text(context.localized.instantMix),
          ),
      if (parentAction != null) parentAction,
      if (!galleryItem && !exclude.contains(ItemActions.details))
        ItemActionButton(
          action: () async => await navigateTo(context),
          icon: const Icon(IconsaxPlusLinear.main_component),
          label: Text(context.localized.showDetails),
        )
      else if (!exclude.contains(ItemActions.showAlbum) && galleryItem)
        ItemActionButton(
          icon: Icon(FladderItemType.photoAlbum.icon),
          action: () => parentBaseModel.navigateTo(context),
          label: Text(context.localized.showAlbum),
        ),
      if (this case PhotoModel photo) ...[
        if (!kIsWeb && !exclude.contains(ItemActions.setAsWallpaper) && defaultTargetPlatform == TargetPlatform.android)
          ItemActionButton(
            action: () => setAsWallpaper(photo, ref),
            icon: const Icon(IconsaxPlusLinear.document_upload),
            label: Text(context.localized.setAs),
          ),
        if (!exclude.contains(ItemActions.share))
          ItemActionButton(
            action: () => sharePhoto(photo, ref),
            icon: const Icon(IconsaxPlusLinear.share),
            label: Text(context.localized.share),
          ),
      ],
      if (!exclude.contains(ItemActions.playFromStart))
        if ((userData.progress) > 0)
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.refresh),
            action: (this is BookModel)
                ? () => ((this as BookModel).play(context, ref, currentPage: 0))
                : () => play(context, ref, startPosition: Duration.zero),
            label: Text((this is BookModel)
                ? context.localized.readFromStart(name)
                : context.localized.playFromStart(subTextShort(context.localized) ?? name)),
          ),
      ItemActionDivider(),
      if (!exclude.contains(ItemActions.addCollection) && isAdmin)
        if (type != FladderItemType.boxset)
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.archive_add),
            action: () async {
              await addItemToCollection(context, [this]);
              if (context.mounted) {
                context.refreshData();
              }
            },
            label: Text(context.localized.addToCollection),
          ),
      if (!exclude.contains(ItemActions.addPlaylist))
        if (type != FladderItemType.playlist)
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.archive_add),
            action: () async {
              await addItemToPlaylist(context, [this]);
              if (context.mounted) {
                context.refreshData();
              }
            },
            label: Text(context.localized.addToPlaylist),
          ),
      if (showMarkAs) ...[
        if (!exclude.contains(ItemActions.markPlayed))
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.eye),
            action: () async {
              try {
                final userData = await ref.read(userProvider.notifier).markAsPlayed(true, id);
                onUserDataChanged?.call(userData?.bodyOrThrow);
              } finally {
                context.refreshData();
              }
            },
            label: Text(context.localized.markAsWatched),
          ),
        if (!exclude.contains(ItemActions.markUnplayed))
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.eye_slash),
            label: Text(context.localized.markAsUnwatched),
            action: () async {
              try {
                final userData = await ref.read(userProvider.notifier).markAsPlayed(false, id);
                onUserDataChanged?.call(userData?.bodyOrThrow);
              } finally {
                context.refreshData();
              }
            },
          ),
      ],
      if (!exclude.contains(ItemActions.setFavorite))
        ItemActionButton(
          icon: Icon(userData.isFavourite ? IconsaxPlusLinear.heart_remove : IconsaxPlusLinear.heart_add),
          action: () async {
            try {
              final newData = await ref.read(userProvider.notifier).setAsFavorite(!userData.isFavourite, id);
              onUserDataChanged?.call(newData?.bodyOrThrow);
            } finally {
              context.refreshData();
            }
          },
          label: Text(userData.isFavourite ? context.localized.removeAsFavorite : context.localized.addAsFavorite),
        ),
      ...otherActions,
      ItemActionDivider(),
      if (!exclude.contains(ItemActions.editMetaData) && isAdmin)
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.edit),
          action: () async {
            final newItem = await showEditItemPopup(context, id);
            if (newItem != null) {
              onItemUpdated?.call(newItem);
            }
          },
          label: Text(context.localized.editMetadata),
        ),
      if (!exclude.contains(ItemActions.refreshMetaData) && isAdmin)
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.global_refresh),
          action: () async {
            showRefreshPopup(context, id, detailedName(context.localized) ?? name);
          },
          label: Text(context.localized.refreshMetadata),
        ),
      if (!exclude.contains(ItemActions.download) && downloadEnabled) ...[
        if (!kIsWeb)
          ItemActionButton(
            icon: FutureBuilder(
              future: syncedItemFuture,
              builder: (context, snapshot) {
                final syncedItem = snapshot.data;
                if (syncedItem != null) {
                  return IgnorePointer(child: SyncButton(item: this, syncedItem: syncedItem));
                }
                return const Icon(IconsaxPlusLinear.arrow_down_2);
              },
            ),
            label: FutureBuilder(
              future: syncedItemFuture,
              builder: (context, snapshot) {
                final syncedItem = snapshot.data;
                if (syncedItem != null) {
                  return Text(
                    context.localized.syncDetails,
                  );
                }
                return Text(context.localized.sync);
              },
            ),
            action: () async {
              final syncedItem = await syncedItemFuture;
              if (syncedItem != null) {
                await showSyncItemDetails(context, syncedItem, ref);
              } else {
                await ref.read(syncProvider.notifier).addSyncItem(context, this);
              }
              context.refreshData();
            },
          )
        else if (downloadUrl != null) ...[
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.document_download),
            action: () => downloadFile(downloadUrl),
            label: Text(context.localized.downloadFile(type.label(context.localized).toLowerCase())),
          ),
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.link_21),
            action: () => context.copyToClipboard(downloadUrl),
            label: Text(context.localized.copyStreamUrl),
          )
        ],
      ],
      if (hasSeerrData && tmdbId != null)
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.link_21),
          action: () {
            context.pushRoute(SeerrDetailsRoute(
                mediaType: switch (this) {
                  MovieModel() => SeerrMediaType.movie,
                  SeriesModel() => SeerrMediaType.tvshow,
                  _ => SeerrMediaType.movie,
                }
                    .name,
                tmdbId: tmdbId!));
          },
          label: Text(context.localized.seerrDetails),
        ),
      if (canDelete == true)
        ItemActionButton(
          icon: Container(
            child: const Icon(
              IconsaxPlusLinear.trash,
            ),
          ),
          action: () async {
            final response = await FladderSnack.showResponse(
              showDeleteDialog(context, this, ref),
              successTitle: context.localized.deletedItem(name),
            );
            if (response.isSuccess) {
              onDeleteSuccesFully?.call(this);
              if (context.mounted) {
                context.refreshData();
              }
            }
          },
          label: Text(context.localized.delete),
        ),
      if (!exclude.contains(ItemActions.identify) && identifiable && isAdmin)
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.search_normal),
          action: () async {
            showIdentifyScreen(context, this);
          },
          label: Text(context.localized.identify),
        ),
      if (!exclude.contains(ItemActions.mediaInfo))
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.info_circle),
          action: () async {
            showInfoScreen(context, this);
          },
          label: Text("${type.label(context.localized)} ${context.localized.info}"),
        ),
    ];
  }

  Future<void> setAsWallpaper(PhotoModel photo, WidgetRef ref) async {
    final file = await CustomCacheManager.instance.getSingleFile(photo.downloadPath(ref));
    await WallpaperApi().openWallpaperPopup(file.path);
    await file.delete();
  }

  Future<void> sharePhoto(PhotoModel photo, WidgetRef ref) async {
    final file = await CustomCacheManager.instance.getSingleFile(photo.downloadPath(ref));
    await SharePlus.instance.share(ShareParams(files: [
      XFile(
        file.path,
      ),
    ]));
    await file.delete();
  }

  int? get tmdbId {
    final providerIds = this is MovieModel
        ? (this as MovieModel).providerIds
        : this is SeriesModel
            ? (this as SeriesModel).providerIds
            : null;

    if (providerIds == null || providerIds.isEmpty) return null;

    final value = providerIds['Tmdb'];
    final parsed = int.tryParse(value.toString());
    return parsed;
  }

  int? get tvdbId {
    final providerIds = this is MovieModel
        ? (this as MovieModel).providerIds
        : this is SeriesModel
            ? (this as SeriesModel).providerIds
            : null;

    if (providerIds == null || providerIds.isEmpty) return null;
    final value = providerIds['Tvdb'];
    final parsed = int.tryParse(value.toString());
    return parsed;
  }
}
