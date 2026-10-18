import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ConnectionState;

import 'package:background_downloader/background_downloader.dart';
import 'package:collection/collection.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/api_result.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/album_model.dart';
import 'package:fladder/models/items/artist_model.dart';
import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/playlist_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/models/syncing/database_item.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncing/sync_settings_model.dart';
import 'package:fladder/models/syncing/transcode_download_model.dart';
import 'package:fladder/models/syncing/transcode_music_download_model.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/sync/sync_provider_media.dart';
import 'package:fladder/providers/sync/sync_provider_overlay.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

final syncProvider = StateNotifierProvider<SyncNotifier, SyncSettingsModel>((ref) => throw UnimplementedError());

final downloadTasksProvider = StateProvider.family<DownloadStream, String?>((ref, id) => DownloadStream.empty());

final activeDownloadTasksProvider = StateProvider<List<DownloadTask>>((ref) {
  return [];
});

const syncPathKey = "syncPathKey";

class SyncNotifier extends StateNotifier<SyncSettingsModel> {
  SyncNotifier(this.ref, this.mobileDirectory)
      : _db = AppDatabase(ref),
        super(SyncSettingsModel()) {
    _init();
  }

  final Ref ref;
  final AppDatabase _db;
  final Directory mobileDirectory;
  final String subPath = "Synced";

  bool updatingSyncStatus = false;

  StreamSubscription<List<SyncedItem>>? _subscription;

  @override
  set state(SyncSettingsModel value) {
    super.state = value;
    updateSyncStates();
  }

  Future<void> updateSyncStates() async {
    final lastState =
        (await _db.getAllItems.get()).where((item) => item.unSyncedData && item.userData != null).toList();
    if (updatingSyncStatus || lastState.isEmpty) return;
    updatingSyncStatus = true;
    try {
      for (final item in lastState) {
        if (item.userData == null) continue;
        final updatedItem =
            await ref.read(jellyApiProvider).userItemsItemIdUserDataPost(itemId: item.id, body: item.userData);
        if (updatedItem?.isSuccessful == true) {
          final syncedItem = item.copyWith(unSyncedData: false);
          await _db.insertItem(syncedItem);
        } else {
          break;
        }
      }
    } catch (e) {
      // log('Error updating sync states: $e');
    } finally {
      updatingSyncStatus = false;
    }
  }

  void _init() {
    cleanupTemporaryFiles();
    ref.listen(
      userProvider,
      (previous, next) {
        if (previous?.id != next?.id) {
          if (next?.id != null) {
            _initializeQueryStream(id: next!.id);
          }
        }
      },
    );

    ref.listen(connectivityStatusProvider, (_, next) {
      if (next != ConnectionState.offline) {
        updateSyncStates();
      }
    });
    _initializeQueryStream();
  }

  void _initializeQueryStream({String? id}) async {
    final userId = id ?? ref.read(userProvider)?.id;
    _subscription?.cancel();
    state = state.copyWith(items: []);

    if (userId == null) return;

    await cleanUpEmptyDatabaseEntries();

    final queryStream = _db.getAllItems.watch().map(_rootSyncItems);
    final initItems = _rootSyncItems(await _db.getAllItems.get());

    state = state.copyWith(items: initItems);

    _subscription = queryStream.listen((items) {
      state = state.copyWith(items: items);
    });
  }

  List<SyncedItem> _rootSyncItems(List<SyncedItem> items) {
    return items.where((item) => item.parentId == null).toList();
  }

  Future<void> cleanupTemporaryFiles() async {
    final activeDownloads = ref.read(activeDownloadTasksProvider);
    if (activeDownloads.isNotEmpty) return;

    // List of directories to check
    final directories = [
      //Desktop directory
      await getTemporaryDirectory(),
      //Mobile directory
      await getApplicationSupportDirectory(),
    ];

    for (final dir in directories) {
      final List<FileSystemEntity> files = dir.listSync();

      for (var file in files) {
        if (file is File) {
          final fileName = file.path.split(Platform.pathSeparator).last;
          try {
            final fileSize = await file.length();
            if (fileName.startsWith('com.bbflight.background_downloader') && fileSize != 0) {
              try {
                await file.delete();
                log('Deleted temporary file: $fileName from ${dir.path}');
              } catch (e) {
                log('Failed to delete file $fileName: $e');
              }
            }
          } on PathAccessException {
            // Skip files that are inaccessible
            continue;
          }
        }
      }
    }
  }

  Future<List<String>> getTempFiles() async {
    final tempFiles = <String>[];

    // List of directories to check
    final directories = [
      //Desktop directory
      await getTemporaryDirectory(),
      //Mobile directory
      await getApplicationSupportDirectory(),
    ];

    for (final dir in directories) {
      final List<FileSystemEntity> files = dir.listSync();

      for (var file in files) {
        if (file is File) {
          final fileName = file.path.split(Platform.pathSeparator).last;
          final fileSize = await file.length();
          if (fileName.startsWith('com.bbflight.background_downloader') && fileSize != 0) {
            tempFiles.add(file.path);
          }
        }
      }
    }

    return tempFiles;
  }

  late final JellyService api = ref.read(jellyApiProvider);

  String? get _savePath => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
      ? ref.read(clientSettingsProvider.select((value) => value.syncPath))
      : mobileDirectory.path;

  String? get savePath => _savePath;

  Directory get mainDirectory => Directory(path.joinAll([_savePath ?? "", subPath]));

  Directory? get saveDirectory {
    try {
      if (kIsWeb) return null;
      final directory = _savePath != null
          ? Directory(path.joinAll([_savePath ?? "", subPath, ref.read(userProvider)?.id ?? "UnknownUser"]))
          : null;
      directory?.createSync(recursive: true);
      if (directory?.existsSync() == true) {
        final noMedia = File(path.joinAll([directory?.path ?? "", ".nomedia"]));
        noMedia.writeAsString('');
        noMedia.createSync();
      }
      return directory;
    } catch (e) {
      log('Error accessing save directory: ${e.toString()}');
      return null;
    }
  }

  String? get syncPath => saveDirectory?.path;

  Future<int> get directorySize async {
    if (saveDirectory == null) return 0;
    var files = await saveDirectory!.list(recursive: true).toList();
    var dirSize = files.fold(0, (int sum, file) => sum + file.statSync().size);
    return dirSize;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> refresh() async => state = state.copyWith(items: _rootSyncItems(await _db.getAllItems.get()));

  Future<List<SyncedItem>> getNestedChildren(SyncedItem? item) async {
    if (item == null) return [];
    if (item.itemModel?.type == FladderItemType.playlist) {
      return _getPlaylistChildrenFromOverlay(item);
    }
    return _db.getNestedChildrenRecursive(item.id);
  }

  Future<List<SyncedItem>> getChildren(String parentId) async => await _db.getChildren(parentId).get();

  Future<List<SyncedItem>> getChildrenForItem(SyncedItem item) async {
    if (item.itemModel?.type == FladderItemType.playlist) {
      return _getPlaylistChildrenFromOverlay(item);
    }
    return getChildren(item.id);
  }

  Future<List<SyncedItem>> _getPlaylistChildrenFromOverlay(SyncedItem item) async {
    final childIds = await item.getPlaylistChildIdsAsync();
    if (childIds.isEmpty) return [];

    final children = await Future.wait(childIds.map(getSyncedItem));
    return children.whereType<SyncedItem>().where((child) => child.itemModel is AudioModel).toList();
  }

  Future<List<SyncedItem>> getSiblings(SyncedItem syncedItem) async {
    if (syncedItem.parentId == null) return [];
    return getChildren(syncedItem.parentId!);
  }

  Future<SyncedItem?> getSyncedItem(String? id) async {
    if (id == null) return null;
    return await _db.getItem(id).getSingleOrNull();
  }

  Stream<SyncedItem?> watchItem(String id) => _db.getItem(id).watchSingleOrNull();

  Stream<List<SyncedItem>> watchChildren(String parentId) => _db.getChildren(parentId).watch();

  Future<SyncedItem?> getParentItem(String id) async => await _db.getParent(id).getSingleOrNull();

  Future<SyncedItem> refreshSyncItem(SyncedItem item) async {
    List<SyncedItem> itemsToSync = await getNestedChildren(item);

    itemsToSync = [item, ...itemsToSync];

    SyncedItem parentItem = item;

    List<SyncedItem> newItems = [];

    for (var i = 0; i < itemsToSync.length; i++) {
      final itemToSync = itemsToSync[i];
      final itemResponse = await api.usersUserIdItemsItemIdGetBaseItem(
        itemId: itemToSync.id,
      );

      final itemDto = itemResponse.bodyOrThrow;
      final isPart = itemToSync.partOfId != null;
      final itemModel = isPart
          ? VideoPartModel.fromBaseDto(
              itemDto,
              ref,
              parentItemId: itemToSync.partOfId!,
              partNumber: itemToSync.partNumber ?? 2,
              totalParts: itemToSync.totalParts ?? 2,
            )
          : ItemBaseModel.fromBaseDto(itemDto, ref);

      final syncedParent = await _db.getItem(itemToSync.parentId ?? "").getSingleOrNull();

      SyncedItem newSyncedItem = await _syncItemData(
        syncedParent,
        itemModel,
        itemDto,
        partOfId: itemToSync.partOfId,
        partNumber: itemToSync.partNumber,
        totalParts: itemToSync.totalParts,
      );

      final updatedItem = itemToSync.copyWith(
        itemModel: isPart ? itemModel : newSyncedItem.createItemModel(ref),
        sortName: newSyncedItem.sortName,
        syncing: false,
        fImages: newSyncedItem.fImages,
        fTrickPlayModel: newSyncedItem.fTrickPlayModel ?? itemToSync.fTrickPlayModel,
        subtitles: newSyncedItem.subtitles.isNotEmpty ? newSyncedItem.subtitles : itemToSync.subtitles,
        userData: UserData.determineLastUserData([item.userData, newSyncedItem.userData]),
      );

      newItems.add(updatedItem);

      if (itemToSync.id == parentItem.id) {
        parentItem = updatedItem;
      }
    }

    await _db.insertMultipleEntries(newItems);

    for (final refreshedItem in newItems) {
      if (refreshedItem.itemModel is MovieModel || refreshedItem.itemModel is EpisodeModel) {
        await ensurePartsSynced(refreshedItem, download: refreshedItem.videoFile.existsSync());
      }
    }

    return parentItem;
  }

  Future<void> addSyncItem(BuildContext? context, ItemBaseModel item) async {
    try {
      if (context == null) return;

      if (saveDirectory == null) {
        String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath(dialogTitle: context.localized.syncSelectDownloadsFolder);
        if (selectedDirectory?.isEmpty == true && context.mounted) {
          FladderSnack.show(context.localized.syncNoFolderSetup, context: context);
          return;
        }
        ref.read(clientSettingsProvider.notifier).setSyncPath(selectedDirectory);
      }

      if (context.mounted) {
        FladderSnack.show(context.localized.syncAddItemForSyncing(item.detailedName(context.localized) ?? "Unknown"),
            context: context);
      }
      final newSync = switch (item) {
        EpisodeModel episode => await syncSeries(item.parentBaseModel, episode: episode),
        SeasonModel season => await syncSeries(item.parentBaseModel, season: season),
        SeriesModel series => await syncSeries(series),
        MovieModel movie => await syncMovie(movie),
        AudioModel audio => await syncAudio(audio),
        AlbumModel album => await syncAlbum(album),
        ArtistModel artist => await syncArtist(artist),
        PlaylistModel playlist => await syncPlaylist(playlist),
        PhotoModel photo => await syncPhotoAlbum(photo.albumId ?? photo.parentId, photo: photo),
        PhotoAlbumModel album => await syncPhotoAlbum(album.id),
        _ => null
      };
      if (context.mounted) {
        FladderSnack.show(
            newSync != null
                ? context.localized.startedSyncingItem(item.detailedName(context.localized) ?? "Unknown")
                : context.localized.unableToSyncItem(item.detailedName(context.localized) ?? "Unknown"),
            context: context);
      }

      return;
    } catch (e) {
      log('Error adding sync item: ${e.toString()}');
      if (context?.mounted == true) {
        FladderSnack.show(context!.localized.somethingWentWrong, context: context);
      }
    }
  }

  void viewDatabase(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => DriftDbViewer(_db)));

  Future<bool> removeSync(BuildContext context, SyncedItem? item) async {
    try {
      if (item == null) return false;

      final nestedChildren = await getNestedChildren(item);

      state = state.copyWith(
          items: state.items
              .map(
                (e) => e.copyWith(markedForDelete: e.id == item.id ? true : false),
              )
              .toList());

      await ref.read(backgroundDownloaderProvider).cancelTaskWithId(item.id);

      await _db.deleteAllItems([...nestedChildren, item]);

      for (var i = 0; i < nestedChildren.length; i++) {
        final element = nestedChildren[i];
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(element.id);
        if (await element.directory.exists()) {
          await element.directory.delete(recursive: true);
        }
      }

      if (await item.directory.exists()) {
        await item.directory.delete(recursive: true);
      }

      return true;
    } catch (e) {
      log('Error deleting synced item ${e.toString()}');
      state = state.copyWith(items: state.items.map((e) => e.copyWith(markedForDelete: false)).toList());
      FladderSnack.show(context.localized.syncRemoveUnableToDeleteItem, context: context);
      return false;
    }
  }

  Future<bool> removePlaylistSync(
    BuildContext context,
    SyncedItem item, {
    required bool removeLinkedItems,
  }) async {
    try {
      state = state.copyWith(
          items: state.items.map((e) => e.copyWith(markedForDelete: e.id == item.id ? true : false)).toList());

      await ref.read(backgroundDownloaderProvider).cancelTaskWithId(item.id);

      if (removeLinkedItems) {
        final linkedIds = await item.getPlaylistChildIdsAsync();
        final removedTracks = <SyncedItem>[];
        for (final id in linkedIds) {
          final linkedItem = await getSyncedItem(id);
          if (linkedItem == null) continue;
          if (linkedItem.itemModel is AudioModel) {
            removedTracks.add(linkedItem);
          }
          await _deleteSyncedItemAndFiles(linkedItem);
        }

        await _cleanupOrphanedMusicParents(removedTracks);
      }

      await _deleteSyncedItemAndFiles(item);

      return true;
    } catch (e) {
      log('Error deleting synced playlist ${e.toString()}');
      state = state.copyWith(items: state.items.map((e) => e.copyWith(markedForDelete: false)).toList());
      FladderSnack.show(context.localized.syncRemoveUnableToDeleteItem, context: context);
      return false;
    }
  }

  Future<void> _deleteSyncedItemAndFiles(SyncedItem item) async {
    await ref.read(backgroundDownloaderProvider).cancelTaskWithId(item.id);
    await _db.deleteAllItems([item]);
    if (await item.directory.exists()) {
      await item.directory.delete(recursive: true);
    }
  }

  Future<bool> _hasSyncedAudioDescendants(String parentId) async {
    final queue = <SyncedItem>[...await getChildren(parentId)];

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      if (current.itemModel is AudioModel) return true;
      queue.addAll(await getChildren(current.id));
    }

    return false;
  }

  Future<void> _cleanupOrphanedMusicParents(Iterable<SyncedItem> removedTracks) async {
    final candidateAlbumIds = <String>{};
    final candidateArtistIds = <String>{};

    for (final removedTrack in removedTracks) {
      final parentId = removedTrack.parentId;
      if (parentId == null) continue;

      final parent = await getSyncedItem(parentId);
      if (parent == null) continue;

      switch (parent.itemModel?.type) {
        case FladderItemType.musicAlbum:
          candidateAlbumIds.add(parent.id);
          if (parent.parentId != null) {
            candidateArtistIds.add(parent.parentId!);
          }
          break;
        case FladderItemType.musicArtist:
          candidateArtistIds.add(parent.id);
          break;
        default:
          break;
      }
    }

    for (final albumId in candidateAlbumIds) {
      final album = await getSyncedItem(albumId);
      if (album == null || album.itemModel?.type != FladderItemType.musicAlbum) continue;

      final hasTracks = await _hasSyncedAudioDescendants(album.id);
      if (hasTracks) continue;

      if (album.parentId != null) {
        candidateArtistIds.add(album.parentId!);
      }

      await _deleteSyncedItemAndFiles(album);
    }

    for (final artistId in candidateArtistIds) {
      final artist = await getSyncedItem(artistId);
      if (artist == null || artist.itemModel?.type != FladderItemType.musicArtist) continue;

      final hasTracks = await _hasSyncedAudioDescendants(artist.id);
      if (hasTracks) continue;

      await _deleteSyncedItemAndFiles(artist);
    }
  }

  Future<int> updateItem(SyncedItem item, {bool upload = true}) async {
    var syncedItem = item;
    if (upload) {
      try {
        await ref.read(jellyApiProvider).userItemsItemIdUserDataPost(itemId: syncedItem.id, body: syncedItem.userData);
        syncedItem = syncedItem.copyWith(unSyncedData: false);
      } catch (e) {
        log('Error updating item: ${syncedItem.id}');
        syncedItem = syncedItem.copyWith(unSyncedData: true);
      }
    } else {
      syncedItem = syncedItem.copyWith(unSyncedData: true);
    }
    return _db.insertItem(syncedItem);
  }

  Future<void> syncSyncedItem(
    BuildContext context,
    SyncedItem syncedItem, {
    TranscodeDownloadModel? transcodeModel,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    final model = syncedItem.itemModel;

    switch (model) {
      case AudioModel audio:
        await syncAudio(audio, musicTranscodeModel: musicTranscodeModel);
        return;
      case AlbumModel album:
        await syncAlbum(album, musicTranscodeModel: musicTranscodeModel);
        return;
      case ArtistModel artist:
        await syncArtist(artist, musicTranscodeModel: musicTranscodeModel);
        return;
      case MovieModel _:
      case EpisodeModel _:
        await syncFile(
          syncedItem,
          false,
          transcodeModel: transcodeModel,
          musicTranscodeModel: musicTranscodeModel,
        );
        await ensurePartsSynced(syncedItem, transcodeModel: transcodeModel);
        return;
      default:
        await syncFile(
          syncedItem,
          false,
          transcodeModel: transcodeModel,
          musicTranscodeModel: musicTranscodeModel,
        );
        return;
    }
  }

  Future<SyncedItem> deleteFullSyncFiles(SyncedItem syncedItem, DownloadTask? task) async {
    final itemType = syncedItem.itemModel?.type;

    if (itemType == FladderItemType.audio) {
      await _deleteSyncedItemAndFiles(syncedItem);
      ref.read(downloadTasksProvider(syncedItem.id).notifier).update((state) => DownloadStream.empty());
      await _cleanupOrphanedMusicParents([syncedItem]);
      cleanupTemporaryFiles();
      refresh();
      return syncedItem;
    }

    if (itemType == FladderItemType.musicAlbum) {
      final nestedChildren = await getNestedChildren(syncedItem);
      final removedTracks = nestedChildren.where((element) => element.itemModel is AudioModel).toList();

      for (var i = 0; i < nestedChildren.length; i++) {
        final child = nestedChildren[i];
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(child.id);
        ref.read(downloadTasksProvider(child.id).notifier).update((state) => DownloadStream.empty());
      }

      await ref.read(backgroundDownloaderProvider).cancelTaskWithId(syncedItem.id);
      ref.read(downloadTasksProvider(syncedItem.id).notifier).update((state) => DownloadStream.empty());

      await _db.deleteAllItems([...nestedChildren, syncedItem]);

      if (await syncedItem.directory.exists()) {
        await syncedItem.directory.delete(recursive: true);
      }

      await _cleanupOrphanedMusicParents(removedTracks);

      cleanupTemporaryFiles();
      refresh();
      return syncedItem;
    }

    await syncedItem.deleteDatFiles(ref);

    final partChildren = (await getChildren(syncedItem.id)).where((child) => child.partOfId == syncedItem.id).toList();
    for (final part in partChildren) {
      await ref.read(backgroundDownloaderProvider).cancelTaskWithId(part.id);
      ref.read(downloadTasksProvider(part.id).notifier).update((state) => DownloadStream.empty());
      await part.deleteDatFiles(ref);
      if (await part.directory.exists() && part.directory.path != syncedItem.directory.path) {
        await part.directory.delete(recursive: true);
      }
    }
    if (partChildren.isNotEmpty) {
      await _db.deleteAllItems(partChildren);
    }

    syncedItem = syncedItem.copyWith(
      transcodeDownloadModel: null,
    );
    await updateItem(syncedItem);

    ref.read(downloadTasksProvider(syncedItem.id).notifier).update((state) => DownloadStream.empty());

    ref.read(backgroundDownloaderProvider).cancelTaskWithId(syncedItem.id);

    cleanupTemporaryFiles();
    refresh();
    return syncedItem;
  }

  Future<bool?> syncFile(
    SyncedItem syncItem,
    bool skipDownload, {
    TranscodeDownloadModel? transcodeModel,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    cleanupTemporaryFiles();

    if (!skipDownload && syncItem.videoFile.existsSync()) {
      return true;
    }

    final globalTranscodeModel = ref.read(clientSettingsProvider.select((value) => value.transcodeDownloadModel));
    final globalMusicTranscodeModel =
        ref.read(clientSettingsProvider.select((value) => value.transcodeMusicDownloadModel));

    final effectiveTranscodeModel = transcodeModel ?? globalTranscodeModel;
    final effectiveMusicTranscodeModel = musicTranscodeModel ?? globalMusicTranscodeModel;

    final userId = ref.read(userProvider)?.id;
    final item = syncItem.createItemModel(ref);
    if (item == null) return null;
    final isAudioItem = item is AudioModel;
    final streamModel = item.streamModel;
    final transcodeEnabled = isAudioItem ? effectiveMusicTranscodeModel.enabled : effectiveTranscodeModel.enabled;
    final maxBitrate =
        isAudioItem ? effectiveMusicTranscodeModel.maxBitrate.bitRate : effectiveTranscodeModel.maxBitrate.bitRate;
    final deviceProfile = isAudioItem
        ? (effectiveMusicTranscodeModel.enabled
            ? effectiveMusicTranscodeModel.deviceProfile
            : ref.read(videoProfileProvider))
        : (effectiveTranscodeModel.enabled ? effectiveTranscodeModel.deviceProfile : ref.read(videoProfileProvider));

    final playbackResponse = await FladderSnack.showResponse(
      api
          .itemsItemIdPlaybackInfoPost(
            itemId: syncItem.id,
            body: PlaybackInfoDto(
              userId: userId,
              enableDirectPlay: !transcodeEnabled,
              enableDirectStream: !transcodeEnabled,
              enableTranscoding: true,
              autoOpenLiveStream: true,
              maxStreamingBitrate: transcodeEnabled ? maxBitrate : null,
              deviceProfile: deviceProfile,
              mediaSourceId: streamModel?.currentVersionStream?.id,
              audioStreamIndex: streamModel?.defaultAudioStreamIndex,
              subtitleStreamIndex: streamModel?.defaultSubStreamIndex,
            ),
          )
          .apiResult,
    );

    final playbackData = playbackResponse.data;
    if (playbackData == null) {
      log('No playback info received for item ${syncItem.id}');
      return null;
    }

    final directory = await Directory(syncItem.directory.path).create(recursive: true);

    final newState = VideoStream.fromPlayBackInfo(playbackData, ref)?.copyWith();
    final subtitles = isAudioItem
        ? <SubStreamModel>[]
        : await saveExternalSubtitles(newState?.mediaStreamsModel?.subStreams, syncItem);

    final trickPlayFile = isAudioItem ? null : await saveTrickPlayData(item, directory);
    final mediaSegments = isAudioItem ? null : (await api.mediaSegmentsGet(id: syncItem.id))?.body;

    syncItem = syncItem.copyWith(
      fChapters: await saveChapterImages(item.overview.chapters, directory) ?? [],
      subtitles: subtitles,
      videoFileName: transcodeEnabled
          ? syncItem.videoFileName?.replaceAll(
              path.extension(syncItem.videoFileName ?? ""),
              isAudioItem
                  ? effectiveMusicTranscodeModel.container.extension
                  : effectiveTranscodeModel.container.extension,
            )
          : syncItem.videoFileName,
      fTrickPlayModel: trickPlayFile,
      mediaSegments: mediaSegments,
      transcodeDownloadModel: isAudioItem ? null : effectiveTranscodeModel,
    );

    if (isAudioItem) {
      await writeMusicOverlayFile(syncItem, effectiveMusicTranscodeModel);
      await _saveSyncedLyrics(syncItem);
    } else {
      await writeOverlayFile(syncItem, effectiveTranscodeModel, subtitles);
    }

    await updateItem(syncItem);

    final currentTask = ref.read(downloadTasksProvider(syncItem.id));
    final user = ref.read(userProvider);

    if (user == null) return null;

    final mediaSource = playbackData.mediaSources?.firstOrNull;

    final String downloadUrl;
    if ((mediaSource?.supportsDirectStream ?? false) || (mediaSource?.supportsDirectPlay ?? false)) {
      final directOptions = {
        'Static': 'true',
        'mediaSourceId': mediaSource!.id,
      };
      downloadUrl = buildServerUrl(
        ref,
        pathSegments: [isAudioItem ? 'Audio' : 'Videos', mediaSource.id!, 'stream'],
        queryParameters: directOptions,
      );
      log('Using direct stream URL: $downloadUrl');
    } else if (mediaSource != null &&
        (mediaSource.supportsTranscoding ?? false) &&
        mediaSource.transcodingUrl != null) {
      downloadUrl = buildServerUrl(ref, relativeUrl: mediaSource.transcodingUrl);
      log('Using transcode URL: $downloadUrl');
    } else {
      log('No supported playback method found');
      return null;
    }

    try {
      if (currentTask.task != null) {
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(currentTask.id);
      }
      if (!skipDownload) {
        final curlHeaders = {
          ...user.credentials.header(ref),
          if (transcodeEnabled)
            ...(isAudioItem
                ? effectiveMusicTranscodeModel.curlHeaders(item.overview.runTime ?? Duration.zero, item: item)
                : effectiveTranscodeModel.curlHeaders(item.overview.runTime ?? Duration.zero, item: item)),
        };

        final downloadTask = DownloadTask(
          taskId: syncItem.id,
          url: downloadUrl,
          directory: syncItem.directory.path,
          filename: syncItem.videoFileName,
          updates: Updates.statusAndProgress,
          baseDirectory: BaseDirectory.root,
          headers: curlHeaders,
          requiresWiFi: ref.read(clientSettingsProvider.select((value) => value.requireWifi)),
          retries: 3,
          allowPause: true,
        );

        ref.read(activeDownloadTasksProvider.notifier).update((state) {
          final existingTasks = state.where((element) => element.taskId != downloadTask.taskId).toList();
          return [...existingTasks, downloadTask];
        });

        final defaultDownloadStream = DownloadStream(id: syncItem.id, task: downloadTask, status: TaskStatus.enqueued);
        ref.read(downloadTasksProvider(syncItem.id).notifier).update((state) => defaultDownloadStream);
        return await ref.read(backgroundDownloaderProvider).enqueue(downloadTask);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }

    return null;
  }

  Future<void> removeAllSyncedData() async {
    if (await mainDirectory.exists()) {
      await mainDirectory.delete(recursive: true);
    }
    await _db.clearDatabase();
    state = state.copyWith(items: []);
  }

  Future<void> updatePlaybackPosition({String? itemId, required Duration position}) async {
    if (itemId == null) return;

    final syncedItem = await _db.getItem(itemId).getSingleOrNull();
    if (syncedItem == null) return;

    final item = syncedItem.itemModel;
    if (item == null) return;

    final progress = position.inMilliseconds / (item.overview.runTime?.inMilliseconds ?? 0) * 100;

    final updatedItem = syncedItem.copyWith(
      userData: syncedItem.userData?.copyWith(
        playbackPositionTicks: position.toRuntimeTicks,
        progress: progress,
        played: UserData.isPlayed(position, item.overview.runTime ?? Duration.zero),
      ),
    );
    await _db.insertItem(updatedItem);
  }

  /// Builds the offline video playback queue around [current].
  ///
  /// Parts are interleaved directly after their parent, and only downloaded
  /// files are included. For an episode, downloaded siblings from the same
  /// season are kept in the queue.
  Future<List<SyncedItem>> getVideoPlaybackQueue(SyncedItem current) async {
    final main = current.partOfId != null ? await getSyncedItem(current.partOfId) : current;
    if (main == null) return [current];

    List<SyncedItem> mainItems;
    if (main.itemModel is EpisodeModel && main.parentId != null) {
      mainItems = (await getChildren(main.parentId!))
          .where((item) => item.itemModel is EpisodeModel && item.partOfId == null && item.videoFile.existsSync())
          .toList();
    } else {
      mainItems = [if (main.videoFile.existsSync()) main];
    }

    if (!mainItems.any((item) => item.id == main.id)) {
      mainItems.insert(0, main);
    }

    final partsByParentId = <String, List<SyncedItem>>{};
    for (final item in mainItems) {
      final parts = (await getChildren(item.id))
          .where((part) => part.partOfId == item.id && part.videoFile.existsSync())
          .toList()
        ..sort((a, b) => (a.partNumber ?? 0).compareTo(b.partNumber ?? 0));
      if (parts.isNotEmpty) {
        partsByParentId[item.id] = parts;
      }
    }

    return interleaveSyncedVideoQueue(mainItems, partsByParentId, current: current);
  }

  /// Pure offline queue ordering helper, exposed for tests.
  static List<SyncedItem> interleaveSyncedVideoQueue(
    List<SyncedItem> mainItems,
    Map<String, List<SyncedItem>> partsByParentId, {
    SyncedItem? current,
  }) {
    final queue = <SyncedItem>[];
    for (final item in mainItems) {
      queue.add(item);
      queue.addAll(partsByParentId[item.id] ?? const []);
    }

    if (current != null && !queue.any((item) => item.id == current.id)) {
      queue.add(current);
    }
    return queue;
  }

  /// Clears local progress and played state for [itemIds].
  ///
  /// Used by the offline rewatch flow; the changes are queued for the next
  /// successful sync instead of being written to the server immediately.
  Future<void> resetMultipartProgress(Iterable<String> itemIds) async {
    final updates = <SyncedItem>[];
    for (final id in itemIds) {
      final synced = await _db.getItem(id).getSingleOrNull();
      if (synced == null) continue;
      updates.add(synced.copyWith(
        userData: (synced.userData ?? const UserData()).copyWith(
          playbackPositionTicks: 0,
          progress: 0.0,
          played: false,
        ),
        unSyncedData: true,
      ));
    }
    if (updates.isEmpty) return;
    await _db.insertMultipleEntries(updates);
  }

  Future<void> updateLocalItems(Iterable<SyncedItem> items, {bool upload = true}) async {
    for (final item in items) {
      await updateItem(item, upload: upload);
    }
  }

  Future<void> updatePlayedItem(String? itemId,
      {DateTime? datePlayed, required bool played, bool responseSuccessful = false}) async {
    if (itemId == null) return;

    final syncedItem = _db.getItem(itemId).getSingleOrNull();
    syncedItem.then((item) async {
      if (item == null) return;
      final updatedUserData = item.userData?.copyWith(
        played: played,
        playbackPositionTicks: 0,
        progress: 0.0,
        lastPlayed: datePlayed ?? DateTime.now().toUtc(),
      );
      SyncedItem updatedItem = item.copyWith(userData: updatedUserData, unSyncedData: !responseSuccessful);

      List<SyncedItem> children = [];
      final shouldUpdateChildren = {FladderItemType.series, FladderItemType.season}.contains(item.itemModel?.type);
      if (shouldUpdateChildren) {
        // Update child items with the same played status, jellyfin server does this was well
        // when marking a series or season as played
        children = (await getNestedChildren(item))
            .map((e) => e.copyWith(
                  userData: e.userData?.copyWith(
                    played: played,
                    playbackPositionTicks: 0,
                    progress: 0.0,
                  ),
                ))
            .toList();
      }
      await _db.insertMultipleEntries([updatedItem, ...children]);
    });
  }

  Future<void> updateFavoriteItem(String? itemId, {required bool isFavorite, bool responseSuccessful = false}) async {
    if (itemId == null) return;

    final syncedItem = _db.getItem(itemId).getSingleOrNull();
    syncedItem.then((item) async {
      if (item == null) return;
      final updatedUserData = item.userData?.copyWith(isFavourite: isFavorite);
      final updatedItem = item.copyWith(userData: updatedUserData, unSyncedData: !responseSuccessful);
      await _db.insertItem(updatedItem);
    });
  }

  Future<void> _saveSyncedLyrics(SyncedItem syncItem) async {
    try {
      final response = await api.audioItemIdLyricsGet(itemId: syncItem.id);
      final lyrics = response.body;
      if (lyrics == null) {
        if (syncItem.lyricsFile.existsSync()) {
          await syncItem.lyricsFile.delete();
        }
        return;
      }

      await syncItem.lyricsFile.writeAsString(jsonEncode(lyrics.toJson()));
    } catch (e) {
      log('Error saving lyrics for item ${syncItem.id}: ${e.toString()}');
    }
  }

  /// Removes database entries whose sync folder no longer exists on disk.
  Future<void> cleanUpEmptyDatabaseEntries() async {
    try {
      if (kIsWeb) return;
      if (!mainDirectory.existsSync()) return;
      final entries = await _db.getAllItems.get();
      final missingEntries = entries.where((entry) => !entry.directory.existsSync()).toList();
      if (missingEntries.isEmpty) return;
      await _db.deleteAllItems(missingEntries);
    } catch (e) {
      log('Error cleaning up empty database entries: ${e.toString()}');
    }
  }
}

extension SyncNotifierHelpers on SyncNotifier {
  Future<SyncedItem> createSyncItem(
    BaseItemDto response, {
    SyncedItem? parent,
    String? partOfId,
    int? partNumber,
    int? totalParts,
  }) async {
    final ItemBaseModel item = partOfId != null
        ? VideoPartModel.fromBaseDto(
            response,
            ref,
            parentItemId: partOfId,
            partNumber: partNumber ?? 2,
            totalParts: totalParts ?? 2,
          )
        : ItemBaseModel.fromBaseDto(response, ref);

    final existingSyncedItem = await getSyncedItem(item.id);

    if (existingSyncedItem != null) return existingSyncedItem;

    SyncedItem syncItem = await _syncItemData(
      parent,
      item,
      response,
      partOfId: partOfId,
      partNumber: partNumber,
      totalParts: totalParts,
    );

    if (parent == null) {
      await _db.insertItem(syncItem);
    }

    return syncItem.copyWith(
      fileSize: response.mediaSources?.firstOrNull?.size ?? 0,
      syncing: false,
      videoFileName: response.path?.universalBasename ?? "",
    );
  }

  /// Creates and downloads the additional parts of a multi-part movie or
  /// episode when they are missing from the sync database.
  ///
  /// Returns the stored part items, including ones that already existed.
  Future<List<SyncedItem>> ensurePartsSynced(
    SyncedItem mainItem, {
    TranscodeDownloadModel? transcodeModel,
    bool download = true,
  }) async {
    if (mainItem.partOfId != null) return const [];
    final model = mainItem.itemModel ?? mainItem.createItemModel(ref);
    if (model is! MovieModel && model is! EpisodeModel) return const [];

    final partCount = (model as ItemStreamModel).partCount;
    if (partCount <= 1) return const [];

    final canDownload = download && !ref.read(offlineStateProvider);

    final existing = (await getChildren(mainItem.id)).where((child) => child.partOfId == mainItem.id).toList();
    if (existing.length >= partCount - 1) {
      if (canDownload) {
        for (final part in existing) {
          if (!part.videoFile.existsSync()) {
            unawaited(syncFile(part, false, transcodeModel: transcodeModel));
          }
        }
      }
      return existing;
    }

    try {
      final response = await api.getAdditionalParts(itemId: mainItem.id);
      final dtos = response.body?.items ?? const <BaseItemDto>[];
      if (dtos.isEmpty) return existing;

      final parts = <SyncedItem>[];
      for (var i = 0; i < dtos.length; i++) {
        final part = await createSyncItem(
          dtos[i],
          parent: mainItem,
          partOfId: mainItem.id,
          partNumber: i + 2,
          totalParts: dtos.length + 1,
        );
        parts.add(part);
      }

      await _db.insertMultipleEntries(parts);

      if (canDownload) {
        for (final part in parts) {
          if (!part.videoFile.existsSync()) {
            unawaited(syncFile(part, false, transcodeModel: transcodeModel));
          }
        }
      }

      return parts;
    } catch (e) {
      log('Failed to sync additional parts for ${mainItem.id}: $e');
      return existing;
    }
  }

  Future<SyncedItem> _syncItemData(
    SyncedItem? parent,
    ItemBaseModel item,
    BaseItemDto response, {
    String? partOfId,
    int? partNumber,
    int? totalParts,
  }) async {
    final Directory? parentDirectory = parent?.directory;

    final directory = Directory(path.joinAll([(parentDirectory ?? saveDirectory)?.path ?? "", item.id]));

    await directory.create(recursive: true);

    File dataFile = File(path.joinAll([directory.path, 'data.json']));
    await dataFile.writeAsString(jsonEncode(response.toJson()));
    final imageData = switch (item) {
      AudioModel _ => _audioImageDataFromParent(parent: parent, directory: directory),
      PhotoModel photo => await saveImageData(photo.thumbnail, directory),
      _ => await saveImageData(item.images, directory),
    };

    SyncedItem syncItem = SyncedItem(
      syncing: true,
      id: item.id,
      parentId: parent?.id,
      partOfId: partOfId,
      partNumber: partNumber,
      totalParts: totalParts,
      sortName: response.sortName,
      fImages: imageData,
      userId: ref.read(userProvider)?.id ?? "",
      path: directory.path,
      userData: item.userData,
    );
    return syncItem;
  }

  ImagesData? _audioImageDataFromParent({required SyncedItem? parent, required Directory directory}) {
    final parentImages = parent?.fImages;
    final parentDirectory = parent?.directory;

    if (parentImages == null || parentDirectory == null) return null;

    ImageData? rebasePath(ImageData? image) {
      final imagePath = image?.path;
      if (imagePath == null || imagePath.isEmpty) return null;

      final absoluteParentPath = path.join(parentDirectory.path, imagePath);
      final relativePath = path.relative(absoluteParentPath, from: directory.path);

      return image?.copyWith(path: relativePath);
    }

    return parentImages.copyWith(
      primary: () => rebasePath(parentImages.primary),
      logo: () => rebasePath(parentImages.logo),
      backDrop: () => (parentImages.backDrop ?? []).map((image) => rebasePath(image)).whereType<ImageData>().toList(),
    );
  }

  Future<SyncedItem?> syncMovie(
    ItemBaseModel item, {
    bool skipDownload = false,
    TranscodeDownloadModel? transcodeModel,
  }) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    SyncedItem syncItem = await createSyncItem(itemBaseModel);

    if (!syncItem.directory.existsSync()) return null;

    await _db.insertItem(syncItem);

    await syncFile(syncItem, skipDownload, transcodeModel: transcodeModel);

    await ensurePartsSynced(syncItem, transcodeModel: transcodeModel, download: !skipDownload);

    return syncItem;
  }

  Future<SyncedItem?> syncAudio(
    AudioModel item, {
    bool skipDownload = false,
    SyncedItem? parent,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    final existingSyncedItem = await getSyncedItem(item.id);
    if (existingSyncedItem != null && existingSyncedItem.videoFile.existsSync()) {
      return existingSyncedItem;
    }

    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    SyncedItem? albumParent = parent;
    if (albumParent == null && itemBaseModel.albumId != null) {
      final albumResponse = await api.usersUserIdItemsItemIdGetBaseItem(
        itemId: itemBaseModel.albumId!,
      );
      if (albumResponse.body != null) {
        SyncedItem? artistItem;
        if (albumResponse.body!.parentId != null) {
          final artistResponse = await api.usersUserIdItemsItemIdGetBaseItem(
            itemId: albumResponse.body!.parentId!,
          );
          if (artistResponse.body != null) {
            artistItem = await createSyncItem(artistResponse.bodyOrThrow);
            await _db.insertItem(artistItem);
          }
        }
        final albumItem = await createSyncItem(albumResponse.bodyOrThrow, parent: artistItem);
        await _db.insertItem(albumItem);
        albumParent = albumItem;
      }
    }

    SyncedItem syncItem = await createSyncItem(itemBaseModel, parent: albumParent);

    if (!syncItem.directory.existsSync()) return null;

    await _db.insertItem(syncItem);

    await syncFile(syncItem, skipDownload, musicTranscodeModel: musicTranscodeModel);

    return syncItem;
  }

  Future<SyncedItem?> syncAlbum(
    AlbumModel item, {
    bool skipDownload = false,
    SyncedItem? parent,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    SyncedItem? artistItem = parent;
    if (artistItem == null && itemBaseModel.parentId != null) {
      final artistResponse = await api.usersUserIdItemsItemIdGetBaseItem(
        itemId: itemBaseModel.parentId!,
      );
      if (artistResponse.body != null) {
        artistItem = await createSyncItem(artistResponse.bodyOrThrow);
        await _db.insertItem(artistItem);
      }
    }

    final albumItem = await createSyncItem(itemBaseModel, parent: artistItem);
    if (!albumItem.directory.existsSync()) return null;

    final tracksResponse = await api.itemsGet(
      parentId: item.id,
      includeItemTypes: [BaseItemKind.audio],
      recursive: false,
      enableUserData: true,
      fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.path,
        ItemFields.parentid,
        ItemFields.sortname,
      ],
    );

    final tracks = tracksResponse.body?.items ?? [];

    final Map<String, SyncedItem> newItems = {albumItem.id: albumItem};
    final Map<String, SyncedItem> itemsToDownload = {};

    for (var i = 0; i < tracks.length; i++) {
      final track = tracks[i];
      final trackDto = await api.usersUserIdItemsItemIdGetBaseItem(itemId: track.id);
      if (trackDto.body == null) continue;
      final syncedTrack = await createSyncItem(trackDto.bodyOrThrow, parent: albumItem);
      newItems[syncedTrack.id] = syncedTrack;
      if (!await syncedTrack.videoFile.exists()) {
        itemsToDownload[syncedTrack.id] = syncedTrack;
      }
    }

    await _db.insertMultipleEntries(newItems.values.toList());

    if (!skipDownload) {
      for (var i = 0; i < itemsToDownload.length; i++) {
        final track = itemsToDownload.values.elementAt(i);
        syncFile(track, false, musicTranscodeModel: musicTranscodeModel);
      }
    }

    return albumItem;
  }

  Future<SyncedItem?> syncArtist(
    ArtistModel item, {
    bool skipDownload = false,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    final artistItem = await createSyncItem(itemBaseModel);
    if (!artistItem.directory.existsSync()) return null;

    final albumsResponse = await api.itemsGet(
      parentId: item.id,
      includeItemTypes: [BaseItemKind.musicalbum],
      recursive: false,
      enableUserData: true,
      fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.path,
        ItemFields.parentid,
        ItemFields.sortname,
      ],
    );

    final albums = albumsResponse.body?.items ?? [];

    final Map<String, SyncedItem> newItems = {artistItem.id: artistItem};
    final Map<String, SyncedItem> itemsToDownload = {};

    for (var i = 0; i < albums.length; i++) {
      final album = albums[i];
      final albumDto = await api.usersUserIdItemsItemIdGetBaseItem(itemId: album.id);
      if (albumDto.body == null) continue;
      final syncedAlbum = await createSyncItem(albumDto.bodyOrThrow, parent: artistItem);
      newItems[syncedAlbum.id] = syncedAlbum;

      final tracksResponse = await api.itemsGet(
        parentId: album.id,
        includeItemTypes: [BaseItemKind.audio],
        recursive: false,
        enableUserData: true,
        fields: [
          ItemFields.mediastreams,
          ItemFields.mediasources,
          ItemFields.overview,
          ItemFields.path,
          ItemFields.parentid,
          ItemFields.sortname,
        ],
      );

      final tracks = tracksResponse.body?.items ?? [];

      for (var j = 0; j < tracks.length; j++) {
        final track = tracks[j];
        final trackDto = await api.usersUserIdItemsItemIdGetBaseItem(itemId: track.id);
        if (trackDto.body == null) continue;
        final syncedTrack = await createSyncItem(trackDto.bodyOrThrow, parent: syncedAlbum);
        newItems[syncedTrack.id] = syncedTrack;
        if (!await syncedTrack.videoFile.exists()) {
          itemsToDownload[syncedTrack.id] = syncedTrack;
        }
      }
    }

    await _db.insertMultipleEntries(newItems.values.toList());

    if (!skipDownload) {
      for (var i = 0; i < itemsToDownload.length; i++) {
        final track = itemsToDownload.values.elementAt(i);
        syncFile(track, false, musicTranscodeModel: musicTranscodeModel);
      }
    }

    return artistItem;
  }

  Future<SyncedItem?> syncPlaylist(
    PlaylistModel item, {
    bool skipDownload = false,
    TranscodeMusicDownloadModel? musicTranscodeModel,
  }) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    final playlistItem = await createSyncItem(itemBaseModel);
    if (!playlistItem.directory.existsSync()) return null;

    await _db.insertItem(playlistItem);

    final tracksResponse = await api.playlistsPlaylistIdItemsGet(
      playlistId: item.id,
      enableUserData: true,
      fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.path,
        ItemFields.parentid,
        ItemFields.sortname,
      ],
    );

    final playlistTracks = tracksResponse.body?.items.whereType<AudioModel>().toList() ?? [];

    final childIds = playlistTracks.map((e) => e.id).whereType<String>().toList();

    for (final track in playlistTracks) {
      await syncAudio(track, skipDownload: skipDownload, musicTranscodeModel: musicTranscodeModel);
    }

    await writePlaylistChildrenOverlay(playlistItem, childIds);

    return playlistItem;
  }

  Future<SyncedItem?> syncSeries(
    SeriesModel item, {
    SeasonModel? season,
    EpisodeModel? episode,
    TranscodeDownloadModel? transcodeModel,
  }) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    List<SyncedItem> newItems = [];

    List<SyncedItem>? itemsToDownload = [];

    SyncedItem seriesItem = await createSyncItem(response.bodyOrThrow);
    newItems.add(seriesItem);
    if (!seriesItem.directory.existsSync()) return null;

    final seasonsResponse = await api.showsSeriesIdSeasonsGet(
      seriesId: item.id,
      isMissing: false,
      enableUserData: true,
      fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.mediasourcecount,
        ItemFields.airtime,
        ItemFields.datecreated,
        ItemFields.datelastmediaadded,
        ItemFields.datelastrefreshed,
        ItemFields.sortname,
        ItemFields.seasonuserdata,
        ItemFields.externalurls,
        ItemFields.genres,
        ItemFields.parentid,
        ItemFields.path,
        ItemFields.chapters,
        ItemFields.trickplay,
      ],
    );

    final seasons = seasonsResponse.body?.items ?? [];

    for (var i = 0; i < seasons.length; i++) {
      final newSeason = seasons[i];
      final syncedSeason = await createSyncItem(newSeason, parent: seriesItem);
      newItems.add(syncedSeason);
      final episodesResponse = await api.showsSeriesIdEpisodesGet(
        isMissing: false,
        enableUserData: true,
        fields: [
          ItemFields.mediastreams,
          ItemFields.mediasources,
          ItemFields.overview,
          ItemFields.mediasourcecount,
          ItemFields.airtime,
          ItemFields.datecreated,
          ItemFields.datelastmediaadded,
          ItemFields.datelastrefreshed,
          ItemFields.sortname,
          ItemFields.seasonuserdata,
          ItemFields.externalurls,
          ItemFields.genres,
          ItemFields.parentid,
          ItemFields.path,
          ItemFields.chapters,
          ItemFields.trickplay,
        ],
        seasonId: newSeason.id,
        seriesId: seriesItem.id,
      );

      final episodes = episodesResponse.body?.items?.where((ep) => ep.seasonId == newSeason.id).toList() ?? [];

      final episodeResults = await Future.wait(
        episodes.map((ep) async {
          final newEpisode = await createSyncItem(ep, parent: syncedSeason);
          return (ep, newEpisode);
        }),
      );

      for (final (ep, newEpisode) in episodeResults) {
        newItems.add(newEpisode);
        if (episode?.id == ep.id || newSeason.id == season?.id && !await newEpisode.videoFile.exists()) {
          itemsToDownload.add(newEpisode);
        }
      }
    }

    await _db.insertMultipleEntries(newItems);

    for (var i = 0; i < itemsToDownload.length; i++) {
      final item = itemsToDownload[i];
      //No need to await file sync happens in the background
      syncFile(item, false, transcodeModel: transcodeModel);
      await ensurePartsSynced(item, transcodeModel: transcodeModel);
    }

    return seriesItem;
  }

  Future<SyncedItem?> syncPhotoAlbum(String? albumId, {PhotoModel? photo}) async {
    if (albumId == null || albumId.isEmpty) return null;

    final albumResponse = await api.usersUserIdItemsItemIdGetBaseItem(itemId: albumId);
    final albumDto = albumResponse.body;
    if (albumDto == null) return null;

    final albumSyncItem = await createSyncItem(albumDto);
    if (!albumSyncItem.directory.existsSync()) return null;

    final List<String> photoIds;
    if (photo != null) {
      photoIds = [photo.id];
    } else {
      final childrenResponse = await api.itemsGet(
        parentId: albumId,
        includeItemTypes: [
          BaseItemKind.photo,
          BaseItemKind.video,
        ],
        recursive: true,
      );
      photoIds = childrenResponse.body?.items.whereType<PhotoModel>().map((e) => e.id).toList() ?? [];
    }

    final Map<String, SyncedItem> newItems = {albumSyncItem.id: albumSyncItem};
    final Map<String, SyncedItem> itemsToDownload = {};

    for (final photoId in photoIds) {
      final photoResponse = await api.usersUserIdItemsItemIdGetBaseItem(itemId: photoId);
      final photoDto = photoResponse.body;
      if (photoDto == null) continue;
      final photoSyncItem = _withPhotoFileName(await createSyncItem(photoDto, parent: albumSyncItem), photoDto);
      newItems[photoSyncItem.id] = photoSyncItem;
      if (!await photoSyncItem.videoFile.exists()) {
        itemsToDownload[photoSyncItem.id] = photoSyncItem;
      }
    }

    await _db.insertMultipleEntries(newItems.values.toList());

    for (final photoItem in itemsToDownload.values) {
      syncPhotoFile(photoItem);
    }

    return albumSyncItem;
  }

  SyncedItem _withPhotoFileName(SyncedItem item, BaseItemDto dto) {
    if (item.videoFileName?.isNotEmpty == true) return item;
    final container = dto.container?.split(',').firstOrNull?.trim();
    final extension = container?.isNotEmpty == true ? container! : (dto.type == BaseItemKind.video ? 'mp4' : 'jpg');
    return item.copyWith(videoFileName: '${item.id}.$extension');
  }

  Future<bool?> syncPhotoFile(SyncedItem photoItem) async {
    if (photoItem.videoFile.existsSync()) return true;

    final user = ref.read(userProvider);
    if (user == null) return null;

    final fileName = photoItem.videoFileName;
    if (fileName == null || fileName.isEmpty) return null;

    try {
      final currentTask = ref.read(downloadTasksProvider(photoItem.id));
      if (currentTask.task != null) {
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(currentTask.id);
      }

      await photoItem.directory.create(recursive: true);

      final downloadTask = DownloadTask(
        taskId: photoItem.id,
        url: buildServerUrl(ref, pathSegments: ['Items', photoItem.id, 'Download']),
        directory: photoItem.directory.path,
        filename: fileName,
        updates: Updates.statusAndProgress,
        baseDirectory: BaseDirectory.root,
        headers: user.credentials.header(ref),
        requiresWiFi: ref.read(clientSettingsProvider.select((value) => value.requireWifi)),
        retries: 3,
        allowPause: true,
      );

      ref.read(activeDownloadTasksProvider.notifier).update((state) {
        final existingTasks = state.where((element) => element.taskId != downloadTask.taskId).toList();
        return [...existingTasks, downloadTask];
      });

      final defaultDownloadStream = DownloadStream(id: photoItem.id, task: downloadTask, status: TaskStatus.enqueued);
      ref.read(downloadTasksProvider(photoItem.id).notifier).update((state) => defaultDownloadStream);
      return await ref.read(backgroundDownloaderProvider).enqueue(downloadTask);
    } catch (e) {
      log('Error syncing photo ${photoItem.id}: ${e.toString()}');
      return null;
    }
  }
}
