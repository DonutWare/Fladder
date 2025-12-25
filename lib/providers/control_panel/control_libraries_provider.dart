import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as jelly;
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'control_libraries_provider.freezed.dart';
part 'control_libraries_provider.g.dart';

@riverpod
class ControlLibraries extends _$ControlLibraries {
  JellyService get api => ref.read(jellyApiProvider);

  @override
  ControlLibrariesModel build() => ControlLibrariesModel();

  Future<void> fetchInfo({bool clearSelected = false}) async {
    final cultures = (await api.localizationCulturesGet()).body ?? [];
    final countries = (await api.localizationCountriesGet()).body ?? [];
    final virtualFolders = (await api.libraryVirtualFoldersGet()).body ?? [];
    final libraries = virtualFolders
        .map((e) => ViewModel.fromVirtualFolder(
              e,
              ref,
            ))
        .toList();
    state = state.copyWith(
      availableLibraries: libraries,
      cultures: cultures,
      countries: countries,
    );
    if (clearSelected) {
      state = state.copyWith(
        selectedLibrary: null,
        newVirtualFolder: null,
      );
    } else if (state.selectedLibrary != null) {
      await selectLibrary(state.selectedLibrary!);
    }
  }

  Future<void> selectLibrary(ViewModel library) async {
    final virtualFolders = (await api.libraryVirtualFoldersGet()).body ?? [];
    final availableOptions = (await api.librariesAvailableOptionsGet()).body;

    state = state.copyWith(
      selectedLibrary: library,
      virtualFolders: virtualFolders,
      availableOptions: availableOptions,
      newVirtualFolder: null,
    );
  }

  Future<void> deleteLibrary(ViewModel library) async {
    if (kDebugMode) {
      log("Deleting library: ${library.name}");
      return;
    }
    await api.userViewsViewIdDelete(viewId: library.id);
  }

  Future<void> updateLibraryLocations(String? libraryId, List<String> locations) async {
    if (state.newVirtualFolder != null) {
      state = state.copyWith(
        newVirtualFolder: state.newVirtualFolder!.copyWith(
          locations: locations,
        ),
      );
      return;
    }

    final currentLibrary = state.virtualFolders.firstWhere((element) => element.itemId == libraryId);
    state = state.copyWith(
      virtualFolders: state.virtualFolders.map((e) {
        if (e.itemId == libraryId) {
          return currentLibrary.copyWith(
            locations: locations,
          );
        }
        return e;
      }).toList(),
    );
  }

  Future<void> updateSelectedLibraryOptions(jelly.LibraryOptions? options) async {
    if (state.newVirtualFolder != null) {
      state = state.copyWith(
        newVirtualFolder: state.newVirtualFolder!.copyWith(
          libraryOptions: options,
        ),
      );
      return;
    }
    final selectedLibrary = state.selectedLibrary;
    if (selectedLibrary == null || options == null) return;

    state = state.copyWith(
      virtualFolders: state.virtualFolders.map((e) {
        if (e.itemId == selectedLibrary.id) {
          return e.copyWith(
            libraryOptions: options,
          );
        }
        return e;
      }).toList(),
    );
  }

  Future<void> updateNewFolder(jelly.VirtualFolderInfo? folder) async {
    if (state.newVirtualFolder == null) return;
    state = state.copyWith(
      newVirtualFolder: folder,
    );
  }

  Future<String?> commitLibraryOptions(
    String? libraryId,
    jelly.LibraryOptions? options,
  ) async {
    if (state.newVirtualFolder != null) {
      final newFolder = state.newVirtualFolder!;
      final response = await api.virtualFoldersPost(
        newFolder: newFolder,
        refreshLibrary: true,
      );
      if (response.isSuccessful) {
        state = state.copyWith(
          newVirtualFolder: null,
        );
        fetchInfo(clearSelected: true);
        return null;
      } else {
        return "${response.statusCode}: ${response.body}";
      }
    }
    if (libraryId == null || options == null) return null;
    final response = await api.virtualFoldersUpdate(
      id: libraryId,
      libraryOptions: options,
    );
    if (response.isSuccessful) {
      return null;
    } else {
      return "${response.statusCode}: ${response.body}";
    }
  }

  Future<void> createNewLibrary() async {
    state = state.copyWith(
      newVirtualFolder: const jelly.VirtualFolderInfo(
        libraryOptions: jelly.LibraryOptions(
          enabled: true,
        ),
      ),
    );
  }

  Future<void> updateNewLibraryType(CollectionTypeOptions selectedType) async {
    if (state.newVirtualFolder == null) return;
    final availableOptions = (await api.librariesAvailableOptionsGet(
      libraryContentType: switch (selectedType) {
        CollectionTypeOptions.swaggerGeneratedUnknown =>
          LibrariesAvailableOptionsGetLibraryContentType.swaggerGeneratedUnknown,
        CollectionTypeOptions.movies => LibrariesAvailableOptionsGetLibraryContentType.movies,
        CollectionTypeOptions.tvshows => LibrariesAvailableOptionsGetLibraryContentType.tvshows,
        CollectionTypeOptions.music => LibrariesAvailableOptionsGetLibraryContentType.music,
        CollectionTypeOptions.musicvideos => LibrariesAvailableOptionsGetLibraryContentType.musicvideos,
        CollectionTypeOptions.homevideos => LibrariesAvailableOptionsGetLibraryContentType.homevideos,
        CollectionTypeOptions.boxsets => LibrariesAvailableOptionsGetLibraryContentType.boxsets,
        CollectionTypeOptions.books => LibrariesAvailableOptionsGetLibraryContentType.books,
        CollectionTypeOptions.mixed => LibrariesAvailableOptionsGetLibraryContentType.folders,
      },
      isNewLibrary: true,
    ))
        .body;

    state = state.copyWith(
      newVirtualFolder: state.newVirtualFolder!.copyWith(
        collectionType: selectedType,
        libraryOptions: state.newVirtualFolder?.libraryOptions?.copyWith(
          subtitleFetcherOrder: availableOptions?.subtitleFetchers?.map((e) => e.name).nonNulls.toList(),
          localMetadataReaderOrder: availableOptions?.metadataReaders?.map((e) => e.name).nonNulls.toList(),
          metadataSavers: [
            ...?availableOptions?.metadataReaders?.where((e) => e.defaultEnabled == false).map((e) => e.name).nonNulls
          ],
          disabledLocalMetadataReaders: [
            ...?availableOptions?.metadataReaders?.where((e) => e.defaultEnabled == false).map((e) => e.name).nonNulls
          ],
          typeOptions: availableOptions?.typeOptions
              ?.map(
                (e) => jelly.TypeOptions(
                  type: e.type,
                  metadataFetchers:
                      e.metadataFetchers?.map((e) => e.defaultEnabled == true ? e.name : null).nonNulls.toList(),
                  metadataFetcherOrder: e.metadataFetchers?.map((e) => e.name).nonNulls.toList(),
                  imageFetcherOrder: e.imageFetchers?.map((e) => e.name).nonNulls.toList(),
                  imageFetchers:
                      e.imageFetchers?.map((e) => e.defaultEnabled == true ? e.name : null).nonNulls.toList(),
                ),
              )
              .toList(),
        ),
      ),
      availableOptions: availableOptions,
    );
  }
}

@Freezed(copyWith: true)
abstract class ControlLibrariesModel with _$ControlLibrariesModel {
  const ControlLibrariesModel._();

  factory ControlLibrariesModel({
    @Default([]) List<ViewModel> availableLibraries,
    ViewModel? selectedLibrary,
    jelly.VirtualFolderInfo? newVirtualFolder,
    @Default([]) List<jelly.CultureDto> cultures,
    @Default([]) List<jelly.CountryInfo> countries,
    @Default([]) List<jelly.VirtualFolderInfo> virtualFolders,
    jelly.LibraryOptionsResultDto? availableOptions,
  }) = _ControlLibrariesModel;

  bool get isSaveAble {
    if (newVirtualFolder != null) {
      final locations = newVirtualFolder?.locations;
      final collectionType = newVirtualFolder?.collectionType;
      if (locations == null || locations.isEmpty) {
        return false;
      }
      if (collectionType == null) {
        return false;
      }
      if (newVirtualFolder?.name == null || newVirtualFolder?.name?.isEmpty == true) {
        return false;
      }
      if (newVirtualFolder?.libraryOptions == null) {
        return false;
      }
      return true;
    }
    return true;
  }

  CollectionType? get currentCollectionType =>
      _fromCollectionOptions(newVirtualFolder?.collectionType) ?? selectedLibrary?.collectionType;

  CollectionType? _fromCollectionOptions(CollectionTypeOptions? options) {
    switch (options) {
      case CollectionTypeOptions.movies:
        return CollectionType.movies;
      case CollectionTypeOptions.tvshows:
        return CollectionType.tvshows;
      case CollectionTypeOptions.music:
        return CollectionType.music;
      case CollectionTypeOptions.homevideos:
        return CollectionType.homevideos;
      case CollectionTypeOptions.boxsets:
        return CollectionType.boxsets;
      case CollectionTypeOptions.books:
        return CollectionType.books;
      case CollectionTypeOptions.mixed:
        return CollectionType.folders;
      default:
        return null;
    }
  }
}
