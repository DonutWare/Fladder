import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/arguments_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class SeerrPosterRow extends ConsumerWidget {
  final List<SeerrDashboardPosterModel> posters;
  final String label;
  final EdgeInsets contentPadding;
  final void Function(SeerrDashboardPosterModel poster)? onTap;
  final void Function(SeerrDashboardPosterModel focused)? onFocused;
  final void Function()? onLabelClick;

  const SeerrPosterRow({
    required this.posters,
    required this.label,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.onTap,
    this.onFocused,
    this.onLabelClick,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onTap: onTap,
        );
      },
    );
  }
}

class _SeerrPosterTile extends StatelessWidget {
  final SeerrDashboardPosterModel poster;
  final double aspectRatio;
  final void Function(SeerrDashboardPosterModel poster)? onTap;

  const _SeerrPosterTile({
    required this.poster,
    required this.aspectRatio,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radius = FladderTheme.smallShape.borderRadius;

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
              overlays: [
                if (poster.status != SeerrRequestStatus.unknown)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: CircleAvatar(
                        backgroundColor: poster.status.color,
                        foregroundColor: Colors.white,
                        radius: 12,
                        child: Icon(
                          switch (poster.status) {
                            SeerrRequestStatus.available => IconsaxPlusBold.tick_circle,
                            _ => IconsaxPlusBold.minus_cirlce,
                          },
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        poster.type == SeerrDashboardMediaType.movie
                            ? context.localized.mediaTypeMovie(1)
                            : context.localized.mediaTypeSeries(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                      ),
                    ),
                  ),
                )
              ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
