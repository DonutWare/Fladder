import 'package:flutter/material.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/util/localization_helper.dart';

class DownloadStatusLabel extends StatelessWidget {
  final SeerrDashboardPosterModel poster;
  final List<int>? filterSeasons;

  const DownloadStatusLabel({
    required this.poster,
    this.filterSeasons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final standardDownloads = poster.mediaInfo?.downloadStatus ?? [];
    final fourKDownloads = poster.mediaInfo?.downloadStatus4k ?? [];
    final allDownloads = [...standardDownloads, ...fourKDownloads];

    final relevantDownloads = filterSeasons != null && filterSeasons!.isNotEmpty
        ? allDownloads.where((d) => filterSeasons!.contains(d.episode?.seasonNumber)).toList()
        : allDownloads;

    num totalSize = 0;
    num totalRemaining = 0;

    for (final download in relevantDownloads) {
      if (download.size != null) {
        totalSize += download.size!;
        totalRemaining += download.sizeLeft ?? 0;
      }
    }

    final hasDownloads = totalSize > 0;
    final percentage = hasDownloads ? ((totalSize - totalRemaining) / totalSize) * 100 : 0.0;

    if (hasDownloads) {
      String downloadLabel = context.localized.processing;

      if (poster.type == SeerrDashboardMediaType.tv && relevantDownloads.isNotEmpty) {
        final firstDownload = relevantDownloads.first;
        final seasonNum = firstDownload.episode?.seasonNumber;
        final episodeNum = firstDownload.episode?.episodeNumber;

        if (seasonNum != null && episodeNum != null) {
          downloadLabel = '${context.localized.processing} S${seasonNum}E$episodeNum';
        }
      }

      return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 2,
                backgroundColor: theme.colorScheme.onPrimaryContainer.withAlpha(50),
                valueColor: AlwaysStoppedAnimation(
                  theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            Text(
              downloadLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: poster.displayStatusColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        poster.displayStatusLabel(context),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
