import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart' as enums;
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/home_preferences_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';

final homePreferencesProvider = StateNotifierProvider<HomePreferencesNotifier, HomePreferencesModel>((ref) {
  return HomePreferencesNotifier(ref);
});

class HomePreferencesNotifier extends StateNotifier<HomePreferencesModel> {
  HomePreferencesNotifier(this.ref) : super(const HomePreferencesModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<void> load() async {
    if (state.loading) return;
    state = state.copyWith(loading: true);

    final user = ref.read(userProvider);
    final userConfig = user?.userConfiguration;
    final views = ref.read(viewsProvider).views;

    final orderedLibraryIds = _buildOrderedLibraryIds(
      userConfig?.orderedViews ?? [],
      views.map((v) => v.id).toList(),
    );

    final foldersResponse = await api.libraryMediaFolders();
    final allFolders = foldersResponse.body?.items ?? [];
    final availableFolders = allFolders
        .where((f) => _isGroupableFolder(f.collectionType))
        .where((f) => f.id != null && f.id!.isNotEmpty)
        .map((f) => (id: f.id!, name: f.name ?? f.id!))
        .toList();

    state = state.copyWith(
      orderedLibraryIds: orderedLibraryIds,
      latestItemsExcludes: user?.latestItemsExcludes ?? [],
      hidePlayedInLatest: userConfig?.hidePlayedInLatest ?? false,
      groupedFolders: (userConfig?.groupedFolders ?? []).toList(),
      availableFolders: availableFolders,
      loading: false,
    );
  }

  List<String> _buildOrderedLibraryIds(
    List<String> serverOrder,
    List<String> availableIds,
  ) {
    final ordered = <String>[];
    for (final id in serverOrder) {
      if (availableIds.contains(id)) {
        ordered.add(id);
      }
    }
    for (final id in availableIds) {
      if (!ordered.contains(id)) {
        ordered.add(id);
      }
    }
    return ordered;
  }

  void setOrderedLibraryIds(List<String> ids) {
    state = state.copyWith(orderedLibraryIds: ids);
  }

  void setLatestItemsExcludes(List<String> ids) {
    state = state.copyWith(latestItemsExcludes: ids);
  }

  void setHidePlayedInLatest(bool value) {
    state = state.copyWith(hidePlayedInLatest: value);
  }

  void setGroupedFolders(List<String> ids) {
    state = state.copyWith(groupedFolders: ids);
  }

  Future<String?> save() async {
    try {
      await _saveLibraryPreferences();
      await ref.read(userProvider.notifier).updateInformation();
      await ref.read(viewsProvider.notifier).fetchViews();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _saveLibraryPreferences() async {
    final user = ref.read(userProvider);
    final currentConfig = user?.userConfiguration;
    if (currentConfig == null) return;

    final updated = currentConfig.copyWith(
      orderedViews: state.orderedLibraryIds,
      latestItemsExcludes: state.latestItemsExcludes,
      hidePlayedInLatest: state.hidePlayedInLatest,
      groupedFolders: state.groupedFolders,
    );
    await api.updateUserConfiguration(updated);
  }

  static const _groupableTypes = {
    enums.CollectionType.movies,
    enums.CollectionType.tvshows,
    enums.CollectionType.music,
    enums.CollectionType.homevideos,
    enums.CollectionType.photos,
  };

  bool _isGroupableFolder(enums.CollectionType? type) {
    if (type == null) return true;
    return _groupableTypes.contains(type);
  }
}
