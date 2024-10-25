import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/intro_skip_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/localization_helper.dart';

part 'sync_item.freezed.dart';

@freezed
class SyncedItem with _$SyncedItem {
  const SyncedItem._();

  factory SyncedItem({
    required String id,
    @Default(false) bool syncing,
    String? parentId,
    required String userId,
    String? path,
    @Default(false) bool markedForDelete,
    String? sortName,
    int? fileSize,
    String? videoFileName,
    IntroOutSkipModel? introOutSkipModel,
    TrickPlayModel? fTrickPlayModel,
    ImagesData? fImages,
    @Default([]) List<Chapter> fChapters,
    @Default([]) List<SubStreamModel> subtitles,
    @UserDataJsonSerializer() UserData? userData,
  }) = _SyncItem;

  static String trickPlayPath = "TrickPlay";

  List<Chapter> get chapters => fChapters.map((e) => e.copyWith(imageUrl: joinAll({"$path", e.imageUrl}))).toList();

  ImagesData? get images => fImages?.copyWith(
        primary: () => fImages?.primary?.copyWith(path: joinAll(["$path", "${fImages?.primary?.path}"])),
        logo: () => fImages?.logo?.copyWith(path: joinAll(["$path", "${fImages?.logo?.path}"])),
        backDrop: () => fImages?.backDrop?.map((e) => e.copyWith(path: joinAll(["$path", (e.path)]))).toList(),
      );

  TrickPlayModel? get trickPlayModel => fTrickPlayModel?.copyWith(
      images: fTrickPlayModel?.images
              .map(
                (trickPlayPath) => joinAll(["$path", trickPlayPath]),
              )
              .toList() ??
          []);

  File get dataFile => File(joinAll(["$path", "data.json"]));
  Directory get trickPlayDirectory => Directory(joinAll(["$path", trickPlayPath]));
  File get videoFile => File(joinAll(["$path", "$videoFileName"]));
  Directory get directory => Directory(path ?? "");

  SyncStatus get status => switch (videoFile.existsSync()) {
        true => SyncStatus.complete,
        _ => SyncStatus.partially,
      };

  String? get taskId => task?.taskId;

  bool get childHasTask => false;

  double get totalProgress => 0.0;

  bool get hasVideoFile => videoFileName?.isNotEmpty == true && (fileSize ?? 0) > 0;

  TaskStatus get anyStatus {
    return TaskStatus.notFound;
  }

  double get downloadProgress => 0.0;
  TaskStatus get downloadStatus => TaskStatus.notFound;
  DownloadTask? get task => null;

  Future<bool> deleteDatFiles(Ref ref) async {
    try {
      await videoFile.delete();
      await Directory(joinAll([directory.path, trickPlayPath])).delete(recursive: true);
    } catch (e) {
      return false;
    }

    return true;
  }

  List<SyncedItem> nestedChildren(WidgetRef ref) => ref.watch(syncChildrenProvider(this));

  List<SyncedItem> getChildren(Ref ref) => ref.read(syncProvider.notifier).getChildren(this);
  List<SyncedItem> getNestedChildren(Ref ref) => ref.read(syncProvider.notifier).getNestedChildren(this);

  Future<int> get getDirSize async {
    var files = await directory.list(recursive: true).toList();
    var dirSize = files.fold(0, (int sum, file) => sum + file.statSync().size);
    return dirSize;
  }

  ItemBaseModel? createItemModel(Ref ref) {
    if (!dataFile.existsSync()) return null;
    final BaseItemDto itemDto = BaseItemDto.fromJson(jsonDecode(dataFile.readAsStringSync()));
    final itemModel = ItemBaseModel.fromBaseDto(itemDto, ref);
    return itemModel.copyWith(
      images: images,
      userData: userData,
    );
  }

  factory SyncedItem.fromIsar(ISyncedItem isarSyncedItem, String savePath) {
    return SyncedItem(
      id: isarSyncedItem.id,
      parentId: isarSyncedItem.parentId,
      userId: isarSyncedItem.userId ?? "",
      sortName: isarSyncedItem.sortName,
      syncing: isarSyncedItem.syncing,
      path: joinAll([savePath, isarSyncedItem.path ?? ""]),
      fileSize: isarSyncedItem.fileSize,
      videoFileName: isarSyncedItem.videoFileName,
      introOutSkipModel: isarSyncedItem.introOutroSkipModel != null
          ? IntroOutSkipModel.fromJson(jsonDecode(isarSyncedItem.introOutroSkipModel!))
          : null,
      fTrickPlayModel: isarSyncedItem.trickPlayModel != null
          ? TrickPlayModel.fromJson(jsonDecode(isarSyncedItem.trickPlayModel!))
          : null,
      fImages: isarSyncedItem.images != null ? ImagesData.fromJson(jsonDecode(isarSyncedItem.images!)) : null,
      fChapters: isarSyncedItem.chapters
              ?.map(
                (e) => Chapter.fromJson(jsonDecode(e)),
              )
              .toList() ??
          [],
      subtitles: isarSyncedItem.subtitles
              ?.map(
                (e) => SubStreamModel.fromJson(jsonDecode(e)),
              )
              .toList() ??
          [],
      userData: isarSyncedItem.userData != null ? UserData.fromJson(jsonDecode(isarSyncedItem.userData!)) : null,
    );
  }
}

enum SyncStatus {
  complete(
    Color.fromARGB(255, 141, 214, 58),
    IconsaxOutline.tick_circle,
  ),
  partially(
    Color.fromARGB(255, 221, 135, 23),
    IconsaxOutline.more_circle,
  ),
  ;

  const SyncStatus(this.color, this.icon);

  final Color color;
  String label(BuildContext context) {
    return switch (this) {
      SyncStatus.partially => context.localized.syncStatusPartially,
      SyncStatus.complete => context.localized.syncStatusSynced,
    };
  }

  final IconData icon;
}

extension StatusExtension on TaskStatus {
  Color color(BuildContext context) => switch (this) {
        TaskStatus.enqueued => Colors.blueAccent,
        TaskStatus.running => Colors.limeAccent,
        TaskStatus.complete => Colors.limeAccent,
        TaskStatus.canceled || TaskStatus.notFound || TaskStatus.failed => Theme.of(context).colorScheme.error,
        TaskStatus.waitingToRetry => Colors.yellowAccent,
        TaskStatus.paused => Colors.orangeAccent,
      };

  String name(BuildContext context) => switch (this) {
        TaskStatus.enqueued => context.localized.syncStatusEnqueued,
        TaskStatus.running => context.localized.syncStatusRunning,
        TaskStatus.complete => context.localized.syncStatusComplete,
        TaskStatus.notFound => context.localized.syncStatusNotFound,
        TaskStatus.failed => context.localized.syncStatusFailed,
        TaskStatus.canceled => context.localized.syncStatusCanceled,
        TaskStatus.waitingToRetry => context.localized.syncStatusWaitingToRetry,
        TaskStatus.paused => context.localized.syncStatusPaused,
      };
}
