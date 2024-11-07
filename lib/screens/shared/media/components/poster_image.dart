import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/book_model.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/items/series_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/media/components/poster_placeholder.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/fladder_image.dart';
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
  final bool heroTag;
  final bool? selected;
  final ValueChanged<bool>? playVideo;
  final bool inlineTitle;
  final Set<ItemActions> excludeActions;
  final List<ItemAction> otherActions;
  final Function(UserData? newData)? onUserDataChanged;
  final Function(ItemBaseModel newItem)? onItemUpdated;
  final Function(ItemBaseModel oldItem)? onItemRemoved;
  final Function(Function() action, ItemBaseModel item)? onPressed;
  const PosterImage({
    required this.poster,
    this.heroTag = false,
    this.selected,
    this.playVideo,
    this.inlineTitle = false,
    this.onItemUpdated,
    this.onItemRemoved,
    this.excludeActions = const {},
    this.otherActions = const [],
    this.onPressed,
    this.onUserDataChanged,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PosterImageState();
}

class _PosterImageState extends ConsumerState<PosterImage> {
  late String currentTag = widget.heroTag == true ? widget.poster.id : UniqueKey().toString();
  bool hover = false;

  void pressedWidget() async {
    if (widget.heroTag == false) {
      setState(() {
        currentTag = widget.poster.id;
      });
    }
    if (widget.onPressed != null) {
      widget.onPressed?.call(() async {
        await navigateToDetails();
        if (context.mounted) {
          context.refreshData();
        }
      }, widget.poster);
    } else {
      await navigateToDetails();
      if (context.mounted) {
        context.refreshData();
      }
    }
  }

  Future<void> navigateToDetails() async {
    await widget.poster.navigateTo(context);
  }

  @override
  Widget build(BuildContext context) {
    final poster = widget.poster;
    final padding = const EdgeInsets.all(5);
    return Hero(
      tag: currentTag,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: Card(
          elevation: 6,
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: Colors.white.withOpacity(0.10),
            ),
            borderRadius: FladderTheme.defaultShape.borderRadius,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FladderImage(
                image: widget.poster.getPosters?.primary ?? widget.poster.getPosters?.backDrop?.lastOrNull,
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
                    color: Colors.black.withOpacity(0.15),
                    border: Border.all(width: 3, color: Theme.of(context).colorScheme.primary),
                    borderRadius: FladderTheme.defaultShape.borderRadius,
                  ),
                  clipBehavior: Clip.antiAlias,
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
                              IconsaxBold.heart,
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
                            backgroundColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                            value: poster.userData.progress / 100,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    },
                  ],
                ),
              ),
              //Desktop overlay
              if (AdaptiveLayout.of(context).inputDevice != InputDevice.touch &&
                  widget.poster.type != FladderItemType.person)
                AnimatedOpacity(
                  opacity: hover ? 1 : 0,
                  duration: const Duration(milliseconds: 125),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //Hover color overlay
                      Container(
                          decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        border: Border.all(width: 3, color: Theme.of(context).colorScheme.primary),
                        borderRadius: FladderTheme.defaultShape.borderRadius,
                      )),
                      //Poster Button
                      Focus(
                        onFocusChange: (value) => setState(() => hover = value),
                        child: FlatButton(
                          onTap: pressedWidget,
                          onSecondaryTapDown: (details) async {
                            Offset localPosition = details.globalPosition;
                            RelativeRect position = RelativeRect.fromLTRB(
                                localPosition.dx - 320, localPosition.dy, localPosition.dx, localPosition.dy);
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
                        ),
                      ),
                      //Play Button
                      if (widget.poster.playAble)
                        DisableFocus(
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton.filledTonal(
                              onPressed: () => widget.playVideo?.call(false),
                              icon: const Icon(
                                IconsaxBold.play,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      DisableFocus(
                        child: Align(
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
                      ),
                    ],
                  ),
                )
              else
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: pressedWidget,
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
                  ),
                ),
              if (widget.poster.unWatched)
                Align(
                  alignment: Alignment.topLeft,
                  child: StatusCard(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
              if (widget.inlineTitle)
                IgnorePointer(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.poster.title.maxLength(limitTo: 25),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold, shadows: [
                          const BoxShadow(blurRadius: 8, spreadRadius: 16),
                          const BoxShadow(blurRadius: 2, spreadRadius: 16),
                        ]),
                      ),
                    ),
                  ),
                ),
              if (widget.poster.unPlayedItemCount != null && widget.poster is SeriesModel)
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
              }
            ],
          ),
        ),
      ),
    );
  }
}
