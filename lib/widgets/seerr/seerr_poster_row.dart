import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class SeerrPosterRow extends ConsumerWidget {
  final List<SeerrDashboardPosterModel> posters;
  final String label;
  final EdgeInsets contentPadding;
  final Widget? Function(SeerrDashboardPosterModel poster)? subtitleBuilder;
  final void Function(SeerrDashboardPosterModel poster)? onTap;
  final void Function(SeerrDashboardPosterModel focused)? onFocused;
  final void Function()? onLabelClick;

  const SeerrPosterRow({
    required this.posters,
    required this.label,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.subtitleBuilder,
    this.onTap,
    this.onFocused,
    this.onLabelClick,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep the same dominant ratio behavior as PosterRow for non-primary posters.
    const dominantRatio = 0.55;

    return HorizontalList<SeerrDashboardPosterModel>(
      contentPadding: contentPadding,
      label: label,
      autoFocus: ref.read(argumentsStateProvider).htpcMode ? FocusProvider.autoFocusOf(context) : false,
      onLabelClick: onLabelClick,
      dominantRatio: dominantRatio,
      items: posters,
      onFocused: (index) {
        if (onFocused != null) {
          onFocused?.call(posters[index]);
        } else {
          context.ensureVisible();
        }
      },
      itemBuilder: (context, index) {
        final poster = posters[index];
        return _SeerrPosterTile(
          key: Key(poster.id),
          poster: poster,
          aspectRatio: dominantRatio,
          subTitle: subtitleBuilder?.call(poster),
          onTap: onTap,
        );
      },
    );
  }
}

class _SeerrPosterTile extends StatelessWidget {
  final SeerrDashboardPosterModel poster;
  final double aspectRatio;
  final Widget? subTitle;
  final void Function(SeerrDashboardPosterModel poster)? onTap;

  const _SeerrPosterTile({
    required this.poster,
    required this.aspectRatio,
    this.subTitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radius = FladderTheme.smallShape.borderRadius;
    final opacity = 0.65;

    ImageData? image = poster.images.primary;
    image ??= poster.images.backDrop?.lastOrNull;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: FocusButton(
              onTap: () => onTap?.call(poster),
              child: ClipRRect(
                borderRadius: radius,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
                  ),
                  child: FladderImage(
                    image: image,
                    placeHolder: Center(
                      child: Text(
                        poster.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ExcludeFocus(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  poster.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (subTitle != null)
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold).copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: opacity),
                            ) ??
                        const TextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: subTitle!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
