import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/util/localization_helper.dart';

part 'background_download_provider.g.dart';

final itemDownloadGroup = "ITEM_DOWNLOAD_GROUP";

@Riverpod(keepAlive: true)
class BackgroundDownloader extends _$BackgroundDownloader {
  late StreamSubscription<TaskUpdate> updateListener;

  @override
  FileDownloader build() {
    ref.onDispose(
      () => updateListener.cancel(),
    );

    final maxDownloads = ref.read(clientSettingsProvider.select((value) => value.maxConcurrentDownloads));
    final downloader = FileDownloader()
      ..configure(
        globalConfig: globalConfig(maxDownloads),
      )
      ..trackTasks();
    updateListener = downloader.updates.listen(updateTask);
    return downloader;
  }

  void updateTask(TaskUpdate update) {
    switch (update) {
      case TaskStatusUpdate():
        final status = update.status;
        ref.read(downloadTasksProvider(update.task.taskId).notifier).update(
              (state) => state.copyWith(status: status),
            );

        if (status == TaskStatus.complete || status == TaskStatus.canceled) {
          ref.read(downloadTasksProvider(update.task.taskId).notifier).update((state) => DownloadStream.empty());
          ref
              .read(activeDownloadTasksProvider.notifier)
              .update((state) => state.where((element) => element.taskId != update.task.taskId).toList());

          ref.read(syncProvider.notifier).cleanupTemporaryFiles();
        }
      case TaskProgressUpdate():
        final progress = update.progress;
        ref.read(downloadTasksProvider(update.task.taskId).notifier).update(
              (state) => state.copyWith(
                progress: progress > 0 && progress < 1 ? progress : null,
                downloadSpeed: update.networkSpeedAsString,
              ),
            );
    }
  }

  void setMaxConcurrent(int value) {
    state.configure(
      globalConfig: globalConfig(value),
    );
  }

  void updateTranslations(BuildContext context) async {
    if (kIsWeb) return;
    state.configureNotification(
      running: TaskNotification(context.localized.notificationDownloadingDownloading, '{filename}\n{networkSpeed}'),
      complete: TaskNotification(context.localized.notificationDownloadingFinished, '{filename}'),
      paused: TaskNotification(context.localized.notificationDownloadingPaused, '{filename}'),
      error: TaskNotification(context.localized.notificationDownloadingError, '{filename}'),
      progressBar: true,
    );
  }

  (String, dynamic) globalConfig(int value) => value == 0
      ? ("", "")
      : (
          Config.holdingQueue,
          (
            //maxConcurrent
            value,
            //maxConcurrentByHost
            value,
            //maxConcurrentByGroup
            value,
          ),
        );
}
