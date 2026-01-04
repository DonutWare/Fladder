import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/seerr_helpers.dart';

part 'seerr_details_provider.freezed.dart';
part 'seerr_details_provider.g.dart';

@riverpod
class SeerrDetails extends _$SeerrDetails {
  late final api = ref.read(seerrApiProvider);

  @override
  SeerrDetailsModel build({
    required int tmdbId,
    required SeerrDashboardMediaType mediaType,
    SeerrDashboardPosterModel? poster,
  }) {
    state = SeerrDetailsModel(
      tmdbId: tmdbId,
      mediaType: mediaType,
      poster: poster,
      recommended: const [],
      similar: const [],
    );

    fetch();

    return state;
  }

  Future<void> fetch() async {
    final currentTmdbId = state.tmdbId;
    final currentMediaType = state.mediaType;
    if (currentTmdbId == null || currentMediaType == null) return;

    SeerrDashboardPosterModel? poster = state.poster;

    final refreshedPoster = await api.fetchDashboardPosterFromIds(
      tmdbId: currentTmdbId,
      mediaType: currentMediaType,
    );

    poster = refreshedPoster ?? poster;
    if (poster == null) return;

    state = state.copyWith(poster: poster);

    final currentUserBody = await ref.read(seerrUserProvider.notifier).refreshUser();
    final isTv = currentMediaType == SeerrDashboardMediaType.tv;

    if (isTv) {
      final tvDetailsResponse = await api.tvDetails(tvId: poster.tmdbId);
      if (tvDetailsResponse.isSuccessful && tvDetailsResponse.body != null) {
        final details = tvDetailsResponse.body!;

        final seasonStatusMap = SeerrHelpers.buildSeasonStatusMap(details);

        final userRegion = currentUserBody?.settings?.discoverRegion ?? 'US';
        final contentRating = SeerrHelpers.extractContentRating(details.contentRatings, userRegion);

        final updatedPoster = poster.copyWith(
          seasons: details.seasons,
          seasonStatuses: seasonStatusMap.isEmpty ? poster.seasonStatuses : seasonStatusMap,
          mediaInfo: details.mediaInfo,
        );

        state = state.copyWith(
          poster: updatedPoster,
          genres: details.genres ?? [],
          voteAverage: details.voteAverage,
          contentRating: contentRating,
          releaseDate: details.firstAirDate,
          people: _mapCredits(details.credits),
          seasonStatuses: updatedPoster.seasonStatuses ?? const {},
        );
      }
    } else {
      final movieDetailsResponse = await api.movieDetails(tmdbId: poster.tmdbId);
      if (movieDetailsResponse.isSuccessful && movieDetailsResponse.body != null) {
        final details = movieDetailsResponse.body!;
        final userRegion = currentUserBody?.settings?.discoverRegion ?? 'US';
        final contentRating = SeerrHelpers.extractContentRating(details.contentRatings, userRegion);

        final updatedPoster = poster.copyWith(
          mediaInfo: details.mediaInfo,
        );

        state = state.copyWith(
          poster: updatedPoster,
          genres: details.genres ?? [],
          voteAverage: details.voteAverage,
          contentRating: contentRating,
          releaseDate: details.releaseDate,
          people: _mapCredits(details.credits),
        );
      }
    }

    if (currentMediaType == SeerrDashboardMediaType.movie) {
      final recommended = await api.discoverRecommendedMovies(tmdbId: poster.tmdbId);
      final related = await api.discoverRelatedMovies(tmdbId: poster.tmdbId);
      state = state.copyWith(recommended: recommended, similar: related);
    } else {
      final recommended = await api.discoverRecommendedSeries(tmdbId: poster.tmdbId);
      final related = await api.discoverRelatedSeries(tmdbId: poster.tmdbId);
      state = state.copyWith(recommended: recommended, similar: related);
    }

    state = state.copyWith(
      currentUser: currentUserBody,
      poster: poster.copyWith(
        mediaInfo: refreshedPoster?.mediaInfo == null ? null : poster.mediaInfo,
      ),
    );
  }

  List<Person> _mapCredits(SeerrCredits? credits) {
    if (credits == null) return const [];

    final people = <Person>[];
    final seen = <String>{};

    void addPerson({
      int? id,
      required String name,
      String? role,
      String? profileUrl,
      PersonKind? type,
    }) {
      final safeName = name.trim();
      if (safeName.isEmpty) return;

      final dedupeKey = '${id ?? safeName}::${role ?? ''}';
      if (!seen.add(dedupeKey)) return;

      ImageData? image;
      if (profileUrl != null && profileUrl.isNotEmpty) {
        image = ImageData(path: profileUrl, key: 'seerr_person_${id ?? safeName.hashCode}');
      }

      people.add(
        Person(
          id: (id ?? safeName.hashCode).toString(),
          name: safeName,
          role: role ?? '',
          image: image,
          type: type,
        ),
      );
    }

    for (final cast in credits.cast ?? const <SeerrCast>[]) {
      addPerson(
        id: cast.id,
        name: cast.name ?? '',
        role: (cast.character?.trim().isEmpty ?? true) ? null : cast.character,
        profileUrl: cast.profileUrl,
        type: PersonKind.actor,
      );
    }

    for (final crew in credits.crew ?? const <SeerrCrew>[]) {
      addPerson(
        id: crew.id,
        name: crew.name ?? '',
        role: (crew.job?.trim().isEmpty ?? true) ? crew.department : crew.job,
        profileUrl: crew.profileUrl,
        type: _mapCrewKind(crew.job),
      );
    }

    return people;
  }

  PersonKind _mapCrewKind(String? job) {
    final normalized = job?.toLowerCase().trim();
    if (normalized == null || normalized.isEmpty) return PersonKind.unknown;
    if (normalized.contains('director')) return PersonKind.director;
    if (normalized.contains('producer')) return PersonKind.producer;
    if (normalized.contains('writer') || normalized.contains('screenplay') || normalized.contains('story')) {
      return PersonKind.writer;
    }
    if (normalized.contains('composer') || normalized.contains('music')) return PersonKind.composer;
    return PersonKind.unknown;
  }

  Future<void> toggleSeasonExpanded(int seasonNumber) async {
    final currentExpanded = state.expandedSeasons[seasonNumber] ?? false;
    final newExpanded = !currentExpanded;

    final updatedExpanded = Map<int, bool>.from(state.expandedSeasons);
    updatedExpanded[seasonNumber] = newExpanded;
    state = state.copyWith(expandedSeasons: updatedExpanded);

    if (newExpanded && !state.episodesCache.containsKey(seasonNumber)) {
      await _fetchSeasonEpisodes(seasonNumber);
    }
  }

  Future<void> _fetchSeasonEpisodes(int seasonNumber) async {
    final poster = state.poster;
    if (poster == null) return;

    final response = await api.seasonDetails(
      tvId: poster.tmdbId,
      seasonNumber: seasonNumber,
    );

    if (response.isSuccessful && response.body != null) {
      final episodes = response.body!.episodes ?? [];
      final updatedCache = Map<int, List<SeerrEpisode>>.from(state.episodesCache);
      updatedCache[seasonNumber] = episodes;
      state = state.copyWith(episodesCache: updatedCache);
    }
  }
}

@Freezed(copyWith: true)
abstract class SeerrDetailsModel with _$SeerrDetailsModel {
  const SeerrDetailsModel._();

  const factory SeerrDetailsModel({
    int? tmdbId,
    SeerrDashboardMediaType? mediaType,
    SeerrDashboardPosterModel? poster,
    @Default([]) List<SeerrGenre> genres,
    double? voteAverage,
    String? contentRating,
    String? releaseDate,
    @Default([]) List<SeerrDashboardPosterModel> recommended,
    @Default([]) List<SeerrDashboardPosterModel> similar,
    @Default([]) List<Person> people,
    @Default({}) Map<int, SeerrRequestStatus> seasonStatuses,
    SeerrUserModel? currentUser,
    @Default({}) Map<int, bool> expandedSeasons,
    @Default({}) Map<int, List<SeerrEpisode>> episodesCache,
  }) = _SeerrDetailsModel;

  bool get isTv => mediaType == SeerrDashboardMediaType.tv;

  bool? get hasRequestPermission {
    final user = currentUser;
    if (user == null) return null;

    final baseRequest = user.hasPermission(SeerrPermission.request);
    if (isTv) {
      return baseRequest || user.hasPermission(SeerrPermission.requestTv);
    }
    return baseRequest || user.hasPermission(SeerrPermission.requestMovie);
  }

  bool isRequestedAlready(int seasonNumber) {
    final status = seasonStatuses[seasonNumber];
    return status != null && status != SeerrRequestStatus.unknown && status != SeerrRequestStatus.deleted;
  }
}
