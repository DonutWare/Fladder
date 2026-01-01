import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_service_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';

final seerrDashboardProvider = StateNotifierProvider<SeerrDashboardNotifier, SeerrDashboardModel>((ref) {
  return SeerrDashboardNotifier(ref);
});

class SeerrDashboardNotifier extends StateNotifier<SeerrDashboardModel> {
  SeerrDashboardNotifier(this.ref) : super(const SeerrDashboardModel());

  final Ref ref;

  SeerrService get api => ref.read(seerrApiProvider);

  Future<void> fetchDashboard() async {
    await Future.wait([
      fetchRecentRequests(),
      fetchTrending(),
      fetchPopularMovies(),
      fetchExpectedMovies(),
      fetchExpectedSeries(),
      fetchRecentlyAdded(),
    ]);
  }

  Future<void> fetchRecentlyAdded() async {
    try {
      final response = await api.media(
        filter: MediaFilter.allavailable,
        take: 20,
        sort: MediaSort.mediaadded,
        skip: 0,
      );

      if (!response.isSuccessful || response.body == null) {
        return;
      }

      final media = response.body?.results ?? const <SeerrMedia>[];
      final posters = await _postersFrom(media, _posterForMedia);

      state = state.copyWith(recentlyAdded: posters);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchRecentRequests() async {
    try {
      final response = await api.listRequests(
        filter: RequestFilter.all,
        take: 10,
        skip: 0,
        sort: RequestSort.modified,
        sortDirection: SortDirection.desc,
      );

      if (!response.isSuccessful || response.body == null) {
        return;
      }

      final requests = response.body?.results ?? const [];
      final items = await _postersFrom(requests, _posterForRequest);

      state = state.copyWith(recentRequests: items);
    } catch (_) {
      return;
    }
  }

  Future<void> fetchTrending() async =>
      _safeSet(() => api.discoverTrending(), (items) => state.copyWith(trending: items));

  Future<void> fetchPopularMovies() async =>
      _safeSet(() => api.discoverPopularMovies(), (items) => state.copyWith(popularMovies: items));

  Future<void> fetchExpectedMovies() async =>
      _safeSet(() => api.discoverExpectedMovies(), (items) => state.copyWith(expectedMovies: items));

  Future<void> fetchExpectedSeries() async =>
      _safeSet(() => api.discoverExpectedSeries(), (items) => state.copyWith(expectedSeries: items));

  Future<SeerrDashboardPosterModel?> _posterForMedia(SeerrMedia media) async {
    final tmdbId = media.tmdbId;
    final tvdbId = media.tvdbId;
    if (tmdbId == null && tvdbId == null) return null;
    return api.fetchDashboardPosterFromIds(tmdbId: tmdbId, tvdbId: tvdbId);
  }

  Future<SeerrDashboardPosterModel?> _posterForRequest(SeerrMediaRequest request) async {
    final media = request.media;
    if (media == null) return null;
    final tmdbId = media.tmdbId;
    final tvdbId = media.tvdbId;
    if (tmdbId == null && tvdbId == null) return null;
    return api.fetchDashboardPosterFromIds(tmdbId: tmdbId, tvdbId: tvdbId);
  }

  Future<void> _safeSet(
    Future<List<SeerrDashboardPosterModel>> Function() load,
    SeerrDashboardModel Function(List<SeerrDashboardPosterModel>) apply,
  ) async {
    try {
      final items = await load();
      state = apply(items);
    } catch (_) {
      return;
    }
  }

  Future<List<SeerrDashboardPosterModel>> _postersFrom<T>(
    Iterable<T> items,
    Future<SeerrDashboardPosterModel?> Function(T item) mapper,
  ) async {
    final posters = <SeerrDashboardPosterModel>[];
    for (final item in items) {
      final poster = await mapper(item);
      if (poster != null) posters.add(poster);
    }
    return posters;
  }
}
