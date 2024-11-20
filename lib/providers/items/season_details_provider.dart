import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

final seasonDetailsProvider =
    StateNotifierProvider.autoDispose.family<SeasonDetailsNotifier, SeasonModel?, String>((ref, id) {
  return SeasonDetailsNotifier(ref);
});

class SeasonDetailsNotifier extends StateNotifier<SeasonModel?> {
  SeasonDetailsNotifier(this.ref) : super(null);

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(String seasonId) async {
    SeasonModel? newState;

    final season = await api.usersUserIdItemsItemIdGet(itemId: seasonId);
    if (season.body != null) newState = season.bodyOrThrow as SeasonModel;

    final episodes = await api.showsSeriesIdEpisodesGet(
      seriesId: newState?.seriesId ?? "",
      seasonId: newState?.id,
      season: newState?.season,
      fields: [ItemFields.overview],
    );
    newState = newState?.copyWith(episodes: EpisodeModel.episodesFromDto(episodes.body?.items, ref).toList());
    state = newState;
    return season;
  }
}
