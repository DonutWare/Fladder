import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:fladder/models/items/special_feature_model.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/related_provider.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/service_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:logging/logging.dart' as logging;

part 'movies_details_provider.g.dart';

@riverpod
class MovieDetails extends _$MovieDetails {
  late final JellyService api = ref.read(jellyApiProvider);

  @override
  MovieModel? build(String arg) => null;

  Future<Response?> fetchDetails(ItemBaseModel item) async {
    try {
      if (item is MovieModel) {
        state = state ?? item;
      }
      MovieModel? newState;
      final response = await api.usersUserIdItemsItemIdGet(itemId: item.id);
      if (response.body == null) return null;
      newState = (response.bodyOrThrow as MovieModel).copyWith(
        related: state?.related ?? const [],
        seerrRelated: state?.seerrRelated ?? const [],
        seerrRecommended: state?.seerrRecommended ?? const [],
      );

      state = newState;

      List<BaseItemDto> specialFeatures;
      try {
        specialFeatures = (await api.itemsItemIdSpecialFeaturesGet(itemId: item.id)).body ?? [];
      } on Exception catch (e, s) {
        specialFeatures = [];
        log("Failed to get special features for movie id ${item.id} due to $e",
            level: logging.Level.WARNING.value, error: e, stackTrace: s);
      }

      final related = await ref.read(relatedUtilityProvider).relatedContent(item.id);
      final List<SpecialFeatureModel> specialFeatureModel =
          SpecialFeatureModel.specialFeaturesFromDto(specialFeatures, ref).toList();

      List<SeerrDashboardPosterModel> seerrRelated = const [];
      List<SeerrDashboardPosterModel> seerrRecommended = const [];

      String? seerrUrl;

      final seerrCreds = ref.read(userProvider)?.seerrCredentials;
      if (seerrCreds?.isConfigured == true) {
        final tmdbId = newState.tmdbId;
        if (tmdbId != null) {
          final seerr = ref.read(seerrApiProvider);
          seerrRelated = await seerr.discoverRelatedMovies(tmdbId: tmdbId);
          seerrRecommended = await seerr.discoverRecommendedMovies(tmdbId: tmdbId);
          final seerrPoster = await seerr.fetchDashboardPosterFromIds(
            tmdbId: tmdbId,
            mediaType: SeerrMediaType.movie,
          );
          final status = seerrPoster?.mediaInfo?.mediaStatus;
          if (status != SeerrMediaStatus.unknown) {
            final seerrServerUrl = ref.read(userProvider.select((value) => value?.seerrCredentials?.serverUrl));
            seerrUrl = '${seerrServerUrl}movie/$tmdbId';
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
        specialFeatures: specialFeatureModel
      );
      return null;
    } catch (e) {
      return null;
    }
  }

  void setSubIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(defaultSubStreamIndex: index));
  }

  void setAudioIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(defaultAudioStreamIndex: index));
  }

  void setVersionIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(versionStreamIndex: index));
  }
}
