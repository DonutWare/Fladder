import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class SeerrPosterCard extends ConsumerWidget {
  final SeerrDashboardPosterModel poster;
  final double? aspectRatio;
  final void Function(SeerrDashboardPosterModel poster)? onTap;
  final void Function(SeerrDashboardPosterModel poster)? onRequestAddTap;

  const SeerrPosterCard({
    required this.poster,
    this.aspectRatio,
    this.onTap,
    this.onRequestAddTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = FladderTheme.smallShape.borderRadius;

    ImageData? image = poster.images.primary;
    image ??= poster.images.backDrop?.lastOrNull;

    final user = ref.watch(seerrUserProvider);
    final canRequest = user?.canRequestMedia(isTv: poster.type == SeerrDashboardMediaType.tv) ?? true;

    final baseItemModel = poster.itemBaseModel;
    void handleRequestAction() {
      if (onRequestAddTap != null) {
        onRequestAddTap?.call(poster);
      } else {
        openSeerrRequestPopup(context, poster);
      }
    }

    final List<ItemAction> itemActions = [
      if (poster.status != SeerrRequestStatus.unknown || poster.id.isNotEmpty)
        ItemActionButton(
          icon: const Icon(IconsaxPlusBold.folder_open),
          label: Text(context.localized.viewRequest),
          action: () => openSeerrRequestPopup(context, poster),
        ),
      if (poster.status == SeerrRequestStatus.unknown && canRequest)
        ItemActionButton(
          icon: const Icon(IconsaxPlusBold.add),
          label: Text(context.localized.request),
          action: handleRequestAction,
        ),
      if (baseItemModel != null)
        ItemActionButton(
          icon: Icon(baseItemModel.type.icon),
          label: Text(context.localized.showDetails),
          action: () => baseItemModel.navigateTo(context),
        ),
    ];

    Widget content = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FocusButton(
            onTap: onTap != null
                ? () => onTap?.call(poster)
                : baseItemModel != null
                    ? () => baseItemModel.navigateTo(context)
                    : handleRequestAction,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: radius,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
              ),
              clipBehavior: Clip.hardEdge,
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
            onSecondaryTapDown: (details) => _showContextMenu(context, itemActions, ref, details.globalPosition),
            onLongPress: () => _showBottomSheet(context, itemActions, ref),
            focusedOverlays: [
              if (poster.status == SeerrRequestStatus.unknown && canRequest)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            onPressed: handleRequestAction,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  IconsaxPlusBold.add_square,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  size: 21,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  context.localized.request,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            overlays: [
              if (poster.status != SeerrRequestStatus.unknown)
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: poster.status.color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(
                          switch (poster.status) {
                            SeerrRequestStatus.available => IconsaxPlusLinear.import_3,
                            _ => Icons.remove_rounded,
                          },
                          size: 18,
                        ),
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
              const SizedBox(height: 4),
              Text(
                poster.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );

    if (aspectRatio != null) {
      content = AspectRatio(aspectRatio: aspectRatio!, child: content);
    }

    return content;
  }

  void _showBottomSheet(BuildContext context, List<ItemAction> itemActions, WidgetRef ref) {
    showBottomSheetPill(
      context: context,
      content: (scrollContext, scrollController) => ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: itemActions.listTileItems(scrollContext, useIcons: true),
      ),
    );
  }

  Future<void> _showContextMenu(
      BuildContext context, List<ItemAction> itemActions, WidgetRef ref, Offset globalPos) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: itemActions.popupMenuItems(
        useIcons: true,
      ),
    );
  }
}
