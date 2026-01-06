import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as jelly;
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_dashboard_provider.freezed.dart';
part 'control_dashboard_provider.g.dart';

@riverpod
class ControlDashboard extends _$ControlDashboard {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ControlDashboardModel build() {
    return ControlDashboardModel();
  }

  Future<void> refreshDashboard() async {
    final serverInfo = (await api.systemInfoGet()).bodyOrThrow;
    final itemCounts = (await api.systemInfoCounts()).body;
    final storageInfo = (await api.getStorage()).body;

    state = ControlDashboardModel(
      serverName: serverInfo.serverName,
      serverVersion: serverInfo.version,
      webVersion: serverInfo.version,
      isShuttingDown: serverInfo.isShuttingDown ?? false,
      itemCounts: itemCounts,
      storagePaths: storageInfo,
    );
  }

  Future<void> restartServer() async {
    await api.systemRestartPost();
    state = state.copyWith(isShuttingDown: true);
  }

  Future<void> shutdownServer() async {
    await api.systemShutdownPost();
    state = state.copyWith(isShuttingDown: true);
  }

  Future<void> refreshLibrary() async {
    await api.libraryRefreshPost();
  }
}

@Freezed(copyWith: true)
abstract class ControlDashboardModel with _$ControlDashboardModel {
  factory ControlDashboardModel({
    String? serverName,
    String? serverVersion,
    String? webVersion,
    @Default(false) bool isShuttingDown,
    jelly.ItemCounts? itemCounts,
    jelly.SystemStorageDto? storagePaths,
  }) = _ControlDashboardModel;
}
