import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/widgets/shared/fladder_carousel.dart';
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
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxExtent = (constraints.maxHeight * 2.1).clamp(250.0, MediaQuery.sizeOf(context).shortestSide * 0.75);
          final border = BorderRadius.circular(18);
          return FladderCarousel(
            shape: RoundedRectangleBorder(borderRadius: border),
            onTap: (index) => widget.items[index].navigateTo(context),
            onLongPress: AdaptiveLayout.of(context).inputDevice == InputDevice.pointer
                ? null
                : (index) {
                    final poster = widget.items[index];
                    showBottomSheetPill(
                      context: context,
                      item: poster,
                      content: (scrollContext, scrollController) => ListView(
                        shrinkWrap: true,
                        controller: scrollController,
                        children: poster.generateActions(context, ref).listTileItems(scrollContext, useIcons: true),
                      ),
                    );
                  },
            onSecondaryTap: AdaptiveLayout.of(context).inputDevice == InputDevice.touch
                ? null
                : (details) async {
                    Offset localPosition = details.$2.globalPosition;
                    RelativeRect position = RelativeRect.fromLTRB(
                        localPosition.dx - 320, localPosition.dy, localPosition.dx, localPosition.dy);
                    final poster = widget.items[details.$1];

                    await showMenu(
                      context: context,
                      position: position,
                      items: poster.generateActions(context, ref).popupMenuItems(useIcons: true),
                    );
                  },
            itemExtent: maxExtent,
            children: [
              ...widget.items.mapIndexed(
                (index, e) => LayoutBuilder(builder: (context, constraints) {
                  final opacity = (constraints.maxWidth / maxExtent);
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FladderImage(image: e.bannerImage),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
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
                                      Theme.of(context).colorScheme.primaryContainer.withOpacity(0.75),
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
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                maxLines: 2,
                                softWrap: e.title.length > 25,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                              ),
                              if (e.label(context) != null)
                                Text(
                                  e.label(context)!,
                                  maxLines: 2,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                                ),
                            ].addInBetween(const SizedBox(height: 4)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1.0,
                            ),
                            borderRadius: border),
                      ),
                    ],
                  );
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
