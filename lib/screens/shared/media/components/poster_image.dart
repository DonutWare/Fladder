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

class PosterImage extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => _PosterImageState();
}

class _PosterImageState extends ConsumerState<PosterImage> {
  final tag = UniqueKey();
  void pressedWidget(BuildContext context) async {
    if (widget.onPressed != null) {
      widget.onPressed?.call(() async {
        await navigateToDetails();
        context.refreshData();
      }, widget.poster);
    } else {
      await navigateToDetails();
      if (!context.mounted) return;
      context.refreshData();
    }
  }

  Future<void> navigateToDetails() async {
    await widget.poster.navigateTo(context, ref: ref, tag: tag);
  }

  final posterRadius = FladderTheme.smallShape.borderRadius;

  @override
  Widget build(BuildContext context) {
    final poster = widget.poster;
    final padding = const EdgeInsets.all(5);

    return Hero(
      tag: tag,
      child: FocusButton(
        onTap: () => pressedWidget(context),
        onFocusChanged: widget.onFocusChanged,
        onLongPress: () {
          showBottomSheetPill(
            context: context,
            item: widget.poster,
            content: (scrollContext, scrollController) => ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: widget.poster
                  .generateActions(
                    context,
                    ref,
                    exclude: widget.excludeActions,
                    otherActions: widget.otherActions,
                    onUserDataChanged: widget.onUserDataChanged,
                    onDeleteSuccesFully: widget.onItemRemoved,
                    onItemUpdated: widget.onItemUpdated,
                  )
                  .listTileItems(scrollContext, useIcons: true),
            ),
          );
        },
        onSecondaryTapDown: (details) async {
          Offset localPosition = details.globalPosition;
          RelativeRect position =
              RelativeRect.fromLTRB(localPosition.dx, localPosition.dy, localPosition.dx, localPosition.dy);
          await showMenu(
            context: context,
            position: position,
            items: widget.poster
                .generateActions(
                  context,
                  ref,
                  exclude: widget.excludeActions,
                  otherActions: widget.otherActions,
                  onUserDataChanged: widget.onUserDataChanged,
                  onDeleteSuccesFully: widget.onItemRemoved,
                  onItemUpdated: widget.onItemUpdated,
                )
                .popupMenuItems(useIcons: true),
          );
        },
        child: Card(
          elevation: 6,
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: Colors.white.withValues(alpha: 0.10),
            ),
            borderRadius: posterRadius,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FladderImage(
                image: widget.primaryPosters
                    ? widget.poster.images?.primary
                    : widget.poster.getPosters?.primary ?? widget.poster.getPosters?.backDrop?.lastOrNull,
                placeHolder: PosterPlaceholder(item: widget.poster),
              ),
              if (poster.userData.progress > 0 && widget.poster.type == FladderItemType.book)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: padding,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.5),
                        child: Text(
                          context.localized.page((widget.poster as BookModel).currentPage),
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
              if (widget.selected == true)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.15),
                    border: Border.all(width: 3, color: Theme.of(context).colorScheme.primary),
                    borderRadius: posterRadius,
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
                            widget.poster.name,
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
                    if (widget.poster.userData.isFavourite)
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
                        widget.poster.type != FladderItemType.book) ...{
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
              if (widget.inlineTitle)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.poster.title.maxLength(limitTo: 25),
                      style:
                          Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              if ((widget.poster.unPlayedItemCount != null && widget.poster is SeriesModel) ||
                  (widget.poster.playAble && !widget.poster.unWatched && widget.poster is! PhotoAlbumModel))
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: StatusCard(
                      color: Theme.of(context).colorScheme.primary,
                      useFittedBox: widget.poster.unPlayedItemCount != 0,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: widget.poster.unPlayedItemCount != 0
                            ? Container(
                                constraints: const BoxConstraints(minWidth: 16),
                                child: Text(
                                  widget.poster.userData.unPlayedItemCount.toString(),
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
              if (widget.poster.overview.runTime != null &&
                  ((widget.poster is PhotoModel) &&
                      (widget.poster as PhotoModel).internalType == FladderItemType.video)) ...{
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
                              widget.poster.overview.runTime.humanizeSmall ?? "",
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
          ),
        ),
        overlays: [
          //Poster Button
          if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer) ...[
            //  Play Button
            if (widget.poster.playAble)
              Align(
                alignment: Alignment.center,
                child: IconButton.filledTonal(
                  onPressed: () => widget.playVideo?.call(false),
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
                    tooltip: "Options",
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => widget.poster
                        .generateActions(
                          context,
                          ref,
                          exclude: widget.excludeActions,
                          otherActions: widget.otherActions,
                          onUserDataChanged: widget.onUserDataChanged,
                          onDeleteSuccesFully: widget.onItemRemoved,
                          onItemUpdated: widget.onItemUpdated,
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
}
