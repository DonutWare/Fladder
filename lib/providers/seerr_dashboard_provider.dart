import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_service_provider.dart';
import 'package:fladder/seerr/seerr_open_api.enums.swagger.dart' as seerr_enums;
import 'package:fladder/seerr/seerr_open_api.swagger.dart' as seerr;

final seerrDashboardProvider = StateNotifierProvider<SeerrDashboardNotifier, SeerrDashboardModel>((ref) {
  return SeerrDashboardNotifier(ref);
});

class SeerrDashboardNotifier extends StateNotifier<SeerrDashboardModel> {
  SeerrDashboardNotifier(this.ref) : super(const SeerrDashboardModel());

  final Ref ref;

  SeerrService get api => ref.read(seerrApiProvider);

  Future<void> fetchDashboard() async {
    await fetchRecentlyAdded();
    await fetchRecentRequests();
    await fetchTrending();
    await fetchPopularMovies();
    await fetchExpectedMovies();
    await fetchExpectedSeries();
  }

  Future<void> fetchRecentlyAdded() async {
    try {
      final response = await api.media(
        filter: seerr_enums.MediaGetFilter.allavailable,
        take: 20,
        sort: seerr_enums.MediaGetSort.mediaadded,
        skip: 0,
      );

      if (!response.isSuccessful || response.body == null) {
        return;
      }

      final media = response.body?.results ?? const <seerr.MediaInfo>[];
      final posters = <SeerrDashboardPosterModel>[];

      for (final m in media) {
        final poster = await _posterForMedia(m);
        if (poster == null) continue;

        posters.add(poster);
      }

      state = state.copyWith(recentlyAdded: posters);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchRecentRequests() async {
    try {
      final response = await api.listRequests(
        filter: seerr_enums.RequestGetFilter.all,
        take: 10,
        skip: 0,
        sort: seerr_enums.RequestGetSort.modified,
        sortDirection: seerr_enums.RequestGetSortDirection.desc,
      );

      if (!response.isSuccessful || response.body == null) {
        return;
      }

      final requests = response.body?.results ?? const <seerr.MediaRequest>[];
      final items = <SeerrDashboardRequestItem>[];

      for (final request in requests) {
        final poster = await _posterForRequest(request);
        if (poster == null) continue;
        final statusRaw = request.status?.toInt();
        items.add(
          SeerrDashboardRequestItem(
            poster: poster,
            meta: SeerrDashboardRequestMeta(
              status: SeerrRequestStatus.fromRaw(statusRaw),
              is4k: request.is4k == true,
            ),
          ),
        );
      }

      state = state.copyWith(
        recentRequests: items,
      );
    } catch (_) {
      return;
    }
  }

  Future<void> fetchTrending() async {
    try {
      final items = await api.discoverTrending();
      state = state.copyWith(trending: items);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchPopularMovies() async {
    try {
      final items = await api.discoverPopularMovies();
      state = state.copyWith(popularMovies: items);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchExpectedMovies() async {
    try {
      final items = await api.discoverExpectedMovies();
      state = state.copyWith(expectedMovies: items);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchExpectedSeries() async {
    try {
      final items = await api.discoverExpectedSeries();
      state = state.copyWith(expectedSeries: items);
    } catch (_) {
      return;
    }
  }

  Future<SeerrDashboardPosterModel?> _posterForMedia(seerr.MediaInfo media) async {
    final tmdbId = media.tmdbId?.toInt();
    final tvdbId = media.tvdbId?.toInt();
    if (tmdbId == null && tvdbId == null) return null;
    return api.fetchDashboardPosterFromIds(tmdbId: tmdbId, tvdbId: tvdbId);
  }

  Future<SeerrDashboardPosterModel?> _posterForRequest(seerr.MediaRequest request) async {
    final tmdbId = request.media?.tmdbId?.toInt();
    final tvdbId = request.media?.tvdbId?.toInt();
    if (tmdbId == null && tvdbId == null) return null;
    return api.fetchDashboardPosterFromIds(tmdbId: tmdbId, tvdbId: tvdbId);
  }
}
