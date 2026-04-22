import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/items/person_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_service_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';

final personDetailsProvider =
    StateNotifierProvider.autoDispose.family<PersonDetailsNotifier, PersonModel?, String>((ref, id) {
  return PersonDetailsNotifier(ref);
});

class PersonDetailsNotifier extends StateNotifier<PersonModel?> {
  PersonDetailsNotifier(this.ref) : super(null);

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);
  late final SeerrService seerrApi = ref.read(seerrApiProvider);

  Future<Response?> fetchPerson(Person person) async {
    final response = await api.usersUserIdItemsItemIdGet(itemId: person.id);

    if (response.isSuccessful && response.body != null) {
      state = response.bodyOrThrow as PersonModel;
      await fetchMovies();
    }

    return response;
  }

  Future<Response?> fetchMovies() async {
    final movies = await api.itemsGet(
      personIds: [state?.id ?? ""],
      limit: 25,
      sortBy: [ItemSortBy.premieredate, ItemSortBy.communityrating, ItemSortBy.sortname, ItemSortBy.productionyear],
      sortOrder: [SortOrder.descending],
      recursive: true,
      fields: [
        ItemFields.primaryimageaspectratio,
      ],
      includeItemTypes: [
        BaseItemKind.movie,
      ],
    );

    final series = await api.itemsGet(
      personIds: [state?.id ?? ""],
      limit: 25,
      sortBy: [ItemSortBy.premieredate, ItemSortBy.communityrating, ItemSortBy.sortname, ItemSortBy.productionyear],
      sortOrder: [SortOrder.descending],
      recursive: true,
      fields: [
        ItemFields.primaryimageaspectratio,
      ],
      includeItemTypes: [
        BaseItemKind.series,
      ],
    );

    state = state?.copyWith(
      movies: movies.body?.items.whereType<MovieModel>().toList(),
      series: series.body?.items.whereType<SeriesModel>().toList(),
    );

    await fetchSeerrCredits();
    return movies;
  }

  int? _tmdbPersonId() {
    final ids = state?.providerIds;
    if (ids == null) return null;

    final dynamic rawId = ids['Tmdb'] ?? ids['tmdb'] ?? ids['TMDB'] ?? ids['tmdbId'];
    if (rawId == null) return null;
    if (rawId is int) return rawId;
    if (rawId is num) return rawId.toInt();
    if (rawId is String) return int.tryParse(rawId);
    return null;
  }

  Future<void> fetchSeerrCredits() async {
    if (state == null) return;

    final seerrCredentials = ref.read(userProvider)?.seerrCredentials;
    if (seerrCredentials?.isConfigured != true) {
      state = state?.copyWith(seerrMovies: const [], seerrSeries: const []);
      return;
    }

    final tmdbPersonId = _tmdbPersonId();
    if (tmdbPersonId == null) {
      state = state?.copyWith(seerrMovies: const [], seerrSeries: const []);
      return;
    }

    final response = await seerrApi.personCombinedCredits(personId: tmdbPersonId);
    if (!response.isSuccessful || response.body == null) {
      state = state?.copyWith(seerrMovies: const [], seerrSeries: const []);
      return;
    }

    final credits = response.body!;
    final creditItems = <SeerrPersonCredit>[
      ...credits.cast ?? <SeerrPersonCredit>[],
      ...credits.crew ?? <SeerrPersonCredit>[],
    ];

    final posters = creditItems
        .where((credit) => credit.mediaInfo?.primaryJellyfinMediaId == null)
        .map((credit) => seerrApi.posterFromPersonCredit(credit))
        .whereType<SeerrDashboardPosterModel>()
        .toList();

    posters.sort(_sortPostersByNewestFirst);

    final seenIds = <String>{};
    final uniquePosters = posters.where((poster) => seenIds.add(poster.id)).toList();

    state = state?.copyWith(
      seerrMovies: uniquePosters.where((poster) => poster.type == SeerrMediaType.movie).toList(),
      seerrSeries: uniquePosters.where((poster) => poster.type == SeerrMediaType.tvshow).toList(),
    );
  }

  int _posterReleaseYear(SeerrDashboardPosterModel poster) {
    final year = poster.releaseYear;
    if (year == null) return 0;
    return int.tryParse(year) ?? 0;
  }

  int _sortPostersByNewestFirst(SeerrDashboardPosterModel a, SeerrDashboardPosterModel b) {
    final yearA = _posterReleaseYear(a);
    final yearB = _posterReleaseYear(b);
    final yearComparison = yearB.compareTo(yearA);
    if (yearComparison != 0) return yearComparison;
    return b.title.compareTo(a.title);
  }
}
