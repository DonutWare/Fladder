import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/widgets/shared/status_card.dart';
import 'package:fladder/util/localization_helper.dart';

class SelectedPosterOverlay extends StatelessWidget {
  final ItemBaseModel poster;
  final BorderRadius radius;

  const SelectedPosterOverlay({
    required this.poster,
    required this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.15),
        border: Border.all(width: 3, color: Theme.of(context).colorScheme.primary),
        borderRadius: radius,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                poster.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FavouriteOverlay extends StatelessWidget {
  const FavouriteOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        StatusCard(
          color: Colors.red,
          child: Icon(
            IconsaxPlusBold.heart,
            size: 21,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class ProgressOverlay extends StatelessWidget {
  final double progress;
  final double height;
  final EdgeInsets padding;

  const ProgressOverlay({
    required this.progress,
    this.height = 7.5,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3).copyWith(bottom: 3).add(padding),
          child: Card(
            color: Colors.transparent,
            elevation: 3,
            shadowColor: Colors.transparent,
            child: LinearProgressIndicator(
              minHeight: height,
              backgroundColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.5),
              value: progress / 100,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

class UnplayedWatchedOverlay extends StatelessWidget {
  final ItemBaseModel poster;
  final EdgeInsets padding;

  const UnplayedWatchedOverlay({
    required this.poster,
    this.padding = const EdgeInsets.all(6),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (poster.unplayedLabel(context.localized) == null && !poster.watched) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: Align(
        alignment: Alignment.topRight,
        child: StatusCard(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: padding,
            child: poster.unplayedLabel(context.localized) != null
                ? Text(
                    poster.unplayedLabel(context.localized) ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                      fontSize: 14,
                    ),
                  )
                : Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
          ),
        ),
      ),
    );
  }
}

class VideoDurationOverlay extends StatelessWidget {
  final ItemBaseModel poster;
  final EdgeInsets padding;

  const VideoDurationOverlay({
    required this.poster,
    this.padding = const EdgeInsets.all(6),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (poster.overview.runTime == null) return const SizedBox.shrink();
    if (!(poster is PhotoModel && (poster as PhotoModel).internalType == FladderItemType.video)) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: padding,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  poster.overview.runTime?.humanizeSmall ?? "",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.play_arrow_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InlineTitleOverlay extends StatelessWidget {
  final String title;

  const InlineTitleOverlay({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class BottomOverlaysContainer extends StatelessWidget {
  final bool showFavourite;
  final bool showProgress;
  final double progress;
  final double progressHeight;
  final FladderItemType itemType;
  final EdgeInsets progressPadding;

  const BottomOverlaysContainer({
    required this.showFavourite,
    required this.showProgress,
    required this.progress,
    this.progressHeight = 7.5,
    required this.itemType,
    this.progressPadding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showFavourite) const FavouriteOverlay(),
          if (showProgress && (progress > 0 && progress < 100) && itemType != FladderItemType.book)
            ProgressOverlay(
              progress: progress,
              height: progressHeight,
              padding: progressPadding,
            ),
        ],
      ),
    );
  }
}
