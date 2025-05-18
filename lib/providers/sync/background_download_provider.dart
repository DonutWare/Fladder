import 'package:background_downloader/background_downloader.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';

part 'background_download_provider.g.dart';

@Riverpod(keepAlive: true)
class BackgroundDownloader extends _$BackgroundDownloader {
  @override
  FileDownloader build() {
    final maxDownloads = ref.read(clientSettingsProvider.select((value) => value.maxConcurrentDownloads));
    return FileDownloader()
      ..configure(
        globalConfig: maxDownloads == 0
            ? ("", "")
            : (
                Config.holdingQueue,
                (
                  //maxConcurrent
                  maxDownloads,
                  //maxConcurrentByHost
                  maxDownloads,
                  //maxConcurrentByGroup
                  maxDownloads,
                ),
              ),
      )
      ..trackTasks()
      ..configureNotification(
        running: const TaskNotification('Downloading', 'file: {filename}'),
        complete: const TaskNotification('Download finished', 'file: {filename}'),
        paused: const TaskNotification('Download paused', 'file: {filename}'),
        progressBar: true,
      );
  }

  void setMaxConcurrent(int value) {
    state.configure(
      globalConfig: value == 0
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
            ),
    );
  }
}
