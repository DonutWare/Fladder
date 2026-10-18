import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/models/views_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';

//Known supported collection types
const enableCollectionTypes = {
  CollectionType.movies,
  CollectionType.books,
  CollectionType.tvshows,
  CollectionType.homevideos,
  CollectionType.boxsets,
  CollectionType.playlists,
  CollectionType.photos,
  CollectionType.livetv,
  CollectionType.folders,
  CollectionType.music,
  CollectionType.musicvideos,
};

final viewsProvider = StateNotifierProvider<ViewsNotifier, ViewsModel>((ref) {
  return ViewsNotifier(ref);
});

class ViewsNotifier extends StateNotifier<ViewsModel> {
  ViewsNotifier(this.ref) : super(ViewsModel());

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<ViewsModel?> fetchViews() async {
    if (state.loading) return null;
    try {
      final showAllCollections = ref.read(clientSettingsProvider.select((value) => value.showAllCollectionTypes));
      final response = await api.usersUserIdViewsGet();
      final previousViews = {for (final view in state.views) view.id: view};
      final newList = response.body?.items
              ?.map((e) => ViewModel.fromBodyDto(e, ref))
              .where((element) => showAllCollections ? true : enableCollectionTypes.contains(element.collectionType))
              .map((e) => e.copyWith(recentlyAdded: previousViews[e.id]?.recentlyAdded))
              .toList() ??
          [];

      state = state.copyWith(
          views: _applyLibraryOrdering(newList), dashboardViews: _dashboardViews(newList), loading: false);
      return state;
    } catch (e) {
      return state.copyWith(loading: false);
    }
  }

  Future<void> fetchRecentlyAdded() async {
    final showAllCollections = ref.read(clientSettingsProvider.select((value) => value.showAllCollectionTypes));
    final recentlyAdded = Map.fromEntries(await Future.wait(state.dashboardViews.map((e) async {
      final recents = await api.usersUserIdItemsLatestGet(
        parentId: e.id,
        imageTypeLimit: 1,
        limit: 16,
        includeItemTypes:
            (e.collectionType == CollectionType.books && !showAllCollections) ? [BaseItemKind.book] : null,
        enableImageTypes: [
          ImageType.primary,
          ImageType.backdrop,
          ImageType.thumb,
        ],
        fields: [
          ItemFields.parentid,
          ItemFields.mediastreams,
          ItemFields.mediasources,
          ItemFields.candelete,
          ItemFields.candownload,
          ItemFields.primaryimageaspectratio,
          ItemFields.overview,
        ],
      );
      return MapEntry(e.id, recents.body?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? <ItemBaseModel>[]);
    })));

    ViewModel withRecents(ViewModel view) => recentlyAdded.containsKey(view.id)
        ? view.copyWith(recentlyAdded: recentlyAdded[view.id])
        : view;

    state = state.copyWith(
      views: state.views.map(withRecents).toList(),
      dashboardViews: state.dashboardViews.map(withRecents).toList(),
    );
  }

  List<ViewModel> _dashboardViews(List<ViewModel> views) => _applyLibraryOrdering(views
      .where((element) => !(ref.read(userProvider)?.latestItemsExcludes.contains(element.id) ?? true))
      .toList());

  List<ViewModel> _applyLibraryOrdering(List<ViewModel> views) {
    final orderedViews = ref.read(userProvider)?.userConfiguration?.orderedViews ?? [];
    if (orderedViews.isEmpty) return views;

    final viewMap = {for (var v in views) v.id: v};
    final ordered = <ViewModel>[];

    for (final id in orderedViews) {
      final view = viewMap.remove(id);
      if (view != null) ordered.add(view);
    }
    ordered.addAll(viewMap.values);
    return ordered;
  }

  void clear() {
    state = ViewsModel();
  }
}
