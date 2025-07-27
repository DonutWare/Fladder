import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/related_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/sync_provider.dart';

final seriesDetailsProvider =
    StateNotifierProvider.autoDispose.family<SeriesDetailViewNotifier, SeriesModel?, String>((ref, id) {
  return SeriesDetailViewNotifier(ref);
});

class SeriesDetailViewNotifier extends StateNotifier<SeriesModel?> {
  SeriesDetailViewNotifier(this.ref) : super(null);

  final Ref ref;

  late final JellyService api = ref.read(jellyApiProvider);

  Future<Response?> fetchDetails(ItemBaseModel seriesModel) async {
    try {
      if (seriesModel is SeriesModel) {
        state = state ?? seriesModel;
      }
      SeriesModel? newState;
      final response = await api.usersUserIdItemsItemIdGet(itemId: seriesModel.id);
      if (response.body == null) return null;
      newState = response.bodyOrThrow as SeriesModel;

      final episodes = await api.showsSeriesIdEpisodesGet(seriesId: seriesModel.id, fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.candownload,
        ItemFields.childcount,
      ]);

      final newEpisodes = EpisodeModel.episodesFromDto(
        episodes.body?.items,
        ref,
      );
      final episodesCanDownload = newEpisodes.any((episode) => episode.canDownload == true);
      final seasons = await api.showsSeriesIdSeasonsGet(seriesId: seriesModel.id, fields: [
        ItemFields.mediastreams,
        ItemFields.mediasources,
        ItemFields.overview,
        ItemFields.candownload,
        ItemFields.childcount,
      ]);
      newState = newState.copyWith(
        seasons: SeasonModel.seasonsFromDto(seasons.body?.items, ref)
            .map((element) => element.copyWith(
                  canDownload: true,
                  episodes: newEpisodes.where((episode) => episode.season == element.season).toList(),
                ))
            .toList(),
      );

      newState = newState.copyWith(
        canDownload: episodesCanDownload,
        availableEpisodes: newEpisodes,
      );

      final related = await ref.read(relatedUtilityProvider).relatedContent(seriesModel.id);
      state = newState.copyWith(related: related.body);
      return response;
    } catch (e) {
      _tryToCreateOfflineState(seriesModel);
      return null;
    }
  }

  Future<void> _tryToCreateOfflineState(ItemBaseModel series) async {
    final syncNotifier = ref.read(syncProvider.notifier);
    final syncedItem = await syncNotifier.getSyncedItem(series);
    if (syncedItem == null) return;
    final seriesModel = syncedItem.itemModel as SeriesModel;
    final allChildren = (await syncedItem.getNestedChildren(ref)).map((e) => e.itemModel).toList();
    if (mounted) {
      state = seriesModel.copyWith(
        availableEpisodes: allChildren.whereType<EpisodeModel>().toList(),
        seasons: allChildren.whereType<SeasonModel>().toList(),
      );
    }
    return;
  }

  void updateEpisodeInfo(EpisodeModel episode) {
    final index = state?.availableEpisodes?.indexOf(episode);

    if (index != null) {
      state = state?.copyWith(
        availableEpisodes: state?.availableEpisodes
          ?..remove(episode)
          ..insert(index, episode),
      );
    }
  }
}
