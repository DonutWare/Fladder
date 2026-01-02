import 'package:flutter/material.dart';

import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';

class SeasonDownloadProgressWidget extends StatelessWidget {
  final List<SeerrDownloadStatus> downloads;

  const SeasonDownloadProgressWidget({
    required this.downloads,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int totalSize = 0;
    int totalRemaining = 0;

    for (final download in downloads) {
      if (download.size != null) {
        totalSize += download.size!;
        totalRemaining += download.sizeLeft ?? 0;
      }
    }

    if (totalSize == 0) return const SizedBox.shrink();

    final percentage = ((totalSize - totalRemaining) / totalSize) * 100;
    final episodeCount = downloads.length;

    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          children: [
            Expanded(
              child: Text(
                '${context.localized.downloading.capitalize()}: $episodeCount ${context.localized.episode(episodeCount).toLowerCase()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 4,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
