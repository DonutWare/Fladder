import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:path/path.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/models/items/trick_play_model.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/localization_helper.dart';

part 'sync_item.freezed.dart';

@Freezed(copyWith: true)
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
    MediaSegmentsModel? mediaSegments,
    TrickPlayModel? fTrickPlayModel,
    ImagesData? fImages,
    @Default([]) List<Chapter> fChapters,
    @Default([]) List<SubStreamModel> subtitles,
    @UserDataJsonSerializer() UserData? userData,
    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false, includeToJson: false) ItemBaseModel? itemModel,
  }) = _SyncItem;

  static String trickPlayPath = "TrickPlay";
  static String chaptersPath = "Chapters";

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

  TaskStatus get status => switch (videoFile.existsSync()) {
        true => TaskStatus.complete,
        _ => TaskStatus.notFound,
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
      await Directory(joinAll([directory.path, chaptersPath])).delete(recursive: true);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<List<SyncedItem>> getChildren(Ref ref) async => await ref.read(syncProvider.notifier).getChildren(this);
  Future<List<SyncedItem>> getNestedChildren(Ref ref) async =>
      await ref.read(syncProvider.notifier).getNestedChildren(this);

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
      mediaSegments: isarSyncedItem.mediaSegments != null
          ? MediaSegmentsModel.fromJson(jsonDecode(isarSyncedItem.mediaSegments!))
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

extension StatusExtension on TaskStatus {
  IconData get icon => switch (this) {
        TaskStatus.enqueued => IconsaxPlusLinear.calendar_circle,
        TaskStatus.running => IconsaxPlusLinear.arrow_down_1,
        TaskStatus.complete => IconsaxPlusLinear.tick_circle,
        TaskStatus.notFound => IconsaxPlusLinear.warning_2,
        TaskStatus.failed => IconsaxPlusLinear.tag_cross,
        TaskStatus.canceled => IconsaxPlusLinear.tag_cross,
        TaskStatus.waitingToRetry => IconsaxPlusLinear.clock,
        TaskStatus.paused => IconsaxPlusLinear.pause_circle,
      };

  Color color(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? switch (this) {
            TaskStatus.enqueued => Colors.blueAccent,
            TaskStatus.running => Colors.greenAccent,
            TaskStatus.complete => Colors.limeAccent,
            TaskStatus.notFound => const Color.fromARGB(255, 221, 135, 23),
            TaskStatus.canceled || TaskStatus.failed => Theme.of(context).colorScheme.error,
            TaskStatus.waitingToRetry => Colors.yellowAccent,
            TaskStatus.paused => Colors.tealAccent,
          }
        : switch (this) {
            TaskStatus.enqueued => Colors.blue,
            TaskStatus.running => Colors.green,
            TaskStatus.complete => Colors.lime,
            TaskStatus.notFound => const Color.fromARGB(255, 221, 135, 23),
            TaskStatus.canceled || TaskStatus.failed => Theme.of(context).colorScheme.error,
            TaskStatus.waitingToRetry => Colors.yellow,
            TaskStatus.paused => Colors.teal,
          };
  }

  String name(BuildContext context) => switch (this) {
        TaskStatus.enqueued => context.localized.syncStatusEnqueued,
        TaskStatus.running => context.localized.syncStatusRunning,
        TaskStatus.complete => context.localized.syncStatusSynced,
        TaskStatus.notFound => context.localized.syncStatusNotFound,
        TaskStatus.failed => context.localized.syncStatusFailed,
        TaskStatus.canceled => context.localized.syncStatusCanceled,
        TaskStatus.waitingToRetry => context.localized.syncStatusWaitingToRetry,
        TaskStatus.paused => context.localized.syncStatusPaused,
      };
}
