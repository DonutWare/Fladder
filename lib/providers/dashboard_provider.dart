import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/map_bool_helper.dart';

final dashboardProvider = StateNotifierProvider<DashboardNotifier, HomeModel>((ref) {
  return DashboardNotifier(ref);
});

class DashboardNotifier extends StateNotifier<HomeModel> {
  DashboardNotifier(this.ref) : super(HomeModel()) {
    ref.listen(libraryFiltersByKeyProvider(FilterSortKey.dashboard), (_, __) => fetchNextUpAndResume());
  }

  final Ref ref;
  bool _refreshRequested = false;

  late final JellyService api = ref.read(jellyApiProvider);

  static const _dashboardFilterLimit = 15;

  Future<DashboardFilterModel> _fetchDashboardFilter(LibraryFiltersModel filter) async {
    final searchTerm = filter.filter.searchQuery.isNotEmpty ? filter.filter.searchQuery : null;
    final libraryIds = filter.ids.isEmpty ? [null] : filter.ids;
    final libraryItems = await Future.wait(
      libraryIds.map(
        (id) => api.itemsGet(
          parentId: id,
          searchTerm: searchTerm,
          genres: filter.filter.genres.included,
          tags: filter.filter.tags.included,
          recursive: searchTerm?.isNotEmpty == true ? true : filter.filter.recursive,
          officialRatings: filter.filter.officialRatings.included,
          years: filter.filter.years.included,
          isMissing: false,
          limit: _dashboardFilterLimit,
          collapseBoxSetItems: false,
          studioIds: filter.filter.studios.included.map((e) => e.id).toList(),
          sortBy: filter.filter.sortingOption.toSortBy,
          sortOrder: [filter.filter.sortOrder.sortOrder],
          fields: [
            ItemFields.genres,
            ItemFields.parentid,
            ItemFields.tags,
            ItemFields.datecreated,
            ItemFields.datelastmediaadded,
            ItemFields.overview,
            ItemFields.originaltitle,
            ItemFields.customrating,
            ItemFields.primaryimageaspectratio,
          ],
          isFavorite: filter.filter.favourites,
          filters: filter.filter.itemFilters.included,
          includeItemTypes: filter.filter.types.included.map((e) => e.dtoKind).expand((e) => e).toList(),
        ),
      ),
    );

    final items = libraryItems.expand((response) => response.body?.items ?? []).whereType<ItemBaseModel>().toList();

    return DashboardFilterModel(filter: filter, items: items);
  }

  Future<List<DashboardFilterModel>> _fetchDashboardFilters() async {
    final filters = ref.read(libraryFiltersByKeyProvider(FilterSortKey.dashboard));
    return Future.wait(filters.map(_fetchDashboardFilter));
  }

  Future<void> fetchNextUpAndResume() async {
    if (state.loading) {
      _refreshRequested = true;
      return;
    }
    state = state.copyWith(loading: true);
    final viewTypes =
        ref.read(viewsProvider.select((value) => value.dashboardViews)).map((e) => e.collectionType).toSet().toList();
    final limit = 16;

    final imagesToFetch = {
      ImageType.logo,
      ImageType.thumb,
      ImageType.primary,
      ImageType.backdrop,
      ImageType.banner,
    }.toList();

    final fieldsToFetch = {
      ItemFields.parentid,
      ItemFields.mediastreams,
      ItemFields.mediasources,
      ItemFields.candelete,
      ItemFields.candownload,
      ItemFields.primaryimageaspectratio,
      ItemFields.overview,
      ItemFields.airtime,
    };

    if (viewTypes.containsAny([CollectionType.livetv])) {
      List<ChannelModel> channels = (await api.liveTvChannelsGet(limit: limit))
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
    } else {
      state = state.copyWith(activePrograms: []);
    }

    if (viewTypes.containsAny([CollectionType.movies, CollectionType.tvshows])) {
      final resumeVideoResponse = await api.usersUserIdItemsResumeGet(
        enableImageTypes: imagesToFetch,
        fields: fieldsToFetch.toList(),
        mediaTypes: [MediaType.video],
        enableTotalRecordCount: false,
        limit: limit,
      );

      state = state.copyWith(
        resumeVideo: resumeVideoResponse.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList(),
      );
    }

    if (viewTypes.contains(CollectionType.music)) {
      final resumeAudioResponse = await api.usersUserIdItemsResumeGet(
        enableImageTypes: imagesToFetch,
        fields: fieldsToFetch.toList(),
        mediaTypes: [MediaType.audio],
        enableTotalRecordCount: false,
        limit: limit,
      );

      state = state.copyWith(
        resumeAudio: resumeAudioResponse.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList(),
      );
    }

    if (viewTypes.contains(CollectionType.books)) {
      final resumeBookResponse = await api.usersUserIdItemsResumeGet(
        enableImageTypes: imagesToFetch,
        fields: fieldsToFetch.toList(),
        mediaTypes: [MediaType.book],
        enableTotalRecordCount: false,
        limit: limit,
      );

      state = state.copyWith(
        resumeBooks: resumeBookResponse.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList(),
      );
    }

    final nextResponse = await api.showsNextUpGet(
      nextUpDateCutoff: DateTime.now().subtract(
          ref.read(clientSettingsProvider.select((value) => value.nextUpDateCutoff ?? const Duration(days: 28)))),
      fields: fieldsToFetch.toList(),
      enableImageTypes: imagesToFetch,
      imageTypeLimit: 1,
    );

    final next = nextResponse.body?.items
            ?.map(
              (e) => ItemBaseModel.fromBaseDto(e, ref),
            )
            .toList() ??
        [];

    final dashboardFilters = await _fetchDashboardFilters();
    state = state.copyWith(nextUp: next, dashboardFilters: dashboardFilters, loading: false);

    if (_refreshRequested) {
      _refreshRequested = false;
      await fetchNextUpAndResume();
    }
  }

  void clear() {
    state = HomeModel();
  }
}
