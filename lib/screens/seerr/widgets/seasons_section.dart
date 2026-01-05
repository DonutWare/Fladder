import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr/seerr_request_provider.dart';
import 'package:fladder/screens/seerr/widgets/season_download_progress_widget.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class SeerrSeasonsSection extends ConsumerWidget {
  final SeerrDashboardPosterModel model;
  final SeerrRequestModel requestState;
  final List<SeerrSeason> seasons;
  final Map<int, SeerrMediaStatus> seasonStatuses;

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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Text(
          context.localized.season(seasons.length),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        ...seasons.map(
          (season) {
            final seasonNumber = season.seasonNumber;
            if (seasonNumber == null) return const SizedBox.shrink();
            final locked = requestState.isRequestedAlready(seasonNumber);
            final selected = requestState.selectedSeasons[seasonNumber] ?? false;
            final status = seasonStatuses[seasonNumber];
            final seasonDownloads =
                model.mediaInfo?.downloadStatus?.where((d) => d.episode?.seasonNumber == seasonNumber).toList() ?? [];

            return Builder(builder: (context) {
              return FocusButton(
                onTap: locked
                    ? null
                    : () {
                        notifier.toggleSeason(seasonNumber, !selected);
                      },
                onFocusChanged: (focus) {
                  if (focus) {
                    context.ensureVisible();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
                        : Theme.of(context).colorScheme.tertiaryContainer.withValues(alpha: 0.3),
                    borderRadius: FladderTheme.smallShape.borderRadius,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    spacing: 12,
                    children: [
                      ExcludeFocusTraversal(
                        child: Checkbox(
                            value: selected,
                            onChanged: locked
                                ? null
                                : (value) {
                                    if (value == null) return;
                                    notifier.toggleSeason(seasonNumber, value);
                                  }),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (status != null && status != SeerrMediaStatus.unknown)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: status.color.withAlpha(200),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  status.label(context),
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
                                            color:
                                                Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
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
                      if (season.posterUrl != null)
                        ClipRRect(
                          borderRadius: FladderTheme.smallShape.borderRadius,
                          child: SizedBox(
                            height: 100,
                            child: AspectRatio(
                              aspectRatio: 0.67,
                              child: FladderImage(
                                image: season.posterUrl == null
                                    ? null
                                    : ImageData(path: season.posterUrl!, key: 'id${season.id}_season$seasonNumber'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
        FilledButton(
          onPressed: () => notifier.selectAllSeasons(),
          child: Text(context.localized.requestAll),
        )
      ],
    );
  }
}
