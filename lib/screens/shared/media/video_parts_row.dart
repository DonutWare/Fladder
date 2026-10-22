import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/items/video_part_model.dart';
import 'package:fladder/models/playback/multipart_playback.dart';
import 'package:fladder/providers/connectivity_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';
import 'package:fladder/widgets/shared/status_card.dart';

/// Displays every part of a multi-part movie or episode, with Part 1 being the
/// main item itself.
///
/// Only rendered when the item actually has multiple parts and the additional
/// parts could be loaded.
class VideoPartsRow extends ConsumerWidget {
  final ItemBaseModel mainItem;
  final List<VideoPartModel> parts;
  final EdgeInsets contentPadding;

  const VideoPartsRow({
    required this.mainItem,
    required this.parts,
    required this.contentPadding,
    super.key,
  });

  List<ItemBaseModel> get allParts => [mainItem, ...parts];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = allParts;
    if (items.length < 2) return const SizedBox.shrink();

    final totalDuration = items
        .map((item) => item.overview.runTime ?? Duration.zero)
        .fold(Duration.zero, (total, runtime) => total + runtime);

    final group = MultipartGroup.fromMain(mainItem, parts);
    final aggregateProgress = group?.aggregateProgressForDisplay;

    final runtimeLabel = totalDuration > Duration.zero ? totalDuration.humanize : null;
    final label = [
      context.localized.parts(items.length),
      if (runtimeLabel != null && runtimeLabel.isNotEmpty) runtimeLabel,
      if (aggregateProgress != null && aggregateProgress > 0) '${aggregateProgress.round()}%',
    ].join(' • ');

    return HorizontalList(
      label: label,
      contentPadding: contentPadding,
      height: AdaptiveLayout.poster(context).gridRatio,
      items: items,
      itemBuilder: (context, index) {
        final item = items[index];
        final isFirstPart = index == 0;
        final played = isFirstPart && group != null ? group.part1Played : item.userData.played;
        final progress = isFirstPart && group != null
            ? (group.part1Played ? 1.0 : (item.userData.progress / 100).clamp(0.0, 1.0))
            : (item.userData.progress / 100).clamp(0.0, 1.0);

        return VideoPartPoster(
          item: item,
          partNumber: index + 1,
          fallbackImages: mainItem.images,
          played: played,
          progress: progress,
          onTap: () => item.play(
            context,
            ref,
            startPosition:
                isFirstPart && group != null && group.part1Played ? Duration.zero : item.userData.playBackPosition,
          ),
        );
      },
    );
  }
}

class VideoPartPoster extends ConsumerWidget {
  final ItemBaseModel item;
  final int partNumber;
  final ImagesData? fallbackImages;
  final bool played;
  final double progress;
  final VoidCallback onTap;

  const VideoPartPoster({
    required this.item,
    required this.partNumber,
    required this.fallbackImages,
    required this.played,
    required this.progress,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.localized;
    final isOffline = ref.watch(offlineStateProvider);
    final syncedItem = ref.watch(syncedItemProvider(item)).valueOrNull;

    // A part is only playable offline once its file has finished downloading.
    final unavailable = isOffline && (syncedItem == null || !syncedItem.videoFile.existsSync());
    final playable = item.playAble && !unavailable;

    final image = item.images?.primary ?? item.getPosters?.primary ?? fallbackImages?.primary;
    final runtime = item.overview.runTime;

    final placeHolder = Container(
      height: double.infinity,
      child: const Icon(Icons.movie_outlined),
    );

    return AspectRatio(
      aspectRatio: 1.76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FocusButton(
              onTap: playable ? onTap : null,
              child: Hero(
                tag: UniqueKey(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: FladderTheme.smallShape.borderRadius,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  foregroundDecoration: FladderTheme.defaultPosterDecoration,
                  child: FladderImage(
                    image: image,
                    placeHolder: placeHolder,
                    blurOnly: unavailable,
                  ),
                ),
              ),
              overlays: [
                Align(
                  alignment: Alignment.topLeft,
                  child: StatusCard(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Text(
                        l10n.part(partNumber),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (unavailable)
                        const StatusCard(
                          color: Colors.orangeAccent,
                          child: Icon(IconsaxPlusLinear.cloud_cross),
                        ),
                      if (played)
                        StatusCard(
                          color: Theme.of(context).colorScheme.primary,
                          child: const Icon(Icons.check_rounded),
                        ),
                    ],
                  ),
                ),
                if (progress > 0 && !played)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      minHeight: 6,
                      backgroundColor: Colors.black.withValues(alpha: 0.75),
                      value: progress,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: Text(
                  l10n.part(partNumber),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (runtime != null && runtime.inSeconds > 1) ...[
                const SizedBox(width: 4),
                Text(
                  runtime.humanize ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
