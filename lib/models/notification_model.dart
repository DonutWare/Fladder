import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/episode_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/notification_helpers.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String key,
    required String id,
    int? childCount,
    String? image,
    required String title,
    String? subtitle,
    required String payLoad,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  static List<NotificationModel> createList(List<ItemBaseModel> items, AppLocalizations l10n) =>
      items.map((e) => _fromItem(e, l10n)).nonNulls.toList();

  static NotificationModel? fromSeerrRequest(
    SeerrMediaRequest req,
    AppLocalizations l10n, {
    String? title,
    String? image,
    String? detailedPayload,
  }) {
    final media = req.media;
    final tmdbId = media?.tmdbId;
    final mediaTypeRaw = (media?.mediaType ?? '').toLowerCase();
    final mediaType = mediaTypeRaw.contains('tv') ? 'tvshow' : 'movie';
    final payload = detailedPayload ??
        (tmdbId != null ? NotificationHelpers.buildSeerrDeepLink(mediaType, tmdbId) : 'fladder:///seerr');

    String defaultTitle() {
      if (media?.tmdbId != null) {
        final typeLabel = (media?.mediaType?.toLowerCase().contains('tv') ?? false) ? 'TV' : 'Movie';
        return '$typeLabel ${media!.tmdbId}';
      }
      return 'Seerr request ${req.id}';
    }

    final statusLabel = switch (req.requestStatus) {
      SeerrRequestStatus.pending => l10n.seerrRequestStatusPending,
      SeerrRequestStatus.approved => l10n.seerrRequestStatusApproved,
      SeerrRequestStatus.declined => l10n.seerrRequestStatusDeclined,
      SeerrRequestStatus.unknown => l10n.unknown,
      SeerrRequestStatus.failed => l10n.seerrRequestStatusFailed,
      SeerrRequestStatus.completed => l10n.seerrRequestStatusCompleted,
    };

    final subtitle = req.requestedBy?.displayName ?? (statusLabel.isNotEmpty ? statusLabel : null);

    return NotificationModel(
      key: 'seerr-${req.id}',
      id: '${req.id}',
      image: image,
      title: title ?? defaultTitle(),
      subtitle: subtitle,
      payLoad: payload,
    );
  }

  static NotificationModel? _fromItem(dynamic item, AppLocalizations l10n) {
    switch (item) {
      case ItemBaseModel it:
        return switch (it) {
          EpisodeModel episode => NotificationModel(
              key: episode.childCount != null ? '${episode.id}#c=${episode.childCount}' : episode.id,
              id: episode.id,
              childCount: episode.childCount,
              image: episode.images?.primary?.path ?? episode.getPosters?.primary?.path,
              title: episode.title,
              subtitle: episode.episodeLabel(l10n),
              payLoad: NotificationHelpers.buildDetailsDeepLink(episode.id),
            ),
          SeriesModel series => NotificationModel(
              key: series.childCount != null ? '${series.id}#c=${series.childCount}' : series.id,
              id: series.id,
              childCount: series.childCount,
              image: series.images?.primary?.path ?? series.getPosters?.primary?.path,
              title: series.detailedName(l10n),
              subtitle: l10n.notificationNewEpisodes,
              payLoad: NotificationHelpers.buildDetailsDeepLink(series.id),
            ),
          _ => NotificationModel(
              key: it.id,
              id: it.id,
              childCount: it.childCount,
              image: it.images?.primary?.path ?? it.getPosters?.primary?.path,
              title: it.title,
              subtitle: it.subText,
              payLoad: NotificationHelpers.buildDetailsDeepLink(it.id),
            )
        };
    }
    return null;
  }
}
