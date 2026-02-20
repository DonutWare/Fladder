import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart' as logging;

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/season_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/items/special_feature_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/related_provider.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';

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
      newState = (response.bodyOrThrow as SeriesModel).copyWith(
        related: state?.related ?? const [],
        seerrRelated: state?.seerrRelated ?? const [],
        seerrRecommended: state?.seerrRecommended ?? const [],
        availableEpisodes: state?.availableEpisodes ?? const [],
        seasons: state?.seasons ?? const [],
        canDownload: state?.canDownload ?? false,
      );

      state = newState;

      final seasons = await api.showsSeriesIdSeasonsGet(
        seriesId: seriesModel.id,
        enableUserData: false,
      );

      final episodes = await api.showsSeriesIdEpisodesGet(
        seriesId: seriesModel.id,
        enableUserData: true,
        fields: [
          ItemFields.mediastreams,
          ItemFields.mediasources,
          ItemFields.overview,
          ItemFields.candownload,
        ],
      );

      final newEpisodes = EpisodeModel.episodesFromDto(
        episodes.body?.items,
        ref,
      );

      List<BaseItemDto> specialFeatures;
      try {
        specialFeatures = (await api.itemsItemIdSpecialFeaturesGet(itemId: seriesModel.id)).body ?? [];
      } on Exception catch (e, s) {
        specialFeatures = [];
        log("Failed to get special features for series id ${seriesModel.id} due to $e",
            level: logging.Level.WARNING.value, error: e, stackTrace: s);
      }

      final episodesCanDownload = newEpisodes.any((episode) => episode.canDownload == true);

      newState = newState.copyWith(
          seasons: SeasonModel.seasonsFromDto(seasons.body?.items, ref).map(
            (element) {
              final unPlayedCount = newEpisodes
                  .where((episode) =>
                      episode.season == element.season &&
                      episode.status == EpisodeStatus.available &&
                      episode.userData.played == false)
                  .length;
              return element.copyWith(
                canDownload: true,
                episodes: newEpisodes.where((episode) => episode.season == element.season).toList(),
                userData: UserData(
                  unPlayedItemCount: unPlayedCount,
                  played: unPlayedCount == 0,
                ),
              );
            },
          ).toList(),
          specialFeatures: SpecialFeatureModel.specialFeaturesFromDto(specialFeatures, ref));

      newState = newState.copyWith(
        canDownload: episodesCanDownload,
        availableEpisodes: newEpisodes,
      );

      final related = await ref.read(relatedUtilityProvider).relatedContent(seriesModel.id);
      List<SeerrDashboardPosterModel> seerrRelated = const [];
      List<SeerrDashboardPosterModel> seerrRecommended = const [];

      String? seerrUrl;

      final seerrCreds = ref.read(userProvider)?.seerrCredentials;
      if (seerrCreds?.isConfigured == true) {
        final tmdbId = newState.tmdbId;
        if (tmdbId != null) {
          final seerr = ref.read(seerrApiProvider);
          seerrRelated = await seerr.discoverRelatedSeries(tmdbId: tmdbId);
          seerrRecommended = await seerr.discoverRecommendedSeries(tmdbId: tmdbId);
          final seerrPoster = await seerr.fetchDashboardPosterFromIds(
            tmdbId: tmdbId,
            mediaType: SeerrMediaType.tvshow,
          );
          final status = seerrPoster?.mediaInfo?.mediaStatus;
          if (status != SeerrMediaStatus.unknown) {
            final seerrServerUrl = ref.read(userProvider.select((value) => value?.seerrCredentials?.serverUrl));
            seerrUrl = '${seerrServerUrl}tv/$tmdbId';
          }
        }
      }

      state = newState.copyWith(
        related: related.body,
        seerrRelated: seerrRelated,
        seerrRecommended: seerrRecommended,
        overview: state?.overview.copyWith(
          seerrUrl: seerrUrl,
        ),
      );
      return response;
    } catch (e) {
      log("Error fetching series details: $e");
      return null;
    }
  }

  void updateEpisodeInfo(EpisodeModel episode) {
    final index = state?.availableEpisodes?.indexWhere((e) => e.id == episode.id);

    final newList = state?.availableEpisodes?.toList() ?? [];
    newList[index ?? 0] = episode;

    if (index != null) {
      state = state?.copyWith(
        availableEpisodes: newList,
      );
    }
  }

  void setCurrentEpisode(EpisodeModel? episodeModel) {
    state = state?.copyWith(selectedEpisode: episodeModel);
  }
}
