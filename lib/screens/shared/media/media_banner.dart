import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/media/banner_play_button.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    final overlayColor = ThemesData.of(context).dark.colorScheme.primaryContainer;
    final shadows = [
      BoxShadow(blurRadius: 12, spreadRadius: 8, color: overlayColor),
    ];
    final currentItem = widget.items[currentPage.clamp(0, widget.items.length - 1)];
    final double dragOpacity = (1 - dragOffset.abs()).clamp(0, 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.maxHeight),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              surfaceTintColor: overlayColor,
              color: overlayColor,
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
                                  color: Colors.white.withValues(alpha: 0.10),
                                  strokeAlign: BorderSide.strokeAlignInside),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topCenter,
                                colors: [
                                  overlayColor.withValues(alpha: 0.85),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
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
                                FlatButton(
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
                                              children: poster
                                                  .generateActions(context, ref)
                                                  .listTileItems(scrollContext, useIcons: true),
                                            ),
                                          );
                                          interacting = false;
                                          timer.reset();
                                        }
                                      : null,
                                  onSecondaryTapDown: AdaptiveLayout.of(context).inputDevice == InputDevice.touch
                                      ? null
                                      : (details) async {
                                          Offset localPosition = details.globalPosition;
                                          RelativeRect position = RelativeRect.fromLTRB(localPosition.dx - 320,
                                              localPosition.dy, localPosition.dx, localPosition.dy);
                                          final poster = currentItem;

                                          await showMenu(
                                            context: context,
                                            position: position,
                                            items: poster.generateActions(context, ref).popupMenuItems(useIcons: true),
                                          );
                                        },
                                ),
                              ],
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
                                        if (currentItem.label(context) != null || currentItem.subText != null)
                                          Flexible(
                                            child: Text(
                                              currentItem.label(context) ?? currentItem.subText ?? "",
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    shadows: shadows,
                                                    color: Colors.white.withValues(alpha: 0.75),
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
                    BannerPlayButton(item: currentItem),
                  ],
                ),
              ),
            ),
          ),
          if (widget.items.length > 1)
            FractionallySizedBox(
              widthFactor: 0.35,
              child: FladderSlider(
                value: currentPage.toDouble(),
                min: 0,
                animation: const Duration(milliseconds: 250),
                thumbWidth: 24,
                activeTrackColor: Theme.of(context).colorScheme.surfaceDim,
                inactiveTrackColor: Theme.of(context).colorScheme.surfaceDim,
                max: widget.items.length.toDouble() - 1,
                onChanged: (value) => setState(() => currentPage = value.toInt()),
              ),
            )
          else
            const SizedBox(height: 24)
        ],
      ),
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

class RoundedTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isDiscrete = false,
      bool isEnabled = false,
      double additionalActiveTrackHeight = 0}) {
    super.paint(context, offset,
        parentBox: parentBox,
        sliderTheme: sliderTheme,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumbCenter: thumbCenter,
        secondaryOffset: secondaryOffset,
        isDiscrete: isDiscrete,
        isEnabled: isEnabled,
        additionalActiveTrackHeight: additionalActiveTrackHeight);
  }
}
