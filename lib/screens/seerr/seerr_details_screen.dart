import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr/seerr_details_provider.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/screens/seerr/seerr_media_management.dart';
import 'package:fladder/screens/seerr/widgets/seerr_poster_row.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/seerr/widgets/seerr_requests_sheet.dart';
import 'package:fladder/screens/shared/detail_scaffold.dart';
import 'package:fladder/screens/shared/media/expanding_overview.dart';
import 'package:fladder/screens/shared/media/people_row.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

@RoutePage()
class SeerrDetailsScreen extends ConsumerWidget {
  final String mediaType;
  final int tmdbId;
  final SeerrDashboardPosterModel? poster;

  const SeerrDetailsScreen({
    @PathParam('mediaType') required this.mediaType,
    @PathParam('tmdbId') required this.tmdbId,
    this.poster,
    super.key,
  });

  SeerrDashboardMediaType get _resolvedType =>
      mediaType.toLowerCase() == 'tvshow' ? SeerrDashboardMediaType.tv : SeerrDashboardMediaType.movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = seerrDetailsProvider(
      tmdbId: tmdbId,
      mediaType: _resolvedType,
      poster: poster,
    );
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    final currentPoster = state.poster;
    final wrapAlignment =
        AdaptiveLayout.viewSizeOf(context) != ViewSize.phone ? WrapAlignment.start : WrapAlignment.center;

    final radius = BorderRadius.circular(16);
    final theme = Theme.of(context);

    final itemBaseModel = currentPoster?.itemBaseModel;

    final hasKnownStatus = currentPoster?.hasDisplayStatus ?? false;
    final requests = state.poster?.mediaInfo?.requests ?? [];
    final pendingRequests = requests.where((request) => request.requestStatus == SeerrRequestStatus.pending).toList();

    return DetailScaffold(
      label: currentPoster?.title ?? context.localized.request,
      backDrops: currentPoster?.images,
      onRefresh: notifier.fetch,
      posterFillsContent: true,
      content: (context, padding) => currentPoster == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top + 16,
                  ),
                  OverviewHeader(
                    minHeight: 50,
                    name: currentPoster.title,
                    logoAlignment: Alignment.center,
                    poster: currentPoster.images.primary != null
                        ? SizedBox(
                            width: 175,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 8,
                              children: [
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: 175,
                                  child: AspectRatio(
                                    aspectRatio: 2 / 3,
                                    child: FocusButton(
                                      onTap: itemBaseModel != null ? () => itemBaseModel.navigateTo(context) : null,
                                      onFocusChanged: (focus) {
                                        if (focus) {
                                          context.ensureVisible();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: FladderTheme.defaultPosterDecoration.borderRadius,
                                        ),
                                        foregroundDecoration: FladderTheme.defaultPosterDecoration,
                                        clipBehavior: Clip.hardEdge,
                                        child: FladderImage(
                                          image: currentPoster.images.primary,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (hasKnownStatus)
                                  Container(
                                    decoration: BoxDecoration(
                                      color: currentPoster.displayStatusColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(
                                      currentPoster.displayStatusLabel(context),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                              ],
                            ),
                          )
                        : null,
                    image: currentPoster.images,
                    padding: padding,
                    productionYear: int.tryParse(currentPoster.releaseYear ?? ''),
                    officialRating: state.contentRating,
                    communityRating: state.voteAverage,
                    genres:
                        state.genres.map((e) => GenreItems(id: e.id?.toString() ?? "", name: e.name ?? "")).toList(),
                    mainButton: Builder(builder: (context) {
                      return FocusButton(
                        autoFocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                        onTap: () => openSeerrRequestPopup(context, currentPoster),
                        borderRadius: radius,
                        onFocusChanged: (value) {
                          if (value) {
                            context.ensureVisible(
                              alignment: 1.0,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: radius,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Flexible(
                                  child: Text(
                                    context.localized.request,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                                Icon(
                                  IconsaxPlusLinear.add,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    centerButtons: Builder(
                      builder: (context) {
                        final canManageRequests = state.currentUser?.canManageRequests ?? false;
                        final canApproveOtherRequests = canManageRequests && requests.isNotEmpty;
                        return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: wrapAlignment,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (canApproveOtherRequests)
                              FocusButton(
                                autoFocus: false,
                                onTap: () async {
                                  await showSeerrRequestsSheet(
                                    context: context,
                                    poster: currentPoster,
                                    requests: requests,
                                    onApprove: notifier.approveRequest,
                                    onDecline: notifier.declineRequest,
                                  );
                                },
                                borderRadius: radius,
                                onFocusChanged: (value) {
                                  if (value) {
                                    context.ensureVisible(
                                      alignment: 1.0,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: SeerrRequestStatus.pending.color,
                                    borderRadius: radius,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 8,
                                      children: [
                                        Text(
                                          context.localized.pendingRequests(pendingRequests.length),
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (canManageRequests && currentPoster.mediaInfo != null)
                              FocusButton(
                                autoFocus: false,
                                onTap: () async {
                                  await showMediaManagementSheet(
                                    context: context,
                                    mediaInfo: currentPoster,
                                    onActionComplete: () => context.refreshData(),
                                  );
                                },
                                borderRadius: radius,
                                onFocusChanged: (value) {
                                  if (value) {
                                    context.ensureVisible(
                                      alignment: 1.0,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.tertiaryContainer,
                                    borderRadius: radius,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      IconsaxPlusLinear.setting_4,
                                      color: theme.colorScheme.onTertiaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  ExpandingOverview(
                    text: currentPoster.overview.trim().isEmpty
                        ? context.localized.noOverviewAvailable
                        : currentPoster.overview,
                  ).padding(padding),
                  if (currentPoster.type == SeerrDashboardMediaType.tv && (currentPoster.seasons?.isNotEmpty ?? false))
                    _SeerrSeasonsSection(
                      state: state,
                      notifier: notifier,
                      onToggle: (seasonNumber, enabled) {},
                      seasons: currentPoster.seasons ?? const [],
                      seasonStatuses: state.seasonStatuses,
                    ).padding(padding),
                  if (state.people.isNotEmpty)
                    PeopleRow(
                      people: state.people,
                      contentPadding: padding,
                    ),
                  if (state.recommended.isNotEmpty)
                    SeerrPosterRow(
                      posters: state.recommended,
                      label: "${context.localized.discover} ${context.localized.recommended.toLowerCase()}",
                      contentPadding: padding,
                    ),
                  if (state.similar.isNotEmpty)
                    SeerrPosterRow(
                      posters: state.similar,
                      label: "${context.localized.discover} ${context.localized.related.toLowerCase()}",
                      contentPadding: padding,
                    ),
                ].addPadding(const EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
    );
  }
}

class _SeerrSeasonsSection extends StatelessWidget {
  final SeerrDetailsModel state;
  final SeerrDetails notifier;
  final List<SeerrSeason> seasons;
  final Map<int, SeerrMediaStatus> seasonStatuses;
  final void Function(int seasonNumber, bool enabled) onToggle;

  const _SeerrSeasonsSection({
    required this.state,
    required this.notifier,
    required this.seasons,
    required this.seasonStatuses,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          context.localized.season(seasons.length),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        ...seasons.map((season) {
          final seasonNumber = season.seasonNumber;
          if (seasonNumber == null) return const SizedBox.shrink();
          final status = seasonStatuses[seasonNumber];
          final isExpanded = state.expandedSeasons[seasonNumber] ?? false;
          final episodes = state.episodesCache[seasonNumber] ?? [];

          return _SeasonCard(
            season: season,
            seasonNumber: seasonNumber,
            status: status,
            isExpanded: isExpanded,
            episodes: episodes,
            onToggle: () => notifier.toggleSeasonExpanded(seasonNumber),
          );
        }),
      ],
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final SeerrSeason season;
  final int seasonNumber;
  final SeerrMediaStatus? status;
  final bool isExpanded;
  final List<SeerrEpisode> episodes;
  final VoidCallback onToggle;

  const _SeasonCard({
    required this.season,
    required this.seasonNumber,
    required this.status,
    required this.isExpanded,
    required this.episodes,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: FladderTheme.smallShape.borderRadius,
      ),
      child: Column(
        children: [
          FocusButton(
            onTap: onToggle,
            onFocusChanged: (focus) {
              if (focus) {
                context.ensureVisible();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (status != null && status != SeerrMediaStatus.unknown)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: status!.color.withAlpha(200),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                status!.label(context),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                        Text(
                          "${context.localized.season(1)} $seasonNumber",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (season.episodeCount != null)
                          Text(
                            '${season.episodeCount} ${context.localized.episode(season.episodeCount ?? 0)}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                                ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      IconsaxPlusLinear.arrow_down,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    children: episodes.map((episode) {
                      return _EpisodeCard(episode: episode);
                    }).toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final SeerrEpisode episode;

  const _EpisodeCard({required this.episode});

  @override
  Widget build(BuildContext context) {
    final posterUrl = episode.stillUrl;
    final posterImage = posterUrl == null
        ? null
        : ImageData(path: posterUrl, key: 'seerr_episode_${episode.id ?? episode.episodeNumber}');

    return FocusButton(
      onTap: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? () {} : null,
      onFocusChanged: (focus) {
        if (focus) {
          context.ensureVisible();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.surfaceContainer,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'E${episode.episodeNumber}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          episode.name ?? 'Episode ${episode.episodeNumber}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (episode.overview != null && episode.overview!.isNotEmpty)
                    Text(
                      episode.overview!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                          ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (episode.airDate != null && episode.airDate!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        episode.airDate!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                ],
              ),
            ),
            if (posterImage != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: FladderTheme.defaultPosterDecoration.borderRadius,
                ),
                foregroundDecoration: FladderTheme.defaultPosterDecoration,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: 175,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FladderImage(
                      image: posterImage,
                      fit: BoxFit.cover,
                      placeHolder: Container(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Center(
                          child: Icon(
                            IconsaxPlusLinear.video,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
