// poster_image.dart
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/screens/shared/media/components/poster_placeholder.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/status_card.dart';

class PosterImage extends ConsumerWidget {
  final ItemBaseModel poster;
  final bool? selected;
  final ValueChanged<bool>? playVideo;
  final bool inlineTitle;
  final Set<ItemActions> excludeActions;
  final List<ItemAction> otherActions;
  final Function(UserData? newData)? onUserDataChanged;
  final Function(ItemBaseModel newItem)? onItemUpdated;
  final Function(ItemBaseModel oldItem)? onItemRemoved;
  final Function(Function() action, ItemBaseModel item)? onPressed;
  final bool primaryPosters;
  final Function(bool focus)? onFocusChanged;

  const PosterImage({
    required this.poster,
    this.selected,
    this.playVideo,
    this.inlineTitle = false,
    this.onItemUpdated,
    this.onItemRemoved,
    this.excludeActions = const {},
    this.otherActions = const [],
    this.onPressed,
    this.onUserDataChanged,
    this.primaryPosters = false,
    this.onFocusChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = FladderTheme.smallShape.borderRadius;
    final padding = const EdgeInsets.all(5);
    final myKey = key ?? UniqueKey();

    return Hero(
      tag: myKey,
      child: FocusButton(
        onTap: () async {
          if (onPressed != null) {
            onPressed?.call(() async {
              await poster.navigateTo(context, ref: ref, tag: myKey);
              context.refreshData();
            }, poster);
          } else {
            await poster.navigateTo(context, ref: ref, tag: myKey);
            if (!context.mounted) return;
            context.refreshData();
          }
        },
        onFocusChanged: onFocusChanged,
        onLongPress: () => _showBottomSheet(context, ref),
        onSecondaryTapDown: (details) => _showContextMenu(context, ref, details.globalPosition),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(width: 2, color: Colors.white.withAlpha(25)),
          ),
          child: FladderImage(
            image: primaryPosters
                ? poster.images?.primary
                : poster.getPosters?.primary ?? poster.getPosters?.backDrop?.lastOrNull,
            placeHolder: PosterPlaceholder(item: poster),
          ),
        ),
        overlays: [
          if (poster.userData.progress > 0 && poster.type == FladderItemType.book)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: padding,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.5),
                    child: Text(
                      context.localized.page((poster as BookModel).currentPage),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          if (selected == true)
            Container(
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
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (poster.userData.isFavourite)
                  const Row(
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
                  ),
                if ((poster.userData.progress > 0 && poster.userData.progress < 100) &&
                    poster.type != FladderItemType.book) ...{
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3).copyWith(bottom: 3).add(padding),
                    child: Card(
                      color: Colors.transparent,
                      elevation: 3,
                      shadowColor: Colors.transparent,
                      child: LinearProgressIndicator(
                        minHeight: 7.5,
                        backgroundColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.5),
                        value: poster.userData.progress / 100,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                },
              ],
            ),
          ),
          if (inlineTitle)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  poster.title.maxLength(limitTo: 25),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          if (poster is! PhotoAlbumModel && (poster.unPlayedItemCount != null && poster is SeriesModel) ||
              (poster.playAble && !poster.unWatched))
            IgnorePointer(
              child: Align(
                alignment: Alignment.topRight,
                child: StatusCard(
                  color: Theme.of(context).colorScheme.primary,
                  useFittedBox: poster.unPlayedItemCount != 0,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: poster.unPlayedItemCount != 0
                        ? Container(
                            constraints: const BoxConstraints(minWidth: 16),
                            child: Text(
                              poster.userData.unPlayedItemCount.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible,
                                fontSize: 14,
                              ),
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
            ),
          if (poster.overview.runTime != null &&
              ((poster is PhotoModel) && (poster as PhotoModel).internalType == FladderItemType.video)) ...{
            Align(
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
                          poster.overview.runTime.humanizeSmall ?? "",
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
            )
          },
        ],
        focusedOverlays: [
          if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer) ...[
            //  Play Button
            if (poster.playAble)
              Align(
                alignment: Alignment.center,
                child: IconButton.filledTonal(
                  onPressed: () => playVideo?.call(false),
                  icon: const Icon(
                    IconsaxPlusBold.play,
                    size: 32,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton(
                    tooltip: context.localized.options,
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => poster
                        .generateActions(
                          context,
                          ref,
                          exclude: excludeActions,
                          otherActions: otherActions,
                          onUserDataChanged: onUserDataChanged,
                          onDeleteSuccesFully: onItemRemoved,
                          onItemUpdated: onItemUpdated,
                        )
                        .popupMenuItems(useIcons: true),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    showBottomSheetPill(
      context: context,
      item: poster,
      content: (scrollContext, scrollController) => ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: poster
            .generateActions(
              context,
              ref,
              exclude: excludeActions,
              otherActions: otherActions,
              onUserDataChanged: onUserDataChanged,
              onDeleteSuccesFully: onItemRemoved,
              onItemUpdated: onItemUpdated,
            )
            .listTileItems(scrollContext, useIcons: true),
      ),
    );
  }

  Future<void> _showContextMenu(BuildContext context, WidgetRef ref, Offset globalPos) async {
    final position = RelativeRect.fromLTRB(globalPos.dx, globalPos.dy, globalPos.dx, globalPos.dy);
    await showMenu(
      context: context,
      position: position,
      items: poster
          .generateActions(
            context,
            ref,
            exclude: excludeActions,
            otherActions: otherActions,
            onUserDataChanged: onUserDataChanged,
            onDeleteSuccesFully: onItemRemoved,
            onItemUpdated: onItemUpdated,
          )
          .popupMenuItems(useIcons: true),
    );
  }
}
