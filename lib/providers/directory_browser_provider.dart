import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'directory_browser_provider.freezed.dart';
part 'directory_browser_provider.g.dart';

@riverpod
class DirectoryBrowser extends _$DirectoryBrowser {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  DirectoryBrowserModel build() => const DirectoryBrowserModel();

  Future<void> fetchFolders(String? parent) async {
    state = state.copyWith(loading: true);
    try {
      String? startPath = parent;
      if (startPath == null || startPath.isEmpty) {
        final defaultDirectory = (await api.defaultDirectoryGet()).body;
        startPath = defaultDirectory?.path;
        final driveFolders = (await api.getDriveLocations()).body;
        state = state.copyWith(
          parentFolder: driveFolders?.firstOrNull?.path?.replaceAll('"', ''),
          currentPath: startPath,
          paths: driveFolders?.map((e) => e.path ?? '').toList() ?? [],
          loading: false,
        );
      } else {
        final parentPath = (await api.parentPathGet(startPath)).body;
        if (parentPath == null || (startPath.isEmpty || startPath == '/')) {
          final driveFolders = (await api.getDriveLocations()).body;
          state = state.copyWith(
            parentFolder: driveFolders?.firstOrNull?.path?.replaceAll('"', ''),
            currentPath: startPath,
            paths: driveFolders?.map((e) => e.path ?? '').toList() ?? [],
            loading: false,
          );
        } else {
          final directories = (await api.directoryContentsGet(path: startPath, includeDirectories: true)).body;
          state = state.copyWith(
            parentFolder: parentPath.replaceAll('"', ''),
            currentPath: startPath,
            paths: directories?.map((e) => e.path ?? '').toList() ?? [],
            loading: false,
          );
        }
      }
    } catch (e) {
      state = state.copyWith(loading: false);
      rethrow;
    }
  }

  Future<void> moveToRoot() async {
    state = state.copyWith(loading: true);
    try {
      final driveFolders = (await api.getDriveLocations()).body;
      state = state.copyWith(
        parentFolder: driveFolders?.firstOrNull?.path?.replaceAll('"', ''),
        currentPath: null,
        paths: driveFolders?.map((e) => e.path ?? '').toList() ?? [],
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(loading: false);
      rethrow;
    }
  }
}

@Freezed(copyWith: true)
abstract class DirectoryBrowserModel with _$DirectoryBrowserModel {
  const factory DirectoryBrowserModel({
    String? parentFolder,
    String? currentPath,
    @Default([]) List<String> paths,
    @Default(false) bool loading,
  }) = _DirectoryBrowserModel;
}
