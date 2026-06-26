import 'package:background_downloader/background_downloader.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/sync_provider.dart';

part 'sync_provider_helpers.g.dart';

@riverpod
Stream<SyncedItem?> syncedItem(Ref ref, ItemBaseModel? item) {
  final id = item?.id;
  if (id == null || id.isEmpty) {
    return Stream.value(null);
  }

  return ref.watch(syncProvider.notifier).watchItem(id);
}

@riverpod
class SyncedChildren extends _$SyncedChildren {
  @override
  FutureOr<List<SyncedItem>> build(SyncedItem item) async {
    final syncNotifier = ref.read(syncProvider.notifier);
    final localChildren = await syncNotifier.getChildrenForItem(item);
    final isOnline = ref.watch(connectivityStatusProvider.select((value) => value != ConnectionState.offline));
    if (!isOnline) {
      return localChildren;
    }

    try {
      final api = ref.read(jellyApiProvider);
      return switch (item.itemModel) {
        AlbumModel _ => await _mergeAlbumChildren(item: item, localChildren: localChildren, api: api),
        ArtistModel _ => await _mergeArtistChildren(item: item, localChildren: localChildren, api: api, ref: ref),
        _ => localChildren,
      };
    } catch (_) {
      return localChildren;
    }
  }
}

Future<List<SyncedItem>> _mergeAlbumChildren({
  required SyncedItem item,
  required List<SyncedItem> localChildren,
  required JellyService api,
}) async {
  final localTracks = localChildren.where((child) => child.itemModel is AudioModel).toList();
  final localById = {for (final child in localTracks) child.id: child};
  final response = await api.itemsGet(
    parentId: item.id,
    includeItemTypes: [BaseItemKind.audio],
    recursive: false,
    enableUserData: true,
    enableImages: true,
    imageTypeLimit: 1,
    fields: [ItemFields.primaryimageaspectratio],
    sortBy: [ItemSortBy.sortname],
    sortOrder: [SortOrder.ascending],
  );

  final serverTracks = response.body?.items.whereType<AudioModel>().toList() ?? [];
  final merged = serverTracks
      .map((track) => localById[track.id] ?? _createUnsyncedRemoteItem(parent: item, model: track))
      .toList();

  final missingLocal = localTracks.where((child) => !merged.any((mergedChild) => mergedChild.id == child.id));
  merged.addAll(missingLocal);
  merged.sort(_syncChildComparator);
  return merged;
}

Future<List<SyncedItem>> _mergeArtistChildren({
  required SyncedItem item,
  required List<SyncedItem> localChildren,
  required JellyService api,
  required Ref ref,
}) async {
  final localNested = await ref.read(syncProvider.notifier).getNestedChildren(item);
  final localById = {
    for (final child in [...localChildren, ...localNested]) child.id: child,
  };

  final albumsResponse = await api.itemsGet(
    parentId: item.id,
    includeItemTypes: [BaseItemKind.musicalbum],
    recursive: false,
    enableUserData: true,
    enableImages: true,
    imageTypeLimit: 1,
    fields: [ItemFields.primaryimageaspectratio],
    sortBy: [ItemSortBy.sortname],
    sortOrder: [SortOrder.ascending],
  );

  final remoteAlbums = albumsResponse.body?.items.whereType<AlbumModel>() ?? const <AlbumModel>[];
  final merged = remoteAlbums
      .map((remoteItem) => localById[remoteItem.id] ?? _createUnsyncedRemoteItem(parent: item, model: remoteItem))
      .toList();

  final localAlbums = localChildren.where((child) => child.itemModel is AlbumModel);
  final missingLocal = localAlbums.where((child) => !merged.any((mergedChild) => mergedChild.id == child.id));
  merged.addAll(missingLocal);

  final deduplicated = {for (final child in merged) child.id: child}.values.toList();
  deduplicated.sort(_syncChildComparator);
  return deduplicated;
}

SyncedItem _createUnsyncedRemoteItem({required SyncedItem parent, required ItemBaseModel model}) {
  final isAudio = model is AudioModel;
  final syncPath = parent.path != null ? path.join(parent.path!, model.id) : null;
  return SyncedItem(
    id: model.id,
    parentId: parent.id,
    userId: parent.userId,
    path: syncPath,
    sortName: model.name.toLowerCase(),
    fileSize: isAudio ? 1 : null,
    videoFileName: isAudio ? '${model.id}.audio' : null,
    itemModel: model,
  );
}

int _syncChildComparator(SyncedItem a, SyncedItem b) {
  final aIsAlbum = a.itemModel is AlbumModel;
  final bIsAlbum = b.itemModel is AlbumModel;
  if (aIsAlbum != bIsAlbum) {
    return aIsAlbum ? -1 : 1;
  }

  final aName = a.sortName ?? a.itemModel?.name.toLowerCase() ?? '';
  final bName = b.sortName ?? b.itemModel?.name.toLowerCase() ?? '';
  return compareNatural(aName, bName);
}

@riverpod
class SyncedNestedChildren extends _$SyncedNestedChildren {
  @override
  FutureOr<List<SyncedItem>> build(SyncedItem item) => ref.read(syncProvider.notifier).getNestedChildren(item);
}

@riverpod
class SyncDownloadStatus extends _$SyncDownloadStatus {
  @override
  DownloadStream? build(SyncedItem arg, List<SyncedItem> children) {
    final nestedChildren = children;

    ref.watch(downloadTasksProvider(arg.id));
    for (var element in nestedChildren) {
      ref.watch(downloadTasksProvider(element.id));
    }

    DownloadStream mainStream = ref.read(downloadTasksProvider(arg.id));
    int downloadCount = 0;
    double fullProgress = mainStream.hasDownload ? mainStream.progress : 0.0;

    int fullySyncedChildren = 0;

    for (var i = 0; i < nestedChildren.length; i++) {
      final childItem = nestedChildren[i];
      final downloadStream = ref.read(downloadTasksProvider(childItem.id));
      if (childItem.videoFile.existsSync()) {
        fullySyncedChildren++;
      }
      if (downloadStream.isEnqueuedOrDownloading) {
        downloadCount++;
        fullProgress += downloadStream.progress.clamp(0.0, 1.0);

        mainStream = mainStream.copyWith(
          status: mainStream.status != TaskStatus.running ? downloadStream.status : mainStream.status,
        );
      }
    }

    int syncAbleChildren = nestedChildren.where((element) => element.hasVideoFile).length;

    var fullySynced = nestedChildren.isNotEmpty ? fullySyncedChildren == syncAbleChildren : arg.videoFile.existsSync();
    return mainStream.copyWith(
      status: fullySynced ? TaskStatus.complete : mainStream.status,
      progress: fullProgress / downloadCount.clamp(1, double.infinity).toInt(),
    );
  }
}

@riverpod
class SyncSize extends _$SyncSize {
  @override
  int? build(SyncedItem arg, List<SyncedItem>? children) {
    final nestedChildren = children;

    ref.watch(downloadTasksProvider(arg.id));
    int size = 0;
    if (arg.videoFile.existsSync()) {
      size = arg.videoFile.lengthSync();
    } else {
      size = arg.fileSize ?? 0;
    }

    if (nestedChildren != null) {
      for (var element in nestedChildren) {
        ref.watch(downloadTasksProvider(element.id));
      }
      for (var element in nestedChildren) {
        if (element.videoFile.existsSync()) {
          size += element.videoFile.lengthSync();
        } else {
          size += element.fileSize ?? 0;
        }
      }
    }

    return size;
  }
}
