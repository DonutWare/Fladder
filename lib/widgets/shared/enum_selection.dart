import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/position_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class EnumBox<T> extends StatelessWidget {
  final String? current;
  final Widget? currentWidget;
  final bool autoFocus;
  final List<ItemAction> Function(BuildContext context) itemBuilder;
  final Function(bool focused)? onFocusChanged;

  const EnumBox({
    this.current,
    this.currentWidget,
    this.autoFocus = false,
    required this.itemBuilder,
    this.onFocusChanged,
    super.key,
  }) : assert(
            current != null || currentWidget != null, "At least one of 'current' or 'currentWidget' must be provided");

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    final itemList = itemBuilder(context);
    final useBottomSheet = AdaptiveLayout.inputDeviceOf(context) != InputDevice.pointer;

    final foreGroundColor = Theme.of(context).colorScheme.onPrimaryContainer;

    final hasMultipleItems = itemList.length > 1;

    final labelWidget = Padding(
      padding: padding,
      child: Material(
        textStyle: textStyle?.copyWith(fontWeight: FontWeight.bold, color: foreGroundColor),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: currentWidget != null
                  ? DefaultTextStyle.merge(
                      style: textStyle?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: foreGroundColor,
                      ),
                      child: currentWidget!,
                    )
                  : Text(current ?? "", textAlign: TextAlign.start),
            ),
            const SizedBox(width: 6),
            if (itemList.length > 1)
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )
          ],
        ),
      ),
    );
    final position = PositionProvider.of(context);
    final borderRadius = BorderRadius.horizontal(
      left:
          position == null || position == PositionContext.first ? const Radius.circular(16) : const Radius.circular(4),
      right:
          position == null || position == PositionContext.last ? const Radius.circular(16) : const Radius.circular(4),
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(hasMultipleItems ? 255 : 100),
        borderRadius: borderRadius,
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 1,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: useBottomSheet
          ? FocusButton(
              child: labelWidget,
              darkOverlay: false,
              autoFocus: autoFocus,
              borderRadius: borderRadius,
              onFocusChanged: onFocusChanged ??
                  (value) {
                    if (value) {
                      context.ensureVisible();
                    }
                  },
              onTap: itemList.length > 1
                  ? () => showBottomSheetPill(
                        context: context,
                        content: (context, scrollController) => ListView(
                          shrinkWrap: true,
                          controller: scrollController,
                          children: [
                            const SizedBox(height: 6),
                            ...itemList.map(
                              (e) => e.toListItem(context),
                            ),
                          ],
                        ),
                      )
                  : null,
            )
          : PopupMenuButton(
              tooltip: '',
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              enabled: itemList.length > 1,
              itemBuilder: (context) => itemList.map((e) => e.toPopupMenuItem()).toList(),
              padding: padding,
              child: labelWidget,
              requestFocus: true,
            ),
    );
  }
}

class EnumSelection<T> extends StatelessWidget {
  final Widget label;
  final String current;
  final Widget? currentWidget;
  final List<ItemAction> Function(BuildContext context) itemBuilder;
  const EnumSelection({
    super.key,
    required this.label,
    required this.current,
    this.currentWidget,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      textStyle: Theme.of(context).textTheme.titleMedium,
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.titleMedium,
              child: label,
            ),
            EnumBox(current: current, currentWidget: currentWidget, itemBuilder: itemBuilder),
          ].toList(),
        ),
      ),
    );
  }
}
