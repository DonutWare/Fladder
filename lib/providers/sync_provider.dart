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
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/database_item.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncing/sync_settings_model.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
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
  SyncNotifier(this.ref, this.mobileDirectory) : super(SyncSettingsModel()) {
    _init();
  }

  final Ref ref;
  late AppDatabase _db = AppDatabase(ref);
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

    final queryStream = _db.getParentItems.watch().distinct();
    final initItems = await _db.getParentItems.get();

    state = state.copyWith(items: initItems);

    _subscription = queryStream.listen((items) {
      state = state.copyWith(items: items);
    });
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
          final fileSize = await file.length();
          if (fileName.startsWith('com.bbflight.background_downloader') && fileSize != 0) {
            try {
              await file.delete();
              log('Deleted temporary file: $fileName from ${dir.path}');
            } catch (e) {
              log('Failed to delete file $fileName: $e');
            }
          }
        }
      }
    }
  }

  late final JellyService api = ref.read(jellyApiProvider);

  String? get _savePath => !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
      ? ref.read(clientSettingsProvider.select((value) => value.syncPath))
      : mobileDirectory.path;

  String? get savePath => _savePath;

  Directory get mainDirectory => Directory(path.joinAll([_savePath ?? "", subPath]));

  Directory? get saveDirectory {
    if (kIsWeb) return null;
    final directory = _savePath != null
        ? Directory(path.joinAll([_savePath ?? "", subPath, ref.read(userProvider)?.id ?? "UnknownUser"]))
        : null;
    directory?.createSync(recursive: true);
    if (directory?.existsSync() == true) {
      final noMedia = File(path.joinAll([directory?.path ?? "", ".nomedia"]));
      noMedia.writeAsString('');
    }
    return directory;
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

  Future<void> refresh() async => state = state.copyWith(items: (await _db.getParentItems.get()));

  Future<List<SyncedItem>> getNestedChildren(SyncedItem item) async => _db.getNestedChildren(item);

  Future<List<SyncedItem>> getChildren(String parentId) async => await _db.getChildren(parentId).get();

  Future<List<SyncedItem>> getSiblings(SyncedItem syncedItem) async {
    if (syncedItem.parentId == null) return [];
    return getChildren(syncedItem.parentId!);
  }

  Future<SyncedItem?> getSyncedItem(String? id) async {
    if (id == null) return null;
    return await _db.getItem(id).getSingleOrNull();
  }

  Stream<SyncedItem?> watchItem(String id) => _db.getItem(id).watchSingleOrNull();

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

      final itemModel = ItemBaseModel.fromBaseDto(itemResponse.bodyOrThrow, ref);

      final syncedParent = await _db.getItem(itemToSync.parentId ?? "").getSingleOrNull();

      SyncedItem newSyncedItem = await _syncItemData(syncedParent, itemModel, itemResponse.bodyOrThrow);

      final updatedItem = itemToSync.copyWith(
        itemModel: newSyncedItem.createItemModel(ref),
        sortName: newSyncedItem.sortName,
        syncing: false,
        fImages: newSyncedItem.fImages,
        fTrickPlayModel: newSyncedItem.fTrickPlayModel,
        subtitles: newSyncedItem.subtitles,
        userData: UserData.determineLastUserData([item.userData, newSyncedItem.userData]),
      );

      newItems.add(updatedItem);

      if (itemToSync.id == parentItem.id) {
        parentItem = updatedItem;
      }
    }

    await _db.insertMultipleEntries(newItems);

    return parentItem;
  }

  Future<void> addSyncItem(BuildContext? context, ItemBaseModel item) async {
    try {
      if (context == null) return;

      if (saveDirectory == null) {
        String? selectedDirectory =
            await FilePicker.platform.getDirectoryPath(dialogTitle: context.localized.syncSelectDownloadsFolder);
        if (selectedDirectory?.isEmpty == true && context.mounted) {
          fladderSnackbar(context, title: context.localized.syncNoFolderSetup);
          return;
        }
        ref.read(clientSettingsProvider.notifier).setSyncPath(selectedDirectory);
      }

      if (context.mounted) {
        fladderSnackbar(context,
            title: context.localized.syncAddItemForSyncing(item.detailedName(context) ?? "Unknown"));
      }
      final newSync = switch (item) {
        EpisodeModel episode => await syncSeries(item.parentBaseModel, episode: episode),
        SeasonModel season => await syncSeries(item.parentBaseModel, season: season),
        SeriesModel series => await syncSeries(series),
        MovieModel movie => await syncMovie(movie),
        _ => null
      };
      if (context.mounted) {
        fladderSnackbar(context,
            title: newSync != null
                ? context.localized.startedSyncingItem(item.detailedName(context) ?? "Unknown")
                : context.localized.unableToSyncItem(item.detailedName(context) ?? "Unknown"));
      }

      return;
    } catch (e) {
      log('Error adding sync item: ${e.toString()}');
      if (context?.mounted == true) {
        fladderSnackbar(context!, title: context.localized.somethingWentWrong);
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
      fladderSnackbar(context, title: context.localized.syncRemoveUnableToDeleteItem);
      return false;
    }
  }

  //Utility functions
  Future<List<SubStreamModel>> saveExternalSubtitles(List<SubStreamModel>? subtitles, SyncedItem item) async {
    if (subtitles == null) return [];

    final directory = item.directory;

    await directory.create(recursive: true);

    return Stream.fromIterable(subtitles).asyncMap((element) async {
      if (element.isExternal) {
        final response = await http.get(Uri.parse(element.url!));

        final file = File(path.joinAll([directory.path, "${element.displayTitle}.${element.language}.srt"]));
        file.writeAsBytesSync(response.bodyBytes);
        return element.copyWith(
          url: () => file.path,
        );
      }
      return element;
    }).toList();
  }

  Future<TrickPlayModel?> saveTrickPlayData(ItemBaseModel? item, Directory saveDirectory) async {
    if (item == null) return null;
    final trickPlayDirectory = Directory(path.joinAll([saveDirectory.path, SyncedItem.trickPlayPath]))
      ..createSync(recursive: true);
    final trickPlayData = await api.getTrickPlay(item: item, ref: ref);
    final List<String> newStringList = [];

    for (var index = 0; index < (trickPlayData?.body?.images.length ?? 0); index++) {
      final image = trickPlayData?.body?.images[index];
      if (image != null) {
        final http.Response response = await http.get(Uri.parse(image));
        File? newFile;
        final fileName = "tile_$index.jpg";
        if (response.statusCode == 200) {
          final Uint8List bytes = response.bodyBytes;
          newFile = File(path.joinAll([trickPlayDirectory.path, fileName]));
          await newFile.writeAsBytes(bytes);
        }
        if (newFile != null && await newFile.exists()) {
          newStringList.add(path.joinAll(['TrickPlay', fileName]));
        }
      }
    }
    return trickPlayData?.body?.copyWith(images: newStringList.toList());
  }

  Future<ImagesData?> saveImageData(ImagesData? data, Directory saveDirectory) async {
    if (data == null) return data;
    if (!saveDirectory.existsSync()) return data;

    final primary = await urlDataToFileData(data.primary, saveDirectory, "primary.jpg");
    final logo = await urlDataToFileData(data.logo, saveDirectory, "logo.jpg");
    final backdrops = await Stream.fromIterable(data.backDrop ?? <ImageData>[])
        .asyncMap((element) async => await urlDataToFileData(element, saveDirectory, "backdrop-${element.key}.jpg"))
        .toList();

    return data.copyWith(
      primary: () => primary,
      logo: () => logo,
      backDrop: () => backdrops.nonNulls.toList(),
    );
  }

  Future<List<Chapter>?> saveChapterImages(List<Chapter>? data, Directory itemPath) async {
    if (data == null) return data;
    if (!itemPath.existsSync()) return data;
    if (data.isEmpty) return data;
    final saveDirectory = Directory(path.joinAll([itemPath.path, SyncedItem.chaptersPath]));

    await saveDirectory.create(recursive: true);

    final saveChapters = await Stream.fromIterable(data).asyncMap((event) async {
      final fileName = "${event.name}.jpg";
      final response = await http.get(Uri.parse(event.imageUrl));
      final file = File(path.joinAll([saveDirectory.path, fileName]));
      if (response.bodyBytes.isEmpty) return null;
      file.writeAsBytesSync(response.bodyBytes);
      return event.copyWith(
        imageUrl: path.joinAll([SyncedItem.chaptersPath, fileName]),
      );
    }).toList();
    return saveChapters.nonNulls.toList();
  }

  Future<ImageData?> urlDataToFileData(ImageData? data, Directory directory, String fileName) async {
    if (data?.path == null) return null;
    final response = await http.get(Uri.parse(data?.path ?? ""));

    final file = File(path.joinAll([directory.path, fileName]));
    file.writeAsBytesSync(response.bodyBytes);

    return data?.copyWith(path: fileName);
  }

  Future<int> updateItem(SyncedItem item) async {
    SyncedItem syncedItem = item;
    try {
      await ref.read(jellyApiProvider).userItemsItemIdUserDataPost(itemId: syncedItem.id, body: syncedItem.userData);
    } catch (e) {
      log('Error updating item: ${syncedItem.id}');
      syncedItem = syncedItem.copyWith(unSyncedData: true);
    }
    return _db.insertItem(syncedItem);
  }

  Future<SyncedItem> deleteFullSyncFiles(SyncedItem syncedItem, DownloadTask? task) async {
    await syncedItem.deleteDatFiles(ref);

    ref.read(downloadTasksProvider(syncedItem.id).notifier).update((state) => DownloadStream.empty());

    ref.read(backgroundDownloaderProvider).cancelTaskWithId(syncedItem.id);

    cleanupTemporaryFiles();
    refresh();
    return syncedItem;
  }

  Future<bool?> syncFile(SyncedItem syncItem, bool skipDownload) async {
    cleanupTemporaryFiles();

    final playbackResponse = await api.itemsItemIdPlaybackInfoPost(
      itemId: syncItem.id,
      body: PlaybackInfoDto(
        enableDirectPlay: true,
        enableDirectStream: true,
        enableTranscoding: false,
        deviceProfile: ref.read(videoProfileProvider),
      ),
    );

    final item = syncItem.createItemModel(ref);

    final directory = await Directory(syncItem.directory.path).create(recursive: true);

    final newState = VideoStream.fromPlayBackInfo(playbackResponse.bodyOrThrow, ref)?.copyWith();
    final subtitles = await saveExternalSubtitles(newState?.mediaStreamsModel?.subStreams, syncItem);

    final trickPlayFile = await saveTrickPlayData(item, directory);
    final mediaSegments = (await api.mediaSegmentsGet(id: syncItem.id))?.body;

    syncItem = syncItem.copyWith(
      fChapters: await saveChapterImages(item?.overview.chapters, directory) ?? [],
      subtitles: subtitles,
      fTrickPlayModel: trickPlayFile,
      mediaSegments: mediaSegments,
    );

    await updateItem(syncItem);

    final currentTask = ref.read(downloadTasksProvider(syncItem.id));
    final user = ref.read(userProvider);

    if (user == null) return null;

    final downloadUrl = buildServerUrl(ref, pathSegments: ['Items', syncItem.id, 'Download']);

    try {
      if (currentTask.task != null) {
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(currentTask.id);
      }
      if (!skipDownload) {
        final downloadTask = DownloadTask(
          taskId: syncItem.id,
          url: downloadUrl,
          directory: syncItem.directory.path,
          filename: syncItem.videoFileName,
          updates: Updates.statusAndProgress,
          baseDirectory: BaseDirectory.root,
          urlQueryParameters: {"api_key": user.credentials.token},
          headers: user.credentials.header(ref),
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
    await _db.close();
    await _db.clearDatabase();
    _db = AppDatabase(ref);
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
}

extension SyncNotifierHelpers on SyncNotifier {
  Future<SyncedItem> createSyncItem(BaseItemDto response, {SyncedItem? parent}) async {
    final ItemBaseModel item = ItemBaseModel.fromBaseDto(response, ref);

    final existingSyncedItem = await getSyncedItem(item.id);

    if (existingSyncedItem != null) return existingSyncedItem;

    SyncedItem syncItem = await _syncItemData(parent, item, response);

    if (parent == null) {
      await _db.insertItem(syncItem);
    }

    return syncItem.copyWith(
      fileSize: response.mediaSources?.firstOrNull?.size ?? 0,
      syncing: false,
      videoFileName: response.path?.universalBasename ?? "",
    );
  }

  Future<SyncedItem> _syncItemData(SyncedItem? parent, ItemBaseModel item, BaseItemDto response) async {
    final Directory? parentDirectory = parent?.directory;

    final directory = Directory(path.joinAll([(parentDirectory ?? saveDirectory)?.path ?? "", item.id]));

    await directory.create(recursive: true);

    File dataFile = File(path.joinAll([directory.path, 'data.json']));
    await dataFile.writeAsString(jsonEncode(response.toJson()));
    final imageData = await saveImageData(item.images, directory);

    SyncedItem syncItem = SyncedItem(
      syncing: true,
      id: item.id,
      parentId: parent?.id,
      sortName: response.sortName,
      fImages: imageData,
      userId: ref.read(userProvider)?.id ?? "",
      path: directory.path,
      userData: item.userData,
    );
    return syncItem;
  }

  Future<SyncedItem?> syncMovie(ItemBaseModel item, {bool skipDownload = false}) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    SyncedItem syncItem = await createSyncItem(itemBaseModel);

    if (!syncItem.directory.existsSync()) return null;

    await _db.insertItem(syncItem);

    await syncFile(syncItem, skipDownload);

    return syncItem;
  }

  Future<SyncedItem?> syncSeries(SeriesModel item, {SeasonModel? season, EpisodeModel? episode}) async {
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

      final episodes = episodesResponse.body?.items ?? [];

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
      syncFile(item, false);
    }

    return seriesItem;
  }
}
