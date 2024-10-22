import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/shared/fladder_carousel.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class MediaBanner extends ConsumerStatefulWidget {
  final PageController? controller;
  final List<ItemBaseModel> items;
  final double maxHeight;

  const MediaBanner({
    this.controller,
    required this.items,
    this.maxHeight = 250,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MediaBannerState();
}

class _MediaBannerState extends ConsumerState<MediaBanner> {
  bool showControls = false;
  bool interacting = false;
  int currentPage = 0;
  double dragOffset = 0;
  double dragIntensity = 1;
  double slidePosition = 1;

  late final RestartableTimer timer = RestartableTimer(const Duration(seconds: 8), () => nextSlide());

  @override
  void initState() {
    super.initState();
    timer.reset();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void nextSlide() {
    if (!interacting) {
      setState(() {
        if (currentPage == widget.items.length - 1) {
          currentPage = 0;
        } else {
          currentPage++;
        }
      });
    }
    timer.reset();
  }

  void previousSlide() {
    if (!interacting) {
      setState(() {
        if (currentPage == 0) {
          currentPage = widget.items.length - 1;
        } else {
          currentPage--;
        }
      });
    }
    timer.reset();
  }

  final controller = FladderCarouselController();

  @override
  Widget build(BuildContext context) {
    final overlayColor = ThemesData.of(context).dark.colorScheme.onSecondary;
    final shadows = [
      BoxShadow(blurRadius: 12, spreadRadius: 8, color: overlayColor),
    ];
    final currentItem = widget.items[currentPage.clamp(0, widget.items.length - 1)];
    final actions = currentItem.generateActions(context, ref);
    final double dragOpacity = (1 - dragOffset.abs()).clamp(0, 1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: Card(
            elevation: 16,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            surfaceTintColor: overlayColor,
            color: overlayColor,
            child: GestureDetector(
              onTap: () => currentItem.navigateTo(context),
              onLongPress: AdaptiveLayout.of(context).inputDevice == InputDevice.touch
                  ? () async {
                      interacting = true;
                      final poster = currentItem;
                      showBottomSheetPill(
                        context: context,
                        item: poster,
                        content: (scrollContext, scrollController) => ListView(
                          shrinkWrap: true,
                          controller: scrollController,
                          children: poster.generateActions(context, ref).listTileItems(scrollContext, useIcons: true),
                        ),
                      );
                      interacting = false;
                      timer.reset();
                    }
                  : null,
              child: MouseRegion(
                onEnter: (event) => setState(() => showControls = true),
                onHover: (event) => timer.reset(),
                onExit: (event) => setState(() => showControls = false),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Dismissible(
                      key: const Key("Dismissable"),
                      direction: DismissDirection.horizontal,
                      onUpdate: (details) {
                        setState(() {
                          dragOffset = details.progress * 4;
                        });
                      },
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          previousSlide();
                        } else {
                          nextSlide();
                        }
                        return false;
                      },
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 125),
                        opacity: dragOpacity.abs(),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 125),
                          child: Container(
                            key: Key(currentItem.id),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.10), strokeAlign: BorderSide.strokeAlignInside),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topCenter,
                                colors: [
                                  overlayColor.withOpacity(1),
                                  overlayColor.withOpacity(0.75),
                                  overlayColor.withOpacity(0.45),
                                  overlayColor.withOpacity(0.15),
                                  overlayColor.withOpacity(0),
                                  overlayColor.withOpacity(0),
                                  overlayColor.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: FladderImage(
                                  fit: BoxFit.cover,
                                  image: currentItem.bannerImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: IgnorePointer(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            currentItem.title,
                                            maxLines: 2,
                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                  shadows: shadows,
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                        if (currentItem.label(context) != null && currentItem is! MovieModel)
                                          Flexible(
                                            child: Text(
                                              currentItem.label(context)!,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    shadows: shadows,
                                                    color: Colors.white.withOpacity(0.75),
                                                  ),
                                            ),
                                          ),
                                        if (currentItem.overview.summary.isNotEmpty &&
                                            AdaptiveLayout.layoutOf(context) != LayoutState.phone)
                                          Flexible(
                                            child: Text(
                                              currentItem.overview.summary,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    shadows: shadows,
                                                    color: Colors.white.withOpacity(0.75),
                                                  ),
                                            ),
                                          ),
                                      ].addInBetween(const SizedBox(height: 6)),
                                    ),
                                  ),
                                ),
                              ].addInBetween(const SizedBox(height: 16)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: AnimatedOpacity(
                            opacity: showControls ? 1 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton.filledTonal(
                                  onPressed: () => nextSlide(),
                                  icon: const Icon(IconsaxOutline.arrow_right_3),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Card(
                            child: PopupMenuButton(
                              onOpened: () => interacting = true,
                              onCanceled: () {
                                interacting = false;
                                timer.reset();
                              },
                              itemBuilder: (context) => actions.popupMenuItems(useIcons: true),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            final delta = (details.primaryDelta ?? 0) / 20;
            slidePosition += delta;
            if (slidePosition > 1) {
              nextSlide();
              slidePosition = 0;
            } else if (slidePosition < -1) {
              previousSlide();
              slidePosition = 0;
            }
          },
          onHorizontalDragStart: (details) {
            slidePosition = 0;
          },
          child: Container(
            color: Colors.black.withOpacity(0),
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: widget.items.mapIndexed((index, e) {
                  return Tooltip(
                    message: '${e.name}\n${e.detailedName}',
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: InkWell(
                        onTapUp: currentPage == index
                            ? null
                            : (details) {
                                animateToTarget(index);
                                timer.reset();
                              },
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.red.withOpacity(0),
                          width: 28,
                          height: 28,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 125),
                            width: currentItem == e ? 22 : 6,
                            height: currentItem == e ? 10 : 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: currentItem == e
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.primary.withOpacity(0.25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  void animateToTarget(int nextIndex) {
    int step = currentPage < nextIndex ? 1 : -1;
    void updateItem(int item) {
      Future.delayed(Duration(milliseconds: 64 ~/ ((currentPage - nextIndex).abs() / 3)), () {
        setState(() {
          currentPage = item;
        });

        if (currentPage != nextIndex) {
          updateItem(item + step);
        }
      });
      timer.reset();
    }

    updateItem(currentPage + step);
  }
}
