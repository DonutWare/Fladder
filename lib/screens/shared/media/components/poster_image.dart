import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/shared/media/components/poster_overlays.dart';
import 'package:fladder/screens/shared/media/components/poster_placeholder.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

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
            border: Border.all(width: 1, color: Colors.white.withAlpha(45)),
          ),
          child: FladderImage(
            image: primaryPosters
                ? poster.images?.primary
                : poster.getPosters?.primary ?? poster.getPosters?.backDrop?.lastOrNull,
            placeHolder: PosterPlaceholder(item: poster),
          ),
        ),
        overlays: [
          if (selected == true)
            SelectedPosterOverlay(
              poster: poster,
              radius: radius as BorderRadius,
            ),
          BottomOverlaysContainer(
            showFavourite: poster.userData.isFavourite,
            showProgress: true,
            progress: poster.progress,
            itemType: poster.type,
            progressPadding: padding,
          ),
          if (inlineTitle)
            InlineTitleOverlay(
              title: poster.title.maxLength(limitTo: 25),
            ),
          UnplayedWatchedOverlay(
            poster: poster,
          ),
          VideoDurationOverlay(
            poster: poster,
            padding: padding,
          ),
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
