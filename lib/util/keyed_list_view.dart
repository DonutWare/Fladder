import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class KeyedListView<K, T> extends ConsumerStatefulWidget {
  final Map<K, T> map;
  final Widget Function(BuildContext context, int index) itemBuilder;
  const KeyedListView({required this.map, required this.itemBuilder, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyedListViewState();
}

class _KeyedListViewState extends ConsumerState<KeyedListView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(() {
      if (currentIndex != itemPositionsListener.itemPositions.value.toList()[0].index) {
        setState(() {
          currentIndex = itemPositionsListener.itemPositions.value.toList()[0].index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ScrollablePositionedList.builder(
            itemCount: widget.map.length,
            itemBuilder: widget.itemBuilder,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
          ),
        ),
        const SizedBox(width: 8),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: widget.map.keys.mapIndexed(
              (index, e) {
                final atPosition = currentIndex == index;
                return Container(
                  decoration: BoxDecoration(
                    color: atPosition ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 28,
                  width: 28,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      iconColor: atPosition
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
                      foregroundColor: atPosition
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
                    ),
                    onPressed: () {
                      itemScrollController.scrollTo(
                        index: index,
                        duration: const Duration(seconds: 1),
                        opacityAnimationWeights: [20, 20, 60],
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: Text(
                      e,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
