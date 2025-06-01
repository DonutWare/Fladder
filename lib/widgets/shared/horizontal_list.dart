import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/disable_keypad_focus.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/sticky_header_text.dart';

class HorizontalList<T> extends ConsumerStatefulWidget {
  final String? label;
  final List<Widget> titleActions;
  final Function()? onLabelClick;
  final String? subtext;
  final List<T> items;
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
  final GlobalKey _firstItemKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final contentPadding = 8.0;
  double? contentWidth;
  double? _firstItemWidth;

  @override
  void initState() {
    super.initState();
    _measureFirstItem(scrollTo: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _measureFirstItem({bool scrollTo = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.startIndex != null) {
        final context = _firstItemKey.currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          _firstItemWidth = box.size.width;
          if (scrollTo) {
            _scrollToPosition(widget.startIndex!);
          }
        }
      }
    });
  }

  void _scrollToPosition(int index) {
    final offset = index * _firstItemWidth! + index * contentPadding;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      (_firstItemWidth ?? 200) * widget.items.length + 200,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  int getFirstVisibleIndex() {
    if (widget.startIndex == null) return 0;
    if (!_scrollController.hasClients || _firstItemWidth == null) return 0;
    return (_scrollController.offset / _firstItemWidth!).floor().clamp(0, widget.items.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final hasPointer = AdaptiveLayout.of(context).inputDevice == InputDevice.pointer;
    final content = Column(
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
                                  _scrollController.animateTo(
                                      _scrollController.offset + -(MediaQuery.of(context).size.width / 1.75),
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
                                if (_firstItemWidth != null && widget.startIndex != null) {
                                  _scrollToPosition(widget.startIndex!);
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
                                  _scrollController.animateTo(
                                      _scrollController.offset + (MediaQuery.of(context).size.width / 1.75),
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
          height: (widget.height ??
              AdaptiveLayout.poster(context).size *
                  ref.watch(clientSettingsProvider.select((value) => value.posterSize))),
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: widget.contentPadding,
            itemBuilder: (context, index) => index == getFirstVisibleIndex()
                ? Container(
                    key: _firstItemKey,
                    child: widget.itemBuilder(context, index),
                  )
                : widget.itemBuilder(context, index),
            separatorBuilder: (context, index) => SizedBox(width: contentPadding),
            itemCount: widget.items.length,
          ),
        ),
      ],
    );
    return widget.startIndex == null
        ? content
        : LayoutBuilder(builder: (context, constraints) {
            _measureFirstItem();
            return content;
          });
  }
}
