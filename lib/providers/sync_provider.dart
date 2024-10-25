import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/models/syncing/sync_settings_model.dart';
import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/profiles/default_profile.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/background_download_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/localization_helper.dart';

final syncProvider = StateNotifierProvider<SyncNotifier, SyncSettingsModel>((ref) => throw UnimplementedError());

final downloadTasksProvider = StateProvider.family<DownloadStream, String>((ref, id) => DownloadStream.empty());

class SyncNotifier extends StateNotifier<SyncSettingsModel> {
  SyncNotifier(this.ref, this.isar, this.mobileDirectory) : super(SyncSettingsModel()) {
    _init();
  }

  void _init() {
    cleanupTemporaryFiles();
    ref.listen(
      userProvider,
      (previous, next) {
        if (previous?.id != next?.id) {
          if (next?.id != null) {
            _initializeQueryStream(next?.id ?? "");
          }
        }
      },
    );

    final userId = ref.read(userProvider)?.id;
    if (userId != null) {
      _initializeQueryStream(userId);
    }
  }

  void _initializeQueryStream(String userId) {
    _subscription?.cancel();

    final queryStream = getParentSyncItems
        ?.userIdEqualTo(userId)
        .watch()
        .asyncMap((event) => event.map((e) => SyncedItem.fromIsar(e, syncPath ?? "")).toList());

    final initItems = getParentSyncItems
        ?.userIdEqualTo(userId)
        .findAll()
        .mapIndexed((index, element) => SyncedItem.fromIsar(element, syncPath ?? ""))
        .toList();

    state = state.copyWith(items: initItems ?? []);

    _subscription = queryStream?.listen((items) {
      state = state.copyWith(items: items);
    });
  }

  Future<void> cleanupTemporaryFiles() async {
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

  final Ref ref;
  final Isar? isar;
  final Directory mobileDirectory;
  final String subPath = "Synced";

  StreamSubscription<List<SyncedItem>>? _subscription;

  IsarCollection<String, ISyncedItem>? get syncedItems => isar?.iSyncedItems;

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

  QueryBuilder<ISyncedItem, ISyncedItem, QAfterFilterCondition>? get getParentSyncItems =>
      syncedItems?.where().parentIdIsNull();

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

  Future<void> refresh() async {
    state = state.copyWith(
        items: (await getParentSyncItems?.userIdEqualTo(ref.read(userProvider)?.id).findAllAsync())
                ?.map((e) => SyncedItem.fromIsar(e, syncPath ?? ""))
                .toList() ??
            []);
  }

  List<SyncedItem> getNestedChildren(SyncedItem item) {
    final allChildren = <SyncedItem>[];
    List<SyncedItem> toProcess = [item];
    while (toProcess.isNotEmpty) {
      final currentLevel = toProcess.map(
        (parent) {
          final children = syncedItems?.where().parentIdEqualTo(parent.id).sortBySortName().findAll();
          return children?.map((e) => SyncedItem.fromIsar(e, ref.read(syncProvider.notifier).syncPath ?? "")) ??
              <SyncedItem>[];
        },
      );
      allChildren.addAll(currentLevel.expand((list) => list));
      toProcess = currentLevel.expand((list) => list).toList();
    }
    return allChildren;
  }

  List<SyncedItem> getChildren(SyncedItem item) {
    return (syncedItems?.where().parentIdEqualTo(item.id).sortBySortName().findAll())
            ?.map(
              (e) => SyncedItem.fromIsar(e, syncPath ?? ""),
            )
            .toList() ??
        [];
  }

  SyncedItem? getSyncedItem(ItemBaseModel? item) {
    final id = item?.id;
    if (id == null) return null;
    final newItem = syncedItems?.get(id);
    if (newItem == null) return null;
    return SyncedItem.fromIsar(newItem, syncPath ?? "");
  }

  SyncedItem? getParentItem(String id) {
    ISyncedItem? newItem = syncedItems?.get(id);
    while (newItem?.parentId != null) {
      newItem = syncedItems?.get(newItem!.parentId!);
    }
    if (newItem == null) return null;
    return SyncedItem.fromIsar(newItem, syncPath ?? "");
  }

  ItemBaseModel? getItem(SyncedItem? syncedItem) {
    if (syncedItem == null) return null;
    return syncedItem.createItemModel(ref);
  }

  Future<void> addSyncItem(BuildContext? context, ItemBaseModel item) async {
    if (context == null) return;

    if (saveDirectory == null) {
      String? selectedDirectory =
          await FilePicker.platform.getDirectoryPath(dialogTitle: context.localized.syncSelectDownloadsFolder);
      if (selectedDirectory?.isEmpty == true) {
        fladderSnackbar(context, title: context.localized.syncNoFolderSetup);
        return;
      }
      ref.read(clientSettingsProvider.notifier).setSyncPath(selectedDirectory);
    }

    fladderSnackbar(context, title: context.localized.syncAddItemForSyncing(item.detailedName(context) ?? "Unknown"));
    final newSync = switch (item) {
      EpisodeModel episode => await syncSeries(item.parentBaseModel, episode: episode),
      SeriesModel series => await syncSeries(series),
      MovieModel movie => await syncMovie(movie),
      _ => null
    };
    fladderSnackbar(context,
        title: newSync != null
            ? context.localized.startedSyncingItem(item.detailedName(context) ?? "Unknown")
            : context.localized.unableToSyncItem(item.detailedName(context) ?? "Unknown"));
    return;
  }

  Future<bool> removeSync(BuildContext context, SyncedItem? item) async {
    try {
      if (item == null) return false;

      final nestedChildren = getNestedChildren(item);

      state = state.copyWith(
          items: state.items
              .map(
                (e) => e.copyWith(markedForDelete: e.id == item.id ? true : false),
              )
              .toList());

      if (item.taskId != null) {
        await ref.read(backgroundDownloaderProvider).cancelTaskWithId(item.taskId!);
      }

      final deleteFromDatabase = isar?.write((isar) => syncedItems?.deleteAll([...nestedChildren, item]
          .map(
            (e) => e.id,
          )
          .toList()));

      if (deleteFromDatabase == 0) return false;

      for (var i = 0; i < nestedChildren.length; i++) {
        final element = nestedChildren[i];
        if (element.taskId != null) {
          await ref.read(backgroundDownloaderProvider).cancelTaskWithId(element.taskId!);
        }
        if (await element.directory.exists()) {
          await element.directory.delete(recursive: true);
        }
      }

      if (await item.directory.exists()) {
        await item.directory.delete(recursive: true);
      }

      return true;
    } catch (e) {
      log('Error deleting synced item');
      log(e.toString());
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
      backDrop: () => backdrops.whereNotNull().toList(),
    );
  }

  Future<List<Chapter>?> saveChapterImages(List<Chapter>? data, Directory itemPath) async {
    if (data == null) return data;
    if (!itemPath.existsSync()) return data;
    if (data.isEmpty) return data;
    final saveDirectory = Directory(path.joinAll([itemPath.path, "Chapters"]));

    await saveDirectory.create(recursive: true);

    final saveChapters = await Stream.fromIterable(data).asyncMap((event) async {
      final fileName = "${event.name}.jpg";
      final response = await http.get(Uri.parse(event.imageUrl));
      final file = File(path.joinAll([saveDirectory.path, fileName]));
      if (response.bodyBytes.isEmpty) return null;
      file.writeAsBytesSync(response.bodyBytes);
      return event.copyWith(
        imageUrl: path.joinAll(["Chapters", fileName]),
      );
    }).toList();
    return saveChapters.whereNotNull().toList();
  }

  Future<ImageData?> urlDataToFileData(ImageData? data, Directory directory, String fileName) async {
    if (data?.path == null) return null;
    final response = await http.get(Uri.parse(data?.path ?? ""));

    final file = File(path.joinAll([directory.path, fileName]));
    file.writeAsBytesSync(response.bodyBytes);

    return data?.copyWith(path: fileName);
  }

  void updateItemSync(SyncedItem syncedItem) =>
      isar?.write((isar) => syncedItems?.put(ISyncedItem.fromSynced(syncedItem, syncPath ?? "")));

  Future<void> updateItem(SyncedItem syncedItem) async {
    isar?.write((isar) => syncedItems?.put(ISyncedItem.fromSynced(syncedItem, syncPath ?? "")));
  }

  Future<SyncedItem> deleteFullSyncFiles(SyncedItem syncedItem, DownloadTask? task) async {
    await syncedItem.deleteDatFiles(ref);

    ref.read(downloadTasksProvider(syncedItem.id).notifier).update((state) => DownloadStream.empty());

    final taskId = task?.taskId;
    if (taskId != null) {
      ref.read(backgroundDownloaderProvider).cancelTaskWithId(taskId);
    }
    cleanupTemporaryFiles();
    refresh();
    return syncedItem;
  }

  Future<DownloadStream?> syncVideoFile(SyncedItem syncItem, bool skipDownload) async {
    cleanupTemporaryFiles();

    final playbackResponse = await api.itemsItemIdPlaybackInfoPost(
      itemId: syncItem.id,
      body: const PlaybackInfoDto(
        enableDirectPlay: true,
        enableDirectStream: true,
        enableTranscoding: false,
        deviceProfile: defaultProfile,
      ),
    );

    final item = syncItem.createItemModel(ref);

    final directory = await Directory(syncItem.directory.path).create(recursive: true);

    final newState = VideoStream.fromPlayBackInfo(playbackResponse.bodyOrThrow, ref)?.copyWith();
    final subtitles = await saveExternalSubtitles(newState?.mediaStreamsModel?.subStreams, syncItem);

    final trickPlayFile = await saveTrickPlayData(item, directory);
    final introOutroSkip = (await api.introSkipGet(id: syncItem.id))?.body;

    syncItem = syncItem.copyWith(
      subtitles: subtitles,
      fTrickPlayModel: trickPlayFile,
      introOutSkipModel: introOutroSkip,
    );

    await updateItem(syncItem);

    final currentTask = ref.read(downloadTasksProvider(syncItem.id));

    final downloadString = path.joinAll([
      "${ref.read(userProvider)?.server}",
      "Items",
      "${syncItem.id}/Download?api_key=${ref.read(userProvider)?.credentials.token}"
    ]);

    try {
      if (!skipDownload && currentTask.task == null) {
        final downloadTask = DownloadTask(
          url: downloadString,
          directory: syncItem.directory.path,
          filename: syncItem.videoFileName,
          updates: Updates.statusAndProgress,
          baseDirectory: BaseDirectory.root,
          requiresWiFi: true,
          retries: 5,
          allowPause: true,
        );

        final defaultDownloadStream =
            DownloadStream(id: syncItem.id, task: downloadTask, progress: 0.0, status: TaskStatus.enqueued);

        ref.read(downloadTasksProvider(syncItem.id).notifier).update((state) => defaultDownloadStream);

        ref.read(backgroundDownloaderProvider).download(
          downloadTask,
          onProgress: (progress) {
            if (progress > 0 && progress < 1) {
              ref.read(downloadTasksProvider(syncItem.id).notifier).update(
                    (state) => state.copyWith(progress: progress),
                  );
            } else {
              ref.read(downloadTasksProvider(syncItem.id).notifier).update(
                    (state) => state.copyWith(progress: null),
                  );
            }
          },
          onStatus: (status) {
            ref.read(downloadTasksProvider(syncItem.id).notifier).update(
                  (state) => state.copyWith(status: status),
                );

            if (status == TaskStatus.complete) {
              ref.read(downloadTasksProvider(syncItem.id).notifier).update((state) => DownloadStream.empty());
            }
          },
        );

        return defaultDownloadStream;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }

    return null;
  }

  Future<void> clear() async {
    await mainDirectory.delete(recursive: true);
    isar?.write((isar) => syncedItems?.clear());
    state = state.copyWith(items: []);
  }

  Future<void> setup() async {
    state = state.copyWith(items: []);
    _init();
  }
}

extension SyncNotifierHelpers on SyncNotifier {
  Future<SyncedItem> createSyncItem(BaseItemDto response, {SyncedItem? parent}) async {
    final ItemBaseModel item = ItemBaseModel.fromBaseDto(response, ref);

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

    //Save item if parent so the user is aware.
    if (parent == null) {
      isar?.write((isar) => syncedItems?.put(ISyncedItem.fromSynced(syncItem, syncPath)));
    }

    final origChapters = Chapter.chaptersFromInfo(item.id, response.chapters ?? [], ref);

    return syncItem.copyWith(
      fChapters: await saveChapterImages(origChapters, directory) ?? [],
      fileSize: response.mediaSources?.firstOrNull?.size ?? 0,
      syncing: false,
      videoFileName: response.path?.split('/').lastOrNull ?? "",
    );
  }

  // Need to move the file after downloading on Android
  Future<void> moveFile(DownloadTask downloadTask, SyncedItem syncItem) async {
    final currentLocation = File(await downloadTask.filePath());
    final wantedLocation = syncItem.videoFile;
    if (currentLocation.path != wantedLocation.path) {
      await currentLocation.copy(wantedLocation.path);
      await currentLocation.delete();
    }
  }

  Future<SyncedItem?> syncMovie(ItemBaseModel item, {bool skipDownload = false}) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    final itemBaseModel = response.body;
    if (itemBaseModel == null) return null;

    SyncedItem syncItem = await createSyncItem(itemBaseModel);

    if (!syncItem.directory.existsSync()) return null;

    await syncVideoFile(syncItem, skipDownload);

    isar?.write((isar) => syncedItems?.put(ISyncedItem.fromSynced(syncItem, syncPath)));

    return syncItem;
  }

  Future<SyncedItem?> syncSeries(SeriesModel item, {EpisodeModel? episode}) async {
    final response = await api.usersUserIdItemsItemIdGetBaseItem(
      itemId: item.id,
    );

    List<SyncedItem> newItems = [];

    SyncedItem? itemToDownload;

    SyncedItem seriesItem = await createSyncItem(response.bodyOrThrow);
    newItems.add(seriesItem);
    if (!seriesItem.directory.existsSync()) return null;

    final seasonsResponse = await api.showsSeriesIdSeasonsGet(
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
      seriesId: item.id,
    );

    final seasons = seasonsResponse.body?.items ?? [];

    for (var i = 0; i < seasons.length; i++) {
      final season = seasons[i];
      final syncedSeason = await createSyncItem(season, parent: seriesItem);
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
        seasonId: season.id,
        seriesId: seriesItem.id,
      );
      final episodes = episodesResponse.body?.items ?? [];
      for (var i = 0; i < episodes.length; i++) {
        final item = episodes[i];
        final newEpisode = await createSyncItem(item, parent: syncedSeason);
        newItems.add(newEpisode);
        if (episode?.id == item.id) {
          itemToDownload = newEpisode;
        }
      }
    }

    isar?.write(
      (isar) => syncedItems?.putAll(newItems
          .map(
            (e) => ISyncedItem.fromSynced(e, syncPath ?? ""),
          )
          .toList()),
    );

    if (itemToDownload != null) {
      await syncVideoFile(itemToDownload, false);
    }

    return seriesItem;
  }
}
