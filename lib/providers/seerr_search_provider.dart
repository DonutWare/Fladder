import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/map_bool_helper.dart';

part 'seerr_search_provider.freezed.dart';
part 'seerr_search_provider.g.dart';

@riverpod
class SeerrSearch extends _$SeerrSearch {
  @override
  SeerrSearchModel build() => SeerrSearchModel();

  Future<void> init() async {
    if (state.initialized) return;

    state = state.copyWith(isLoading: true);

    try {
      final api = ref.read(seerrApiProvider);

      final watchRegionsResponse = await api.getWatchProviderRegions();
      final watchRegions = watchRegionsResponse.body ?? [];

      state = state.copyWith(
        watchProviderRegions: watchRegions,
        initialized: true,
        isLoading: false,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, initialized: true);
    }
  }

  Future<void> setSearchMode(SeerrSearchMode mode) async {
    final query = mode != SeerrSearchMode.search ? '' : state.query;

    (Map<SeerrGenre, bool>, Map<SeerrWatchProvider, bool>, Map<SeerrCertification, bool>) currentFilters =
        (state.genres, state.watchProviders, state.certifications);

    if (mode == SeerrSearchMode.discoverMovies) {
      currentFilters = await _fetchMovieData();
    } else if (mode == SeerrSearchMode.discoverTv) {
      currentFilters = await _fetchTvData();
    }

    state = state.copyWith(
      searchMode: mode,
      query: query,
      currentPage: 1,
      totalPages: null,
      results: [],
      genres: currentFilters.$1,
      watchProviders: currentFilters.$2,
      certifications: currentFilters.$3,
      filters: state.filters.copyWith(
        genres: currentFilters.$1,
        watchProviders: currentFilters.$2,
        certifications: currentFilters.$3,
      ),
    );

    if (mode != SeerrSearchMode.search || state.query.isNotEmpty) {
      submit();
    }
  }

  void setQuery(String value) {
    state = state.copyWith(query: value);
  }

  Future<void> submit([String? value]) async {
    final query = (value ?? state.query);

    if (query.isNotEmpty && state.searchMode != SeerrSearchMode.search) {
      state = state.copyWith(searchMode: SeerrSearchMode.search);
    }

    state = state.copyWith(query: query, currentPage: 1, totalPages: null);

    if (state.searchMode == SeerrSearchMode.search && query.isEmpty) {
      state = state.copyWith(results: []);
      return;
    }

    state = state.copyWith(isLoading: true);
    await _fetchResults(page: 1, isLoadingMore: false);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.totalPages == null || state.currentPage >= state.totalPages!) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    await _fetchResults(page: state.currentPage + 1, isLoadingMore: true);
  }

  Future<void> _fetchResults({required int page, required bool isLoadingMore}) async {
    try {
      final api = ref.read(seerrApiProvider);
      List<SeerrDashboardPosterModel> items = [];
      int? totalPages;

      switch (state.searchMode) {
        case SeerrSearchMode.search:
          final response = await api.search(query: state.query, page: page);
          final results = response.body?.results ?? [];
          totalPages = response.body?.totalPages;
          for (final result in results) {
            final poster = api.posterFromDiscoverItem(result);
            if (poster != null) items.add(poster);
          }
          break;

        case SeerrSearchMode.trending:
          final response = await api.discoverTrendingPaged(page: page);
          final results = response.body?.results ?? [];
          totalPages = response.body?.totalPages;
          for (final result in results) {
            final poster = api.posterFromDiscoverItem(result);
            if (poster != null) items.add(poster);
          }
          break;

        case SeerrSearchMode.discoverMovies:
          final codes = _buildCertificationFilter();
          final response = await api.discoverMovies(
            page: page,
            sortBy: state.filters.sortBy.valueForMode(SeerrSearchMode.discoverMovies),
            genre: _getGenreIds(),
            studio: state.filters.studio?.id,
            primaryReleaseDateGte: _getYearGte(),
            primaryReleaseDateLte: _getYearLte(),
            voteAverageGte: state.filters.voteAverageGte,
            voteAverageLte: state.filters.voteAverageLte,
            withRuntimeGte: state.filters.runtimeGte,
            withRuntimeLte: state.filters.runtimeLte,
            watchRegion: state.filters.watchRegion,
            watchProviders: _getWatchProviderIds(),
            certification: codes,
            certificationCountry: state.filters.watchRegion ?? 'US',
            certificationMode: codes != null ? 'exact' : null,
          );
          final results = response.body?.results ?? [];
          totalPages = response.body?.totalPages;
          for (final result in results) {
            final poster = api.posterFromDiscoverItem(result);
            if (poster != null) items.add(poster);
          }
          break;

        case SeerrSearchMode.discoverTv:
          final response = await api.discoverTv(
            page: page,
            sortBy: state.filters.sortBy.valueForMode(SeerrSearchMode.discoverTv),
            genre: _getGenreIds(),
            firstAirDateGte: _getYearGte(),
            firstAirDateLte: _getYearLte(),
            voteAverageGte: state.filters.voteAverageGte,
            voteAverageLte: state.filters.voteAverageLte,
            watchRegion: state.filters.watchRegion,
            watchProviders: _getWatchProviderIds(),
          );
          final results = response.body?.results ?? [];
          totalPages = response.body?.totalPages;
          for (final result in results) {
            final poster = api.posterFromDiscoverItem(result);
            if (poster != null) items.add(poster);
          }
          break;
      }

      if (isLoadingMore) {
        state = state.copyWith(
          results: [...state.results, ...items],
          currentPage: page,
          isLoadingMore: false,
        );
      } else {
        state = state.copyWith(
          results: items,
          isLoading: false,
          currentPage: page,
          totalPages: totalPages,
        );
      }
    } catch (error) {
      if (isLoadingMore) {
        state = state.copyWith(isLoadingMore: false);
      } else {
        state = state.copyWith(results: [], isLoading: false);
      }
    }
  }

  void setGenres(Map<SeerrGenre, bool> genres) {
    state = state.copyWith(
      genres: genres,
      filters: state.filters.copyWith(genres: genres),
    );
  }

  Future<(Map<SeerrGenre, bool>, Map<SeerrWatchProvider, bool>, Map<SeerrCertification, bool>)>
      _fetchMovieData() async {
    try {
      final api = ref.read(seerrApiProvider);
      final movieGenresResponse = await api.getMovieGenres();
      final movieWatchProvidersResponse = await api.getMovieWatchProviders(watchRegion: state.filters.watchRegion);
      final movieCertificationsResponse = await api.getMovieCertifications();

      final movieGenres = movieGenresResponse.body ?? [];
      final movieWatchProviders = movieWatchProvidersResponse.body ?? [];
      final movieCertifications = movieCertificationsResponse.body?.certifications?['US'] ?? [];

      final movieGenresMap = <SeerrGenre, bool>{};
      for (var genre in movieGenres) {
        movieGenresMap[genre] = false;
      }

      final movieWatchProvidersMap = <SeerrWatchProvider, bool>{};
      for (var provider in movieWatchProviders) {
        movieWatchProvidersMap[provider] = false;
      }

      final movieCertificationsMap = <SeerrCertification, bool>{};
      for (var cert in movieCertifications) {
        movieCertificationsMap[cert] = false;
      }

      return (movieGenresMap, movieWatchProvidersMap, movieCertificationsMap);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return (const <SeerrGenre, bool>{}, const <SeerrWatchProvider, bool>{}, const <SeerrCertification, bool>{});
    }
  }

  Future<(Map<SeerrGenre, bool>, Map<SeerrWatchProvider, bool>, Map<SeerrCertification, bool>)> _fetchTvData() async {
    try {
      final api = ref.read(seerrApiProvider);
      final tvGenresResponse = await api.getTvGenres();
      final tvWatchProvidersResponse = await api.getTvWatchProviders(watchRegion: state.filters.watchRegion);
      final tvCertificationsResponse = await api.getTvCertifications();

      final tvGenres = tvGenresResponse.body ?? [];
      final tvWatchProviders = tvWatchProvidersResponse.body ?? [];
      final tvCertifications = tvCertificationsResponse.body?.certifications?['US'] ?? [];

      final tvGenresMap = <SeerrGenre, bool>{};
      for (var genre in tvGenres) {
        tvGenresMap[genre] = false;
      }

      final tvWatchProvidersMap = <SeerrWatchProvider, bool>{};
      for (var provider in tvWatchProviders) {
        tvWatchProvidersMap[provider] = false;
      }

      final tvCertificationsMap = <SeerrCertification, bool>{};
      for (var cert in tvCertifications) {
        tvCertificationsMap[cert] = false;
      }

      return (tvGenresMap, tvWatchProvidersMap, tvCertificationsMap);
    } catch (error) {
      state = state.copyWith(isLoading: false);
      return (const <SeerrGenre, bool>{}, const <SeerrWatchProvider, bool>{}, const <SeerrCertification, bool>{});
    }
  }

  Future<void> setYearRange({int? minYear, int? maxYear}) async {
    state = state.copyWith(
      filters: state.filters.copyWith(yearGte: minYear, yearLte: maxYear),
    );

    await submit();
  }

  Future<void> setWatchRegion(String? watchRegion) async {
    final targetRegion = watchRegion ?? 'US';
    if (state.filters.watchRegion == targetRegion) return;

    state = state.copyWith(isLoading: true);

    try {
      final api = ref.read(seerrApiProvider);

      // Only fetch for modes that have already been loaded (non-empty genres)
      if (state.searchMode == SeerrSearchMode.discoverMovies && state.genres.isNotEmpty) {
        final movieWatchProvidersResponse = await api.getMovieWatchProviders(watchRegion: targetRegion);
        final movieWatchProviders = movieWatchProvidersResponse.body ?? [];

        final movieWatchProvidersMap = <SeerrWatchProvider, bool>{};
        for (var provider in movieWatchProviders) {
          movieWatchProvidersMap[provider] = false;
        }

        state = state.copyWith(
          filters: state.filters.copyWith(
            watchRegion: targetRegion,
            watchProviders: movieWatchProvidersMap,
          ),
          watchProviders: movieWatchProvidersMap,
        );
      } else if (state.searchMode == SeerrSearchMode.discoverTv && state.genres.isNotEmpty) {
        final tvWatchProvidersResponse = await api.getTvWatchProviders(watchRegion: targetRegion);
        final tvWatchProviders = tvWatchProvidersResponse.body ?? [];

        final tvWatchProvidersMap = <SeerrWatchProvider, bool>{};
        for (var provider in tvWatchProviders) {
          tvWatchProvidersMap[provider] = false;
        }

        state = state.copyWith(
          filters: state.filters.copyWith(
            watchRegion: targetRegion,
            watchProviders: tvWatchProvidersMap,
          ),
          watchProviders: tvWatchProvidersMap,
        );
      } else {
        // For other modes or if data hasn't been loaded yet, just update the region
        state = state.copyWith(
          filters: state.filters.copyWith(watchRegion: targetRegion),
        );
      }

      await submit();
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setWatchProviders(Map<SeerrWatchProvider, bool> providers) {
    state = state.copyWith(
      filters: state.filters.copyWith(watchProviders: providers),
    );
  }

  void setCertifications(Map<SeerrCertification, bool> certs) {
    state = state.copyWith(
      filters: state.filters.copyWith(
        certifications: certs,
      ),
    );
  }

  void setStudio(SeerrCompany? studio) {
    state = state.copyWith(
      filters: state.filters.copyWith(studio: studio),
    );
  }

  void setVoteAverageRange(double? min, double? max) {
    state = state.copyWith(
      filters: state.filters.copyWith(
        voteAverageGte: min,
        voteAverageLte: max,
      ),
    );
  }

  void setRuntimeRange(int? min, int? max) {
    state = state.copyWith(
      filters: state.filters.copyWith(
        runtimeGte: min,
        runtimeLte: max,
      ),
    );
  }

  void setSortBy(SeerrSortBy sortBy) {
    state = state.copyWith(
      filters: state.filters.copyWith(sortBy: sortBy),
    );
  }

  String? _buildCertificationFilter() {
    final selected = state.filters.certifications.entries.where((e) => e.value).map((e) => e.key).toList()
      ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    final codes = selected.map((c) => c.certification).whereType<String>().toList();
    if (codes.isEmpty) return null;
    return codes.join('|');
  }

  void clearFilters() {
    final clearedGenres = state.genres.setAll(false);
    final clearedWatchProviders = state.watchProviders.setAll(false);
    final clearedCertifications = state.certifications.setAll(false);

    state = state.copyWith(
      genres: clearedGenres,
      watchProviders: clearedWatchProviders,
      certifications: clearedCertifications,
      filters: SeerrFilterModel(
        genres: clearedGenres,
        watchProviders: clearedWatchProviders,
        certifications: clearedCertifications,
        watchRegion: state.filters.watchRegion,
        studio: null,
      ),
    );
  }

  String? _getGenreIds() {
    final selected = state.filters.genres.included.map((g) => g.id).whereType<int>().toList();
    return selected.isEmpty ? null : selected.join(',');
  }

  String? _getWatchProviderIds() {
    final selected = state.filters.watchProviders.included.map((p) => p.providerId).whereType<int>().toList();
    return selected.isEmpty ? null : selected.join('|');
  }

  String? _getYearGte() {
    final minYear = state.filters.yearGte;
    if (minYear == null) return null;
    return '$minYear-01-01';
  }

  String? _getYearLte() {
    final maxYear = state.filters.yearLte;
    if (maxYear == null) return null;
    return '$maxYear-12-31';
  }
}

@Freezed(copyWith: true)
abstract class SeerrSearchModel with _$SeerrSearchModel {
  factory SeerrSearchModel({
    @Default("") String query,
    @Default([]) List<SeerrDashboardPosterModel> results,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool initialized,
    @Default(SeerrSearchMode.search) SeerrSearchMode searchMode,
    @Default(SeerrFilterModel()) SeerrFilterModel filters,
    @Default(1) int currentPage,
    @Default([]) List<SeerrWatchProviderRegion> watchProviderRegions,
    @Default({}) Map<SeerrGenre, bool> genres,
    @Default({}) Map<SeerrWatchProvider, bool> watchProviders,
    @Default({}) Map<SeerrCertification, bool> certifications,
    int? totalPages,
  }) = _SeerrSearchModel;
}
