import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_popup.dart';
import 'package:fladder/screens/seerr/widgets/seerr_user_label.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class SeerrRequestBannerCard extends ConsumerWidget {
  final SeerrDashboardPosterModel poster;
  final void Function(SeerrDashboardPosterModel poster)? onTap;

  const SeerrRequestBannerCard({
    required this.poster,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = FladderTheme.smallShape.borderRadius;

    ImageData? backgroundImage = poster.images.backDrop?.firstOrNull;
    backgroundImage ??= poster.images.backDrop?.lastOrNull;

    ImageData? posterImage = poster.images.primary;
    posterImage ??= poster.images.backDrop?.lastOrNull;

    final user = ref.watch(seerrUserProvider);
    final canRequest = user?.canRequestMedia(isTv: poster.type == SeerrDashboardMediaType.tv) ?? true;
    final baseItemModel = poster.itemBaseModel;

    void openRequestDetails() {
      context.router.push(
        SeerrDetailsRoute(
          mediaType: poster.type == SeerrDashboardMediaType.tv ? 'tvshow' : 'movie',
          tmdbId: poster.tmdbId,
          poster: poster,
        ),
      );
    }

    void handleTapAction() {
      if (baseItemModel != null) {
        baseItemModel.navigateTo(context);
      } else {
        openRequestDetails();
      }
    }

    final List<ItemAction> itemActions = [
      if (poster.status != SeerrRequestStatus.unknown || poster.id.isNotEmpty)
        ItemActionButton(
          icon: const Icon(IconsaxPlusBold.folder_open),
          label: Text(context.localized.manageRequest),
          action: () => openRequestDetails(),
        ),
      if (canRequest)
        ItemActionButton(
          icon: const Icon(IconsaxPlusBold.add),
          label: Text(context.localized.request),
          action: () => openSeerrRequestPopup(context, poster),
        ),
      if (baseItemModel != null)
        ItemActionButton(
          icon: Icon(baseItemModel.type.icon),
          label: Text(context.localized.showDetails),
          action: () => baseItemModel.navigateTo(context),
        ),
    ];

    final requestedByUser = poster.requestedBy as SeerrUserModel?;
    final seasonsList = poster.requestedSeasons ?? [];

    final overlayColor = Theme.of(context).colorScheme.surfaceDim;

    return AspectRatio(
      aspectRatio: 1.2,
      child: FocusButton(
        onTap: onTap != null ? () => onTap?.call(poster) : () => handleTapAction(),
        onLongPress: () => _showBottomSheet(context, itemActions, ref),
        onSecondaryTapDown: (tap) => _showContextMenu(context, itemActions, ref, tap.globalPosition),
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (backgroundImage != null)
                FladderImage(
                  image: backgroundImage,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      overlayColor.withAlpha(220),
                      overlayColor.withAlpha(100),
                      overlayColor.withAlpha(50),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          if (poster.releaseYear?.isNotEmpty == true)
                            Text(
                              poster.releaseYear ?? '',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          Text(
                            poster.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          if (requestedByUser != null)
                            DefaultTextStyle(
                              child: SeerrUserLabel(user: requestedByUser),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          if (poster.type == SeerrDashboardMediaType.tv && seasonsList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${context.localized.season(seasonsList.length)}: ${seasonsList.join(', ')}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                              ),
                            ),
                          if (poster.status != SeerrRequestStatus.unknown)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: poster.status.color.withAlpha(200),
                                borderRadius: FladderTheme.smallShape.borderRadius,
                              ),
                              child: Text(
                                poster.status.label,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (posterImage != null)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: radius,
                          border: Border.all(width: 1.5, color: Colors.white.withAlpha(45)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: AspectRatio(
                          aspectRatio: 0.65,
                          child: SizedBox(
                            width: 105,
                            child: FladderImage(
                              image: posterImage,
                              fit: BoxFit.cover,
                              disableBlur: false,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
