import 'package:flutter/widgets.dart';

import 'package:background_downloader/background_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/localization_helper.dart';

part 'background_download_provider.g.dart';

@Riverpod(keepAlive: true)
class BackgroundDownloader extends _$BackgroundDownloader {
  @override
  FileDownloader build() {
    final maxDownloads = ref.read(clientSettingsProvider.select((value) => value.maxConcurrentDownloads));
    return FileDownloader()
      ..configure(
        globalConfig: globalConfig(maxDownloads),
      )
      ..trackTasks();
  }

  void setMaxConcurrent(int value) {
    state.configure(
      globalConfig: globalConfig(value),
    );
  }

  void updateTranslations(BuildContext context) async {
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
