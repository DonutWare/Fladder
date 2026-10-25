import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
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

class DashboardNotifier extends StateNotifier<HomeModel> {
  DashboardNotifier(this.ref) : super(HomeModel());

  final Ref ref;
  bool _refreshRequested = false;

  late final JellyService api = ref.read(jellyApiProvider);

  static const _dashboardFilterLimit = 15;

  Future<List<DashboardFilterModel>> _fetchDashboardFilters() async {
    final filters = ref.read(libraryFiltersByKeyProvider(FilterSortKey.dashboard));
    return Future.wait(
      filters.map(
        (e) => e.fetchDashboardFilter(ref, limit: _dashboardFilterLimit),
      ),
    );
  }

  Future<void> fetchDashboardFilters() async {
    final dashboardFilters = await _fetchDashboardFilters();
    state = state.copyWith(dashboardFilters: dashboardFilters);
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
    );

    final next = nextResponse.body?.items
            ?.map(
              (e) => ItemBaseModel.fromBaseDto(e, ref),
            )
            .toList() ??
        [];

    state = state.copyWith(
      resumeVideo: resumeVideo,
      resumeAudio: resumeAudio,
      resumeBooks: resumeBooks,
      nextUp: next,
    );
  }

  void clear() {
    state = HomeModel();
  }
}
