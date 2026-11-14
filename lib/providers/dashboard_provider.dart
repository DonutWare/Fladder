import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/dashboard_filters_mixin.dart';
import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/util/list_extensions.dart';

final dashboardProvider = StateNotifierProvider<DashboardNotifier, HomeModel>((ref) {
  return DashboardNotifier(ref);
});

class DashboardNotifier extends StateNotifier<HomeModel> with DashboardFiltersMixin<HomeModel> {
  DashboardNotifier(this.ref) : super(HomeModel()) {
    ref.listen(jellyfinWebSocketProvider, (previous, next) {
      next.whenData(_handleWebSocketEvent);
    });
  }

  @override
  final Ref ref;
  bool _refreshRequested = false;

  late final JellyService api = ref.read(jellyApiProvider);

  Timer? _userDataTimer;

  @override
  FilterSortKey get filterSortKey => FilterSortKey.dashboard;

  @override
  List<DashboardFilterModel> get dashboardFilters => state.dashboardFilters;

  @override
  set dashboardFilters(List<DashboardFilterModel> filters) => state = state.copyWith(dashboardFilters: filters);

  void _handleWebSocketEvent(JellyfinWebSocketEvent event) {
    switch (event) {
      case JellyfinUserDataChanged():
        if (!event.isForUser(ref.read(userProvider)?.id)) return;
        final userData = event.userDataByItemId;
        requests.invalidate(userData.keys);
        _updateDashboardItems(
          (item) => userData[item.id] == null ? item : item.copyWith(userData: userData[item.id]!),
        );
        _userDataTimer?.cancel();
        _userDataTimer = Timer(const Duration(seconds: 1), () {
          refreshNextUpAndResume();
          refreshDashboardFilters((filter) => filter.usesUserData);
        });
      case JellyfinLibraryChanged():
        _removeDashboardItems(event.removedIds);
        final loadedIds = _dashboardItems().map((item) => item.id).toSet();
        for (final id in event.updatedIds.intersection(loadedIds)) {
          unawaited(_fetchChangedItem(id));
        }
        if (event.addedIds.isNotEmpty) {
          if (state.loadedSections.contains(DashboardSorting.recentlyAdded)) {
            unawaited(ref.read(viewsProvider.notifier).fetchRecentlyAdded(libraryIds: event.libraryIds));
          }
          final libraryIds = {...event.libraryIds, ...event.folderIds};
          unawaited(refreshDashboardFilters((filter) => filter.includesLibrary(libraryIds)));
        }
      case JellyfinWebSocketReconnected():
        unawaited(refreshLoadedSections());
    }
  }

  List<ItemBaseModel> _dashboardItems() => [
        ...state.resumeVideo,
        ...state.resumeAudio,
        ...state.resumeBooks,
        ...state.activePrograms,
        ...state.nextUp,
        ...state.dashboardFilters.expand((filter) => filter.items),
        ...ref.read(viewsProvider).dashboardViews.expand((view) => view.recentlyAdded),
      ];

  void _updateDashboardItems(ItemBaseModel Function(ItemBaseModel) update) {
    List<ItemBaseModel> updateList(List<ItemBaseModel> items) => items.map(update).toList();

    state = state.copyWith(
      resumeVideo: updateList(state.resumeVideo),
      resumeAudio: updateList(state.resumeAudio),
      resumeBooks: updateList(state.resumeBooks),
      activePrograms: updateList(state.activePrograms),
      nextUp: updateList(state.nextUp),
      dashboardFilters: state.dashboardFilters
          .map((filter) => DashboardFilterModel(filter: filter.filter, items: updateList(filter.items)))
          .toList(),
    );
    ref.read(viewsProvider.notifier).updateRecentlyAddedItems(update);
  }

  void _removeDashboardItems(Set<String> ids) {
    if (ids.isEmpty) return;
    requests.invalidate(ids);
    List<ItemBaseModel> removeFrom(List<ItemBaseModel> items) => items.where((item) => !ids.contains(item.id)).toList();

    state = state.copyWith(
      resumeVideo: removeFrom(state.resumeVideo),
      resumeAudio: removeFrom(state.resumeAudio),
      resumeBooks: removeFrom(state.resumeBooks),
      activePrograms: removeFrom(state.activePrograms),
      nextUp: removeFrom(state.nextUp),
      dashboardFilters: state.dashboardFilters
          .map((filter) => DashboardFilterModel(filter: filter.filter, items: removeFrom(filter.items)))
          .toList(),
    );
    ref.read(viewsProvider.notifier).removeRecentlyAddedItems(ids);
  }

  Future<void> refreshItem(String id) async {
    await Future.wait([
      if (_dashboardItems().any((item) => item.id == id)) _fetchChangedItem(id),
      refreshNextUpAndResume(),
    ]);
  }

  Future<void> refreshNextUpAndResume() async {
    if (state.loading || !state.loadedSections.contains(DashboardSorting.nextUp)) return;
    try {
      await _fetchNextUpAndResume();
    } catch (_) {}
  }

  Future<void> _fetchChangedItem(String id) async {
    final item = await requests.fetchItem(ref, id);
    if (item != null) _updateDashboardItems((current) => current.id == id ? item : current);
  }

  Future<void> refreshLoadedSections() async {
    if (state.loading) return;
    final sections = state.loadedSections;
    try {
      await Future.wait([
        if (sections.contains(DashboardSorting.liveTV)) _fetchLiveTV(),
        if (sections.contains(DashboardSorting.nextUp)) _fetchNextUpAndResume(),
        if (sections.contains(DashboardSorting.recentlyAdded)) ref.read(viewsProvider.notifier).fetchRecentlyAdded(),
        if (sections.contains(DashboardSorting.filters)) fetchDashboardFilters(),
      ]);
    } catch (_) {}
  }

  Future<void> refreshDashboard() async {
    if (state.loading) {
      _refreshRequested = true;
      return;
    }
    state = state.copyWith(loading: true);

    await ref.read(viewsProvider.notifier).fetchViews();

    final dashboardSorting = ref.read(userProvider.select((value) => value?.userSettings?.dashboardSorting)) ??
        DashboardSorting.defaultSorting;
    final showBanner = ref.read(homeSettingsProvider.select((value) => value.homeBanner)) != HomeBanner.hide;

    // Load sections in the order they're shown, the banner (next-up/resume) first, hidden sections last
    final sections = {
      if (showBanner) DashboardSorting.nextUp,
      ...dashboardSorting.entries.where((e) => e.value).map((e) => e.key),
      ...DashboardSorting.values,
    };

    for (final section in sections) {
      switch (section) {
        case DashboardSorting.liveTV:
          await _fetchLiveTV();
        case DashboardSorting.nextUp:
          await _fetchNextUpAndResume();
        case DashboardSorting.recentlyAdded:
          await ref.read(viewsProvider.notifier).fetchRecentlyAdded();
        case DashboardSorting.filters:
          await fetchDashboardFilters();
      }
      state = state.copyWith(loadedSections: {...state.loadedSections, section});
    }

    state = state.copyWith(loading: false);

    if (_refreshRequested) {
      _refreshRequested = false;
      await refreshDashboard();
    }
  }

  List<CollectionType?> get _viewTypes =>
      ref.read(viewsProvider.select((value) => value.dashboardViews)).map((e) => e.collectionType).toSet().toList();

  static const _limit = 16;

  static final _imagesToFetch = {
    ImageType.logo,
    ImageType.thumb,
    ImageType.primary,
    ImageType.backdrop,
    ImageType.banner,
  }.toList();

  static final _fieldsToFetch = {
    ItemFields.parentid,
    ItemFields.mediastreams,
    ItemFields.mediasources,
    ItemFields.candelete,
    ItemFields.candownload,
    ItemFields.primaryimageaspectratio,
    ItemFields.overview,
    ItemFields.airtime,
  }.toList();

  Future<void> refreshLiveTV() async {
    if (state.loading || !state.loadedSections.contains(DashboardSorting.liveTV)) return;
    try {
      await _fetchLiveTV();
    } catch (_) {}
  }

  Future<void> _fetchLiveTV() async {
    if (!_viewTypes.containsAny([CollectionType.livetv])) {
      state = state.copyWith(activePrograms: []);
      return;
    }

    List<ChannelModel> channels = (await api.liveTvChannelsGet(limit: _limit))
            .body
            ?.items
            ?.map((e) => ChannelModel.fromBaseDto(e, ref))
            .toList() ??
        [];

    channels = await Future.wait(
      channels.map(
        (e) async {
          final programs = await ref.read(liveTvProvider.notifier).fetchProgramsForChannel(e);
          return e.copyChannelWith(
            programs: programs,
          );
        },
      ),
    );

    state = state.copyWith(activePrograms: channels);
  }

  Future<List<ItemBaseModel>?> _fetchResume(MediaType mediaType) async {
    final response = await api.usersUserIdItemsResumeGet(
      enableImageTypes: _imagesToFetch,
      fields: _fieldsToFetch,
      mediaTypes: [mediaType],
      enableTotalRecordCount: false,
      limit: _limit,
    );
    return response.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList();
  }

  Future<void> _fetchNextUpAndResume() async {
    final revision = requests.start(DashboardSorting.nextUp);
    final viewTypes = _viewTypes;

    // Fetched together and applied in one update so the banner and rows don't pop in one by one
    final (resumeVideo, resumeAudio, resumeBooks) = await (
      viewTypes.containsAny([CollectionType.movies, CollectionType.tvshows])
          ? _fetchResume(MediaType.video)
          : Future.value(null),
      viewTypes.contains(CollectionType.music) ? _fetchResume(MediaType.audio) : Future.value(null),
      viewTypes.contains(CollectionType.books) ? _fetchResume(MediaType.book) : Future.value(null),
    ).wait;

    final nextResponse = await api.showsNextUpGet(
      nextUpDateCutoff: DateTime.now().subtract(
          ref.read(clientSettingsProvider.select((value) => value.nextUpDateCutoff ?? const Duration(days: 28)))),
      fields: _fieldsToFetch,
      enableImageTypes: _imagesToFetch,
      imageTypeLimit: 1,
      limit: _limit,
    );

    final next = nextResponse.body?.items
            ?.map(
              (e) => ItemBaseModel.fromBaseDto(e, ref),
            )
            .toList() ??
        [];

    if (!requests.isLatest(DashboardSorting.nextUp, revision)) return;

    state = state.copyWith(
      resumeVideo: resumeVideo,
      resumeAudio: resumeAudio,
      resumeBooks: resumeBooks,
      nextUp: next,
    );
  }

  void clear() {
    _userDataTimer?.cancel();
    requests.clear();
    state = HomeModel();
  }

  @override
  void dispose() {
    _userDataTimer?.cancel();
    super.dispose();
  }
}
