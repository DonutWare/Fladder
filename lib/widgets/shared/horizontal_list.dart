import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/sticky_header_text.dart';

class HorizontalList extends ConsumerStatefulWidget {
  final String? label;
  final List<Widget> titleActions;
  final Function()? onLabelClick;
  final String? subtext;
  final List items;
  final int? startIndex;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final bool scrollToEnd;
  final EdgeInsets contentPadding;
  final double? height;
  final bool shrinkWrap;
  const HorizontalList({
    required this.items,
    required this.itemBuilder,
    this.startIndex,
    this.height,
    this.label,
    this.titleActions = const [],
    this.onLabelClick,
    this.scrollToEnd = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.subtext,
    this.shrinkWrap = false,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends ConsumerState<HorizontalList> {
  final itemScrollController = ItemScrollController();
  late final scrollOffsetController = ScrollOffsetController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (widget.startIndex != null) {
        itemScrollController.jumpTo(index: widget.startIndex!);
        scrollOffsetController.animateScroll(
            offset: -widget.contentPadding.left, duration: const Duration(milliseconds: 125));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToStart() {
    itemScrollController.scrollTo(index: 0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  void _scrollToEnd() {
    itemScrollController.scrollTo(
        index: widget.items.length, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final hasPointer = AdaptiveLayout.of(context).inputDevice == InputDevice.pointer;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DisableFocus(
          child: Padding(
            padding: widget.contentPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.label != null)
                        Flexible(
                          child: StickyHeaderText(
                            label: widget.label ?? "",
                            onClick: widget.onLabelClick,
                          ),
                        ),
                      if (widget.subtext != null)
                        Flexible(
                          child: Opacity(
                            opacity: 0.5,
                            child: Text(
                              widget.subtext!,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ...widget.titleActions
                    ],
                  ),
                ),
                if (widget.items.length > 1)
                  Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.surface,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (hasPointer)
                          GestureDetector(
                            onLongPress: () => _scrollToStart(),
                            child: IconButton(
                                onPressed: () {
                                  scrollOffsetController.animateScroll(
                                      offset: -(MediaQuery.of(context).size.width / 1.75),
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                },
                                icon: const Icon(
                                  IconsaxPlusLinear.arrow_left_1,
                                  size: 20,
                                )),
                          ),
                        if (widget.startIndex != null)
                          IconButton(
                              tooltip: "Scroll to current",
                              onPressed: () {
                                if (widget.startIndex != null) {
                                  itemScrollController.jumpTo(index: widget.startIndex!);
                                  scrollOffsetController.animateScroll(
                                      offset: -widget.contentPadding.left,
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOutQuad);
                                }
                              },
                              icon: const Icon(
                                Icons.circle,
                                size: 16,
                              )),
                        if (hasPointer)
                          GestureDetector(
                            onLongPress: () => _scrollToEnd(),
                            child: IconButton(
                                onPressed: () {
                                  scrollOffsetController.animateScroll(
                                      offset: (MediaQuery.of(context).size.width / 1.75),
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut);
                                },
                                icon: const Icon(
                                  IconsaxPlusLinear.arrow_right_3,
                                  size: 20,
                                )),
                          ),
                      ],
                    ),
                  ),
              ].addPadding(const EdgeInsets.symmetric(horizontal: 6)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: widget.height ??
              AdaptiveLayout.poster(context).size *
                  ref.watch(clientSettingsProvider.select((value) => value.posterSize)),
          child: ScrollablePositionedList.separated(
            shrinkWrap: widget.shrinkWrap,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            padding: widget.contentPadding,
            itemCount: widget.items.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
            itemBuilder: widget.itemBuilder,
          ),
        ),
      ],
    );
  }
}
