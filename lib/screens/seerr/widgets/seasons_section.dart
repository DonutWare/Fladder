import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr/seerr_request_provider.dart';
import 'package:fladder/screens/seerr/widgets/season_download_progress_widget.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';

class SeerrSeasonsSection extends ConsumerWidget {
  final SeerrDashboardPosterModel model;
  final SeerrRequestModel requestState;
  final List<SeerrSeason> seasons;
  final Map<int, SeerrRequestStatus> seasonStatuses;

  const SeerrSeasonsSection({
    required this.model,
    required this.requestState,
    required this.seasons,
    required this.seasonStatuses,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(seerrRequestProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localized.season(seasons.length),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...seasons.map((season) {
          final seasonNumber = season.seasonNumber;
          if (seasonNumber == null) return const SizedBox.shrink();
          final locked = requestState.isRequestedAlready(seasonNumber);
          final selected = requestState.selectedSeasons[seasonNumber] ?? false;
          final status = seasonStatuses[seasonNumber];
          final seasonDownloads =
              model.mediaInfo?.downloadStatus?.where((d) => d.episode?.seasonNumber == seasonNumber).toList() ?? [];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CheckboxListTile(
              value: selected,
              onChanged: locked
                  ? null
                  : (value) {
                      if (value == null) return;
                      notifier.toggleSeason(seasonNumber, value);
                    },
              title: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (status != null && status != SeerrRequestStatus.unknown)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: status.color.withAlpha(200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              status.label,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: Text("${context.localized.season(1)} $seasonNumber")),
                            if (season.episodeCount != null)
                              Expanded(
                                child: Text(
                                  '${season.episodeCount} ${context.localized.episode(season.episodeCount ?? 0)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                                      ),
                                ),
                              ),
                          ],
                        ),
                        if (seasonDownloads.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          SeasonDownloadProgressWidget(downloads: seasonDownloads),
                        ],
                      ],
                    ),
                  ),
                  if (season.posterPath != null)
                    ClipRRect(
                      borderRadius: FladderTheme.smallShape.borderRadius,
                      child: SizedBox(
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 0.67,
                          child: FladderImage(
                            image: season.posterPath == null
                                ? null
                                : ImageData(path: season.posterPath!, key: 'id${season.id}_season$seasonNumber'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          );
        }),
      ],
    );
  }
}
