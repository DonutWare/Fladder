import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/media/banner_play_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class CarouselBanner extends ConsumerStatefulWidget {
  final PageController? controller;
  final List<ItemBaseModel> items;
  final double maxHeight;
  const CarouselBanner({
    this.controller,
    required this.items,
    this.maxHeight = 250,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends ConsumerState<CarouselBanner> {
  final carouselController = CarouselController();
  bool showControls = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => showControls = true),
      onExit: (event) => setState(() => showControls = false),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.maxHeight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxExtent = (constraints.maxHeight * 2.1).clamp(
              250.0,
              (MediaQuery.sizeOf(context).shortestSide * 0.75).clamp(251.0, double.maxFinite),
            );
            final border = BorderRadius.circular(18);
            final itemExtent = widget.items.length == 1 ? MediaQuery.sizeOf(context).width : maxExtent;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4)
                  .copyWith(top: AdaptiveLayout.of(context).isDesktop ? 6 : 10),
              child: Stack(
                children: [
                  CarouselView(
                    elevation: 3,
                    shrinkExtent: 0,
                    controller: carouselController,
                    shape: RoundedRectangleBorder(borderRadius: border),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    enableSplash: false,
                    itemExtent: itemExtent,
                    children: [
                      ...widget.items.mapIndexed(
                        (index, item) => LayoutBuilder(builder: (context, constraints) {
                          final opacity = (constraints.maxWidth / maxExtent);
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              FladderImage(image: item.bannerImage),
                              Opacity(
                                opacity: opacity.clamp(0, 1),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topCenter,
                                            colors: [
                                              ThemesData.of(context)
                                                  .dark
                                                  .colorScheme
                                                  .primaryContainer
                                                  .withValues(alpha: 0.85),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0).copyWith(right: constraints.maxWidth * 0.2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        maxLines: 2,
                                        softWrap: item.title.length > 25,
                                        overflow: TextOverflow.fade,
                                        style:
                                            Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                                      ),
                                      if (item.label(context) != null || item.subText != null)
                                        Text(
                                          item.label(context) ?? item.subText ?? "",
                                          maxLines: 2,
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                                        ),
                                    ].addInBetween(const SizedBox(height: 4)),
                                  ),
                                ),
                              ),
                              FlatButton(
                                onTap: () => widget.items[index].navigateTo(context),
                                onLongPress: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer
                                    ? null
                                    : () {
                                        final poster = widget.items[index];
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
                                      },
                                onSecondaryTapDown: AdaptiveLayout.of(context).inputDevice == InputDevice.touch
                                    ? null
                                    : (details) async {
                                        Offset localPosition = details.globalPosition;
                                        RelativeRect position = RelativeRect.fromLTRB(localPosition.dx - 320,
                                            localPosition.dy, localPosition.dx, localPosition.dy);
                                        final poster = widget.items[index];

                                        await showMenu(
                                          context: context,
                                          position: position,
                                          items: poster.generateActions(context, ref).popupMenuItems(useIcons: true),
                                        );
                                      },
                              ),
                              BannerPlayButton(item: widget.items[index]),
                              IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.1),
                                        width: 1.0,
                                      ),
                                      borderRadius: border),
                                ),
                              ),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                  if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: showControls ? 1 : 0,
                      child: IgnorePointer(
                        ignoring: !showControls,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton.filledTonal(
                                  onPressed: () {
                                    final currentPos = carouselController.position;
                                    carouselController.animateTo(currentPos.pixels - itemExtent,
                                        curve: Curves.easeInOutCubic, duration: const Duration(milliseconds: 250));
                                  },
                                  icon: const Icon(IconsaxPlusLinear.arrow_left_1),
                                ),
                                IconButton.filledTonal(
                                  onPressed: () {
                                    final currentPos = carouselController.position;
                                    carouselController.animateTo(currentPos.pixels + itemExtent,
                                        curve: Curves.easeInOutCubic, duration: const Duration(milliseconds: 250));
                                  },
                                  icon: const Icon(IconsaxPlusLinear.arrow_right_3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
