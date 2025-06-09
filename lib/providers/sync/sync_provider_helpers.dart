import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/i_synced_item.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync_provider.dart';

part 'sync_provider_helpers.g.dart';

@riverpod
class SyncChildren extends _$SyncChildren {
  @override
  List<SyncedItem> build(SyncedItem root) {
    final isar = ref.watch(syncProvider.notifier).isar;
    final syncPath = ref.read(syncProvider.notifier).syncPath ?? "";

    if (isar == null) return [];

    final all = <SyncedItem>[];
    List<SyncedItem> toProcess = [root];

    while (toProcess.isNotEmpty) {
      final parentIds = toProcess.map((e) => e.id).toList();

      final children = <ISyncedItem>[];
      for (final id in parentIds) {
        final results = isar.iSyncedItems.where().parentIdEqualTo(id).sortBySortName().findAll();
        children.addAll(results);
      }

      if (children.isEmpty) break;

      final wrapped = children.map((e) => SyncedItem.fromIsar(e, syncPath)).toList();
      all.addAll(wrapped);
      toProcess = wrapped;
    }

    return all;
  }
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

    for (var i = 0; i < nestedChildren.length; i++) {
      final childItem = nestedChildren[i];
      final downloadStream = ref.read(downloadTasksProvider(childItem.id));
      if (downloadStream.hasDownload) {
        downloadCount++;
        fullProgress += downloadStream.progress;
        mainStream = mainStream.copyWith(status: downloadStream.status);
      }
    }

    return mainStream.copyWith(
      progress: fullProgress / downloadCount.clamp(1, double.infinity).toInt(),
    );
  }
}

@riverpod
class SyncStatuses extends _$SyncStatuses {
  @override
  FutureOr<SyncStatus> build(SyncedItem arg, List<SyncedItem>? children) async {
    final nestedChildren = children;

    ref.watch(downloadTasksProvider(arg.id));
    if (nestedChildren != null) {
      for (var element in nestedChildren) {
        ref.watch(downloadTasksProvider(element.id));
      }

      for (var i = 0; i < nestedChildren.length; i++) {
        final item = nestedChildren[i];
        if (item.hasVideoFile && !await item.videoFile.exists()) {
          return SyncStatus.partially;
        }
      }
    }

    if (arg.hasVideoFile && !await arg.videoFile.exists()) {
      return SyncStatus.partially;
    }
    return SyncStatus.complete;
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
        size += element.fileSize ?? 0;
      }
    }

    return size;
  }
}
