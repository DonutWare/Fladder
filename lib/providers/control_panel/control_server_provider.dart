import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as jelly;
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_server_provider.freezed.dart';
part 'control_server_provider.g.dart';

@riverpod
class ControlServer extends _$ControlServer {
  JellyService get api => ref.read(jellyApiProvider);

  jelly.ServerConfiguration? saveConfig;

  @override
  ControlServerModel build() {
    return ControlServerModel();
  }

  Future<void> update(ControlServerModel newModel) async {
    state = newModel;
  }

  Future<void> save() async {
    await updateInfo(state);
  }

  Future<void> fetchSettings() async {
    saveConfig = (await api.systemConfigurationGet()).body;
    final options = (await api.localizationOptions()).body;
    state = state.copyWith(
      name: saveConfig?.serverName ?? "",
      availableLanguages: options,
      quickConnectEnabled: saveConfig?.quickConnectAvailable ?? false,
      cachePath: saveConfig?.cachePath ?? "",
      metaDataPath: saveConfig?.metadataPath ?? "",
      maxConcurrentLibraryScan: saveConfig?.libraryScanFanoutConcurrency ?? 1,
      maxImageDecodingThreads: saveConfig?.parallelImageEncodingLimit ?? 1,
    );
  }

  Future<void> updateInfo(ControlServerModel newModel) {
    if (saveConfig == null) {
      throw Exception("Cannot update control server settings before fetching them.");
    }
    return api.systemConfigurationPost(
      saveConfig!.copyWith(
        serverName: newModel.name,
        quickConnectAvailable: newModel.quickConnectEnabled,
        cachePath: newModel.cachePath,
        metadataPath: newModel.metaDataPath,
        libraryScanFanoutConcurrency: newModel.maxConcurrentLibraryScan,
        parallelImageEncodingLimit: newModel.maxImageDecodingThreads,
      ),
    );
  }
}

@Freezed(copyWith: true)
abstract class ControlServerModel with _$ControlServerModel {
  factory ControlServerModel({
    @Default("") String name,
    jelly.LocalizationOption? language,
    List<jelly.LocalizationOption>? availableLanguages,
    @Default("") String cachePath,
    @Default("") String metaDataPath,
    @Default(false) bool quickConnectEnabled,
    @Default(1) int maxConcurrentLibraryScan,
    @Default(1) int maxImageDecodingThreads,
  }) = _ControlServerModel;
}
