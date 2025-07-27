import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';

part 'sync_provider_helpers.g.dart';

@riverpod
Stream<SyncedItem?> syncedItem(Ref ref, ItemBaseModel? item) {
  final id = item?.id;
  if (id == null || id.isEmpty) {
    return Stream.value(null);
  }

  return ref.watch(syncProvider.notifier).db.getItem(id).watchSingleOrNull();
}

@riverpod
class SyncedChildren extends _$SyncedChildren {
  @override
  FutureOr<List<SyncedItem>> build(SyncedItem item) => ref.read(syncProvider.notifier).getChildren(item);
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
      if (downloadStream.hasDownload) {
        downloadCount++;
        fullProgress += downloadStream.progress;
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
    int size = arg.fileSize ?? 0;

    if (nestedChildren != null) {
      for (var element in nestedChildren) {
        ref.watch(downloadTasksProvider(element.id));
      }
      for (var element in nestedChildren) {
        if (element.videoFile.existsSync()) {
          size += element.fileSize ?? 0;
        }
      }
    }

    return size;
  }
}
